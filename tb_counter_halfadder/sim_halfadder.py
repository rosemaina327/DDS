
import cocotb
from cocotb.triggers        import Timer,RisingEdge,FallingEdge, Combine
from cocotb.clock           import Clock 
from cocotb.wavedrom        import trace 
from cocotb.types           import Bit
from cocotb.binary          import BinaryValue

@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_truth_table(dut):

    ## Wait for 100ns to begin test - Simulation waveform should be X during 100ns (undefined)
    await Timer(100, units="ns")
    dut.a.value = 1
    dut.b.value = 0
    await Timer(1, units="ns")
    assert  dut.sum == 1, "Sum should be 1"
    assert  dut.carry == 0 , "Carry should be 0"

    await Timer(100, units="ns")
    dut.a.value = 0
    dut.b.value = 1

    await Timer(1, units="ns")
    assert dut.sum == 1, "Sum should be 1"
    assert dut.carry == 0, "Carry should be 0"

    await Timer(100, units="ns")
    dut.a.value = 1
    dut.b.value = 1
    await Timer(1, units="ns")
    assert dut.sum == 0, "Sum should be 0"
    assert dut.carry == 1, "Carry should be 1"


    await Timer(100, units="ns")
    pass