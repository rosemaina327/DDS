
import cocotb
import cocotb
from cocotb.triggers        import Timer,RisingEdge,FallingEdge, Combine
from cocotb.clock           import Clock
from cocotb.wavedrom        import trace
from cocotb.types           import Bit
from cocotb.binary          import BinaryValue


@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_one_conversion(dut):
    """This test only counts up in enabled mode"""

    dut.VREF.value = 1.0
    dut.VIN.value = 0.4

    dut.clk.value = 0
    dut.resn.value = 0
    dut.start.value = 0


    # Wait for 100ns to begin test - Simulation waveform should be X during 100ns (undefined)
    await Timer(100, units="ns")
    cocotb.start_soon(Clock(dut.clk, 20, units='ns').start())

    # Release reset
    await Timer(100, units="ns")
    for i in range(0,20):
        await RisingEdge(dut.clk)
    dut.resn.value = 1
    await RisingEdge(dut.clk)

    # Check reset state
    await FallingEdge(dut.clk)
    assert dut.adc_busy.value == 0 , "ADC Busy must be 0 after reset"

    # Start conversion
    dut.start.value = 1;

    # adc_busy must toggle to 1 after the next clock edge
    await RisingEdge(dut.clk)
    await FallingEdge(dut.clk)
    assert dut.adc_busy.value == 1 , "ADC Busy must be 1 after start requested"
    dut.start.value = 0

    # Wait until conversion finished
    await RisingEdge(dut.adc_valid)


    # End of test
    await Timer(100, units="us")
