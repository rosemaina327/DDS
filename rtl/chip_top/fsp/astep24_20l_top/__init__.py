

import logging
from rfg.core import AbstractRFG
from rfg.core import RFGRegister
logger = logging.getLogger(__name__)


def load_rfg():
    return main_rfg()


OSC_CTRL = 0x0
OSC_DIVIDER = 0x1
ADC_CTRL = 0x2
ADC_WAITTIME = 0x3
ADC_FIFO_STATUS = 0x7
ADC_FIFO_DATA = 0x8
TEST_DAC_CTRL = 0x9
TEST_DAC_VALUE = 0xa




class main_rfg(AbstractRFG):
    """Register File Entry Point Class"""
    
    
    class Registers(RFGRegister):
        OSC_CTRL = 0x0
        OSC_DIVIDER = 0x1
        ADC_CTRL = 0x2
        ADC_WAITTIME = 0x3
        ADC_FIFO_STATUS = 0x7
        ADC_FIFO_DATA = 0x8
        TEST_DAC_CTRL = 0x9
        TEST_DAC_VALUE = 0xa
    
    
    
    def __init__(self):
        super().__init__()
    
    
    def hello(self):
        logger.info("Hello World")
    
    
    
    async def write_OSC_CTRL(self,value : int,flush = False):
        self.addWrite(register = self.Registers['OSC_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_OSC_CTRL(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['OSC_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_OSC_CTRL_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['OSC_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_OSC_DIVIDER(self,value : int,flush = False):
        self.addWrite(register = self.Registers['OSC_DIVIDER'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_OSC_DIVIDER(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['OSC_DIVIDER'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_OSC_DIVIDER_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['OSC_DIVIDER'],count = count, increment = False)
        
    
    
    
    async def write_ADC_CTRL(self,value : int,flush = False):
        self.addWrite(register = self.Registers['ADC_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_ADC_CTRL(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['ADC_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_ADC_CTRL_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['ADC_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_ADC_WAITTIME(self,value : int,flush = False):
        self.addWrite(register = self.Registers['ADC_WAITTIME'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_ADC_WAITTIME(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['ADC_WAITTIME'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_ADC_WAITTIME_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['ADC_WAITTIME'],count = count, increment = True)
        
    
    
    
    async def write_ADC_FIFO_STATUS(self,value : int,flush = False):
        self.addWrite(register = self.Registers['ADC_FIFO_STATUS'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_ADC_FIFO_STATUS(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['ADC_FIFO_STATUS'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_ADC_FIFO_STATUS_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['ADC_FIFO_STATUS'],count = count, increment = False)
        
    
    
    
    async def read_ADC_FIFO_DATA(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['ADC_FIFO_DATA'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_ADC_FIFO_DATA_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['ADC_FIFO_DATA'],count = count, increment = False)
        
    
    
    
    async def write_TEST_DAC_CTRL(self,value : int,flush = False):
        self.addWrite(register = self.Registers['TEST_DAC_CTRL'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_TEST_DAC_CTRL(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['TEST_DAC_CTRL'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_TEST_DAC_CTRL_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['TEST_DAC_CTRL'],count = count, increment = False)
        
    
    
    
    async def write_TEST_DAC_VALUE(self,value : int,flush = False):
        self.addWrite(register = self.Registers['TEST_DAC_VALUE'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_TEST_DAC_VALUE(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['TEST_DAC_VALUE'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_TEST_DAC_VALUE_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['TEST_DAC_VALUE'],count = count, increment = False)
        
    
