
import sys
import os
import random 
import numpy as n

import cocotb
from cocotb.triggers    import Timer , RisingEdge , FallingEdge
from cocotb.clock       import Clock

from vip.axis           import VAXIS_Slave , VAXIS_Master

import vip.ftdi

@cocotb.test(timeout_time = 300 , timeout_unit = "us")
async def write_data_with_pause(dut):

    dut.m_axis_almost_full.value = 0;
    dut.s_axis_almost_empty.value = 0;

    dut.resn.value = 0 
    ftdiVIP = vip.ftdi.FTDISyncFIFO(dut)
    slaveVIP = VAXIS_Slave(dut,     clk = dut.prog_clko,    queueSize = 8 )
    masterVIP = VAXIS_Master(dut,   clk = dut.prog_clko,    queueSize = 8)
    await Timer(5,"us")

    ## Deassert Reset
    dut.resn.value = 1
    await Timer(5,"us")
    ftdiVIP.start()
    slaveVIP.start_monitor()

    ## Send some bytes to FTDI
    bytesToWrite = [x for x in random.randbytes(16)] 
    cocotb.start_soon(ftdiVIP.writeBytes(bytesToWrite))

    ## Wait for AXIS Slave to be full, then take a gew bytes
    resultBytes = []
    await RisingEdge(dut.m_axis_tready)
    await FallingEdge(dut.m_axis_tready)
    resultBytes.extend(await slaveVIP.getBytes(1))

    await FallingEdge(dut.m_axis_tready)
    resultBytes.extend(await slaveVIP.getBytes(4))

    await FallingEdge(dut.m_axis_tready)
    resultBytes.extend(await slaveVIP.getBytes(3))
    resultBytes.extend(await slaveVIP.getBytes(8))

 
    print(f"I: {''.join('{:02x},'.format(a) for a in bytesToWrite)}")
    print(f"0: {''.join('{:02x},'.format(a) for a in resultBytes)}")
    #print(f"I:: {bytesToWrite}")
    #print(f"0: {resultBytes}")

    assert len(resultBytes) == 16 
    assert slaveVIP.inputQueue.qsize() == 0 
    assert bytesToWrite == resultBytes

    

    await Timer(150,"us")


@cocotb.test(timeout_time = 200 , timeout_unit = "us")
async def read_data_with_pause(dut):

    dut.resn.value = 0 
    ftdiVIP = vip.ftdi.FTDISyncFIFO(dut,queueSize = 8)
    slaveVIP = VAXIS_Slave(dut,clk = dut.prog_clko,queueSize = 8 )
    masterVIP = VAXIS_Master(dut,clk = dut.prog_clko)
    await Timer(5,"us")

    ## Deassert Reset
    dut.resn.value = 1
    await Timer(5,"us")
    ftdiVIP.start()

    ## Put data in AXIS Master Queue
    bytesToWrite = [x for x in random.randbytes(16)] 
    masterVIP.start_driver()
    await masterVIP.writeBytes(bytesToWrite)

    ## Wait For FTDI to be full then take some bytes
    resultBytes = []
    await RisingEdge(dut.ftdi_txe_n)
    await Timer(1,"us")
    resultBytes.extend(await  ftdiVIP.getBytes(1))

    await RisingEdge(dut.ftdi_txe_n)
    await Timer(1,"us")
    resultBytes.extend(await  ftdiVIP.getBytes(5))

    await RisingEdge(dut.ftdi_txe_n)
    resultBytes.extend(await  ftdiVIP.getBytes(2))

    ## take final
    await RisingEdge(dut.ftdi_txe_n)
    resultBytes.extend(await  ftdiVIP.getBytes(8))

    await Timer(10,"us")
    print(f"I: {''.join('{:02X},'.format(a) for a in bytesToWrite)}")
    print(f"0: {''.join('{:02X},'.format(a) for a in resultBytes)}")

    assert len(resultBytes) == 16
    assert ftdiVIP.inputQueue.qsize() == 0 
    assert bytesToWrite == resultBytes

    print(f"Final bytes: {''.join('{:02X},'.format(a) for a in resultBytes)}")

    await Timer(80,"us")
    pass

@cocotb.test(timeout_time = 1 , timeout_unit = "ms")
async def read_write_with_pause(dut):

    ## Init and reset 
    dut.resn.value = 0 
    ftdiVIP = vip.ftdi.FTDISyncFIFO(dut,queueSize = 24)
    slaveVIP = VAXIS_Slave(dut,clk = dut.prog_clko,queueSize = 24 )
    masterVIP = VAXIS_Master(dut,clk = dut.prog_clko)
    await Timer(5,"us")
    dut.resn.value = 1
    await Timer(5,"us")
    ftdiVIP.start()
    masterVIP.start_driver()
    slaveVIP.start_monitor()

    ## Write some bytes to design and read
    bytesToWriteIn = [x for x in random.randbytes(16)] 
    bytesToReceive = [x for x in random.randbytes(16)] 
    cocotb.start_soon(ftdiVIP.writeBytes(bytesToWriteIn))
    cocotb.start_soon(masterVIP.writeBytes(bytesToReceive))

    await Timer(100,"us")
    print(f"Sizes, slave={slaveVIP.inputQueue.qsize()},ftdi={ftdiVIP.inputQueue.qsize()}")
    bytesWritten  = await slaveVIP.getBytes(16)
    receivedBytes = await ftdiVIP.getBytes(16)

    assert slaveVIP.inputQueue.qsize() == 0 
    assert ftdiVIP.inputQueue.qsize() == 0 
    assert bytesToWriteIn == bytesWritten
    assert bytesToReceive == receivedBytes

    await Timer(50,"us")


    ## Write in multiple blocks, use some timers to introduce some bad delays
    bytesToWriteIn = [x for x in random.randbytes(12)] 
    bytesToReceive = [x for x in random.randbytes(12)] 

    cocotb.start_soon(ftdiVIP.writeBytes(bytesToWriteIn[0:2]))
    await Timer(20,"ns")
    cocotb.start_soon(masterVIP.writeBytes(bytesToReceive[0:2]))
    await Timer(50,"us")
    
    cocotb.start_soon(masterVIP.writeBytes(bytesToReceive[2:]))
    await Timer(20,"ns")
    cocotb.start_soon(ftdiVIP.writeBytes(bytesToWriteIn[2:]))
    await Timer(50,"us")

    print(f"Sizes, slave={slaveVIP.inputQueue.qsize()},ftdi={ftdiVIP.inputQueue.qsize()}")
    bytesWritten = await slaveVIP.getBytes(12)
    receivedBytes = await ftdiVIP.getBytes(12)

    assert slaveVIP.inputQueue.qsize() == 0 
    assert ftdiVIP.inputQueue.qsize() == 0 

    print(f"I: {''.join('{:02X},'.format(a) for a in bytesToWriteIn)}")
    print(f"0: {''.join('{:02X},'.format(a) for a in bytesWritten)}")

    assert bytesToWriteIn == bytesWritten
    assert bytesToReceive == receivedBytes

    await Timer(50,"us")


  