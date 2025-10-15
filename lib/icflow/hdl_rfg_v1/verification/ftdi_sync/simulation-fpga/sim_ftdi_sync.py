
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


    dut.cpu_resetn.value = 0 
    ftdiVIP = vip.ftdi.FTDISyncFIFO(dut)
    #slaveVIP = VAXIS_Slave(dut,     clk = dut.prog_clko,    queueSize = 8 )
    #masterVIP = VAXIS_Master(dut,   clk = dut.prog_clko,    queueSize = 8)
    cocotb.start_soon(Clock(dut.sysclk,10,"ns").start())
    await Timer(5,"us")

    ## Deassert Reset
    dut.cpu_resetn.value = 1
    await Timer(15,"us")
    ftdiVIP.start()


    ## Send some bytes to FTDI
    bytesToWrite = [0x01,0x00,0x01,0x00,0xAB]
    cocotb.start_soon(ftdiVIP.writeBytes(bytesToWrite))

    await Timer(150,"us")
  