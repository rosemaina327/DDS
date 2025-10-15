
import cocotb
import cocotb
from cocotb.triggers        import Timer,RisingEdge,FallingEdge, Combine
from cocotb.clock           import Clock
from cocotb.wavedrom        import trace
from cocotb.types           import Bit
from cocotb.binary          import BinaryValue



import sys
import os
import logging


import  rfg.core
import  rfg.discovery
import  rfg.cocotb.cocotb_spi
from    rfg.cocotb.cocotb_spi  import SPIIO


from cocotb.triggers import Timer,RisingEdge

logger = logging.getLogger(__name__)
def debug():
    logger.setLevel(logging.DEBUG)
def info():
    logger.setLevel(logging.INFO)


@cocotb.test(timeout_time = 1,timeout_unit="ms")
async def test_one_conversion(dut):
    """"""

    #rfg.core.debug()

    ## I/O Inits
    dut.VIN.value = 0.2
    dut.VREF.value = 1.8

    ## Get Driver to write to SPI Registers
    driver = await getSPIDriver(dut)

    ## Enable SPI interface by selecting Chip
    driver.io.spi.assert_chip_select()
    await Timer(1, units="us")

    ## Reset -> Use ADC RESET bit to reset most parts of the chip
    await driver.write_ADC_CTRL(0x04,flush=True)
    await Timer(1, units="us")
    await driver.write_ADC_CTRL(0x00,flush=True)
    await Timer(1, units="us")



    ## Enable OSC
    await driver.write_OSC_CTRL(0x01,flush=True)
    await Timer(1, units="us")

    #await Timer(100, units="us")
    #return
    #await driver.write_OSC_CTRL(0x00,flush=True)
    #await driver.write_OSC_CTRL(0x01,flush=False)

    ## Enable Test DAC
    await driver.write_TEST_DAC_VALUE(0x80,flush=False)
    await driver.write_TEST_DAC_CTRL(0x01,flush=True)

    ## Make a conversion
    await driver.write_ADC_WAITTIME(64,flush=False)
    await driver.write_ADC_CTRL(0x01,flush=True)
    await driver.write_ADC_CTRL(0x00,flush=True)


    ## Poll ADC Busy
    adcCtrl = await driver.read_ADC_CTRL()
    #dut._log.info(f"Read ADC Value: {hex(data)}")
    while (adcCtrl >> 1 & 0x1) == 1:
        adcCtrl = await driver.read_ADC_CTRL()

    ## Read Output: We don't pool ADC_BUSY since the conversion will be faster than the SPI protocol
    #await Timer(20, units="us")
    #data = await driver.read_ADC_FIFO_DATA(count = 1)

    #dut._log.info(f"Read ADC Value: {hex(data)}")

    #await Timer(20, units="us")
    data = await driver.read_ADC_FIFO_DATA(count = 1)

    dut._log.info(f"Read ADC Value: {hex(data)}")

    ## End of Test
    await Timer(100, units="us")

    pass




##############
##  Helpers ##
##############
#

async def getSPIDriver(dut):

    logger.info("Using SPI Driver")

    ## Load RF and Setup UARTIO
    rfginst = rfg.discovery.loadOneFSPRFGOrFail()

    ## SPI
    #########
    rfg_io = SPIIO(dut,msbFirst=False,clockPeriod=100)
    await Timer(10, units="us")


    rfginst.withIODriver(rfg_io)

    # Open makes a reset of the SPI slave on the chip
    await rfg_io.open()


    await Timer(10, units="us")

    return rfginst
