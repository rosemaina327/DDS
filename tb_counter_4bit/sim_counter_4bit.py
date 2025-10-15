
import cocotb
import cocotb
from cocotb.triggers        import Timer,RisingEdge,FallingEdge, Combine
from cocotb.clock           import Clock 
from cocotb.wavedrom        import trace 
from cocotb.types           import Bit
from cocotb.binary          import BinaryValue

@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_count_up(dut):

    dut.resn.value = 0
    dut.clk.value = 0 

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

async def test_count_up_wavedrom(dut):

    dut.resn.value = 0
    dut.clk.value = 0 

    
    with trace(dut.cnt, dut.resn, clk=dut.clk) as waves:
        # Stuff happens, we trace it
        ## Wait for 100ns to begin test - Simulation waveform should be X during 100ns (undefined)
        await Timer(100, units="ns")
        cocotb.start_soon(Clock(dut.clk, 10, units='ns').start())

        await Timer(100, units="ns")
        dut.resn.value = 1    


        await Timer(200, units="ns")

        # Dump to JSON format compatible with WaveDrom
        j = waves.dumpj()
        waves.write("./wave.json")

    pass