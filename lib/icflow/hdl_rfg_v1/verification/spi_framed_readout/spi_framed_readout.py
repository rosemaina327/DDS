import sys
import os

import cocotb
from cocotb.triggers    import Timer , RisingEdge
from cocotb.clock       import Clock

import vip.spi
from vip.spi            import VSPIMaster
from vip.axis           import VAXIS_Slave

import rfg.io_spi 
from rfg.io_spi       import SPIBytesDecoder


rfg.io_spi .debug()

async def clock_burst(clk):
    for cycle in range(10):
        clk.value = 0
        await Timer(1, units="ns")
        clk.value = 1
        await Timer(1, units="ns")

async def common_reset(dut,spi):
    dut.resn.value = 0
    await Timer(1, units="us")
    await spi.send_frame([0x00],cs = False)
    await Timer(1, units="us")
    dut.resn.value = 1
    await Timer(1, units="us")

@cocotb.test()
async def test_init(dut):

    ## Init VSPI
    spi = vip.spi.VSPIMaster(dut,dut.spi_clk,dut.spi_csn,dut.spi_mosi,dut.spi_miso)
    #axis_slave = VAXIS_Slave(dut)

    await common_reset(dut,spi)

    #content = dir(dut)
    #dut._log.info("Done",content)
    #dut._log.info("ERR: ",content["err"])

    ## Check One byte returns a BC from MISO
    assert await spi.send_frame([0x00]) == vip.spi.ResultCodes.OK

    for i in range(spi.miso_queue.qsize()):
        dut._log.info("Found MISO Byte %x",await spi.miso_queue.get())
    

    ## Send RFG Frame Write
    pattern = [0x01,0x01,0x01,0x00,0xAB,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
    assert await spi.send_frame(pattern) == vip.spi.ResultCodes.OK
    assert dut.main_rfg_I.scratchpad1 == 0xAB

    ## Send RFG write with increment
    pattern = [0x05,0x00,0x02,0x00,0xAB,0xCD,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
    assert await spi.send_frame(pattern) == vip.spi.ResultCodes.OK
    assert dut.main_rfg_I.scratchpad0 == 0xAB
    assert dut.main_rfg_I.scratchpad1 == 0xCD


    ## Prepare Protocol decoder
    ###########
    spiDecoder = SPIBytesDecoder(spi.miso_queue)
    cocotb.start_soon(spiDecoder.start_protocol_decoding())

    ## Send RFG Frame Read
    #########
    pattern = [0x02,0x01,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
    assert await spi.send_frame(pattern) == vip.spi.ResultCodes.OK

    readBytes = spiDecoder.drainDecodedBytes()

    dut._log.info("Bytes in decoded queue: %d",len(readBytes))
    assert len(readBytes) == 1
    assert readBytes[0] == 0xcd

    #for i in range(spiDecoder.getDecodedBytesCount()):
    #    dut._log.info("Readout Byte %x",spiDecoder.decoded_bytes_queue.get())

    #dut._log.info("====")
    #for i in range(spi.miso_queue.qsize()):
    #    dut._log.info("Found MISO Byte %x",await spi.miso_queue.get())


    pattern = [0x06,0x00,0x02,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
    spiDecoder.expectReadLength(2)
    assert await spi.send_frame(pattern) == vip.spi.ResultCodes.OK

    dut._log.info("====")
    readBytes = spiDecoder.drainDecodedBytes()
    assert len(readBytes) == 2 , "Should have detected 2 bytes from the protocol decoder"
    assert readBytes[0] == 0xab
    assert readBytes[1] == 0xcd

    ## Now Read 2 bytes with target readout queue 3
    pattern = [0x36,0x00,0x02,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
    spiDecoder.expectReadLength(2)
    assert await spi.send_frame(pattern) == vip.spi.ResultCodes.OK

    
    

    