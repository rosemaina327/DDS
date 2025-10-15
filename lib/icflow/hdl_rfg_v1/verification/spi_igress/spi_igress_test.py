import sys
import os

import cocotb
from cocotb.triggers    import Timer , RisingEdge
from cocotb.clock       import Clock

import vip.spi
from vip.spi            import VSPIMaster
from vip.axis           import VAXIS_Slave

async def clock_burst(clk):
    for cycle in range(10):
        clk.value = 0
        await Timer(1, units="ns")
        clk.value = 1
        await Timer(1, units="ns")

async def common_reset(dut):
    dut.resn.value = 0
    await Timer(1, units="us")
    dut.resn.value = 1
    await Timer(1, units="us")

@cocotb.test()
async def test_init(dut):

    ## Init VSPI
    spi = vip.spi.VSPIMaster(dut,dut.spi_clk,dut.spi_csn,dut.spi_mosi)
    axis_slave = VAXIS_Slave(dut)

    await common_reset(dut)

    ## Send a frame with AXIS Slave not ready
    res = await spi.send_frame([0xAB,0x00])
    print("Result: ",res)
    assert res == vip.spi.ResultCodes.OVERRUN
    dut._log.info("Test Finished")

    ## Send a Frame with Slave ready
    axis_slave.ready()
    assert await spi.send_frame([0xCD,0x00]) == vip.spi.ResultCodes.OK

    ## Send a long frame with Slave in receive mode
    pattern = [0xAB,0xAE,0xD4,0x00]
    axis_monitor = axis_slave.start_monitor()
    assert await spi.send_frame(pattern) == vip.spi.ResultCodes.OK
    axis_monitor.kill()
    print("Received bytes: ",axis_slave.data_queue.qsize())
    assert axis_slave.data_queue.qsize() == 3
    

    