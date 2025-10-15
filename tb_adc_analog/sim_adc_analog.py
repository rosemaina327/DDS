
import cocotb
import cocotb
from cocotb.triggers        import Timer,RisingEdge,FallingEdge, Combine
from cocotb.clock           import Clock
from cocotb.wavedrom        import trace
from cocotb.types           import Bit
from cocotb.binary          import BinaryValue


@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_one_conversion(dut):
    """This test sets VIN and vdac to a fixed value to see if compout is changing correctly"""

    dut.VREF.value = 1.0
    dut.VIN.value = 0.4
    dut.vdac.value = 0

    ## Here the compout output should be 0 in the waveform
    await Timer(10, units="us")
    dut.vdac.value = 32
    await Timer(1, units="us")
    assert dut.compout.value == 0

    # Change test VDAC to a digital value that will be higher than VIN
    # Setting to 128 should generate roughly (VREF / 2) comparator value, which should be higher than VIN.
    await Timer(10, units="us")
    dut.vdac.value = 128

    ## Here the compout output should be 1 in the waveform after 10us
    await Timer(10, units="us")
    assert dut.compout.value == 1

    # End of test
    await Timer(100, units="us")



@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_one_conversion_delayed(dut):
    """This test sets VIN and vdac to a fixed value to see if compout is changing correctly"""

    dut.VREF.value = 1.0
    dut.VIN.value = 0.4
    dut.vdac.value = 0

    ## Here the compout output should be 0 in the waveform
    await Timer(10, units="us")
    dut.vdac.value = 32
    await Timer(1, units="us")
    assert dut.compout.value == 0

    # Change test VDAC to a digital value that will be higher than VIN
    # Setting to 128 should generate roughly (VREF / 2) comparator value, which should be higher than VIN.
    await Timer(10, units="us")
    dut.vdac.value = 128

    ## Here the compout output should be 1 in the waveform after 1us not earlier
    await Timer(100, units="ns")
    assert dut.compout.value == 0
    await Timer(1, units="us")
    assert dut.compout.value == 1

    # End of test
    await Timer(100, units="us")


@cocotb.test(timeout_time = 1,timeout_unit="ms",skip=False)
async def test_counter_sweep(dut):
    """Sweept vdac input counting up until you find the correct value for VIN"""

    ## Initial state
    dut.VREF.value = 1.0
    dut.VIN.value = 0.4
    dut.vdac.value = 0

    ## Count up vdac until compout is 1 - then compare vdac with the expected value for VIN.
    ## The expected value can be calculated in python using a math expression
    ## The ADC Output should be the same as the calculated value +/-1
    await Timer(100, units="us")


    pass
