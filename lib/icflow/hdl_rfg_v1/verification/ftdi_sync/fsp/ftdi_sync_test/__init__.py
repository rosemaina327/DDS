

import logging
from rfg.core import AbstractRFG
from rfg.core import RFGRegister
logger = logging.getLogger(__name__)


def load_rfg():
    return main_rfg()


IO_LED = 0x0
BLINK = 0x1
LOOPBACK_FIFO_W = 0x5
LOOPBACK_FIFO_R = 0x6
BLINK_MATCH = 0x7




class main_rfg(AbstractRFG):
    
    
    class Registers(RFGRegister):
        IO_LED = 0x0
        BLINK = 0x1
        LOOPBACK_FIFO_W = 0x5
        LOOPBACK_FIFO_R = 0x6
        BLINK_MATCH = 0x7
    
    
    
    def __init__(self):
        super().__init__()
    
    
    def hello(self):
        logger.info("Hello World")
    
    
    
    async def write_io_led(self,value : int,flush = False):
        self.addWrite(register = self.Registers['IO_LED'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def read_io_led(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['IO_LED'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_io_led_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['IO_LED'],count = count, increment = False)
        
    
    
    
    async def write_blink(self,value : int,flush = False):
        self.addWrite(register = self.Registers['BLINK'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_blink(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['BLINK'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_blink_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['BLINK'],count = count, increment = True)
        
    
    
    
    async def write_loopback_fifo_w(self,value : int,flush = False):
        self.addWrite(register = self.Registers['LOOPBACK_FIFO_W'],value = value,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    async def write_loopback_fifo_w_bytes(self,values : bytearray,flush = False):
        for b in values:
            self.addWrite(register = self.Registers['LOOPBACK_FIFO_W'],value = b,increment = False,valueLength=1)
        if flush == True:
            await self.flush()
        
    
    
    
    async def read_loopback_fifo_r(self, count : int = 1 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['LOOPBACK_FIFO_R'],count = count, increment = False , targetQueue = targetQueue), 'little') 
        
    
    async def read_loopback_fifo_r_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['LOOPBACK_FIFO_R'],count = count, increment = False)
        
    
    
    
    async def write_blink_match(self,value : int,flush = False):
        self.addWrite(register = self.Registers['BLINK_MATCH'],value = value,increment = True,valueLength=4)
        if flush == True:
            await self.flush()
        
    
    async def read_blink_match(self, count : int = 4 , targetQueue: str | None = None) -> int: 
        return  int.from_bytes(await self.syncRead(register = self.Registers['BLINK_MATCH'],count = count, increment = True , targetQueue = targetQueue), 'little') 
        
    
    async def read_blink_match_raw(self, count : int = 4 ) -> bytes: 
        return  await self.syncRead(register = self.Registers['BLINK_MATCH'],count = count, increment = True)
        
    
