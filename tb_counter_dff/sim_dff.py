
import cocotb
from cocotb.triggers        import Timer,RisingEdge,FallingEdge, Combine
from cocotb.clock           import Clock 
from cocotb.wavedrom        import trace 
from cocotb.types           import Bit
from cocotb.binary          import BinaryValue

@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_clk_update(dut):

    ## Set initial values for the DFF Clock 
    dut.clk.value = 0 
    dut.d.value = 0
    
    ## Start a Clock connected to the DFF
    await Timer(100, units="ns")
    cocotb.start_soon(Clock(dut.clk, 10, units='ns').start())
    
    ## Wait for 100ns to begin test 
    await Timer(100, units="ns")

    ## The q output should be 0 since the d input was set to 0 at the beginning 
    assert  dut.q == 0, "Q should be 0"

    ## Now change D to 1 and the next clock cycle, q should be 1
    await RisingEdge(dut.clk)
    dut.d.value = 1
    await RisingEdge(dut.clk)
    await FallingEdge(dut.clk) # Check value on falling edge to be sure that value was updated in simulator
    assert  dut.q == 1, "Q should be 1"


    ## End of test
    await Timer(100, units="ns")
    pass