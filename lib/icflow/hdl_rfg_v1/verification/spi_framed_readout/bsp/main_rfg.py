

import logging
from rfg.core import AbstractRFG
from rfg.core import RFGRegister
logger = logging.getLogger(__name__)
SCRATCHPAD0 = 0x0
SCRATCHPAD1 = 0x1


class Registers(RFGRegister):
    SCRATCHPAD0 = 0x0
    SCRATCHPAD1 = 0x1





class main_rfg(AbstractRFG):
    
    
    def hello(self):
        logger.info("Hello World")
    
    
    
    def write_scratchpad0(self,value : int,flush = False):
        self.addWrite(register = Registers['SCRATCHPAD0'],value = value)
        if flush == True:
            self.flush()
        
    
    async def read_scratchpad0(self, count : int = 1 ) -> int: 
        return  int.from_bytes(await self.syncRead(register = Registers['SCRATCHPAD0'],count = count, increment = True), 'little') 
        
    
    async def read_scratchpad0_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = Registers['SCRATCHPAD0'],count = count, increment = True)
        
    
    
    
    def write_scratchpad1(self,value : int,flush = False):
        self.addWrite(register = Registers['SCRATCHPAD1'],value = value)
        if flush == True:
            self.flush()
        
    
    async def read_scratchpad1(self, count : int = 1 ) -> int: 
        return  int.from_bytes(await self.syncRead(register = Registers['SCRATCHPAD1'],count = count, increment = True), 'little') 
        
    
    async def read_scratchpad1_raw(self, count : int = 1 ) -> bytes: 
        return  await self.syncRead(register = Registers['SCRATCHPAD1'],count = count, increment = True)
        
