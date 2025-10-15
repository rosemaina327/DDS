
import cocotb
import cocotb
from cocotb.triggers        import Timer,RisingEdge,FallingEdge, Combine
from cocotb.clock           import Clock 
from cocotb.wavedrom        import trace 
from cocotb.types           import Bit
from cocotb.binary          import BinaryValue

@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_count_up(dut):
    """This test only counts up in enabled mode"""

    dut.resn.value = 0
    dut.clk.value = 0 
    dut.enable.value = 1

    # Wait for 100ns to begin test - Simulation waveform should be X during 100ns (undefined)
    await Timer(100, units="ns")
    cocotb.start_soon(Clock(dut.clk, 10, units='ns').start())

    # Release reset
    await Timer(100, units="ns")
    await RisingEdge(dut.clk)
    dut.resn.value = 1    

    # Wait for a couple clock cycle, and check we are counting
    for i in range(4):
        await RisingEdge(dut.clk)
    
    await FallingEdge(dut.clk)
    assert dut.cnt.value == 4 , "Counter is 4 after 4 clock cycles"
    

    # End of test
    await Timer(100, units="ns")



@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_count_up_enable(dut):
    """This test counts up in enabled mode, then disables for some cycles and counts again"""
    
    dut.resn.value = 0
    dut.clk.value = 0 
    dut.enable.value = 1 

    # Wait for 100ns to begin test - Simulation waveform should be X during 100ns (undefined)
    await Timer(100, units="ns")
    cocotb.start_soon(Clock(dut.clk, 10, units='ns').start())

    # Release reset
    await Timer(100, units="ns")
    await RisingEdge(dut.clk)
    dut.resn.value = 1    

    # Wait for a couple clock cycle, and check we are counting
    for i in range(4):
        await RisingEdge(dut.clk)
    await FallingEdge(dut.clk)
    assert dut.cnt.value == 4 , "Counter is 4 after 4 clock cycles"
    
    # Disable counter
    dut.enable.value = 0

    # Wait for a couple cycle, check we didn't count
    for i in range(4):
        await RisingEdge(dut.clk)
    await FallingEdge(dut.clk)
    assert dut.cnt.value == 4 , "Counter is still 4 after Enable is 0"

    # Reenable
    dut.enable.value = 1

    # Wait for a couple cycle, check we count again
    for i in range(4):
        await RisingEdge(dut.clk)
    await FallingEdge(dut.clk)
    assert dut.cnt.value == 8 , "Counter is 8 after 4 more cycles"

    # End of test
    await Timer(100, units="ns")