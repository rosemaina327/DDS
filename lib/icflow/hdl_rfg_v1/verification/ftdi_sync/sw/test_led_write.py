
## Load RFG
import asyncio
import rfg.core
import rfg.io
import logging
from fsp.ftdi_sync_test import main_rfg 

logging.basicConfig()

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

logger.info("Hi")
rfg.core.debug()



## Create RFG
rf = main_rfg()

## Open FTDI
print("Trying to open FTDI")
import rfg.io.ftdi 

print(f"FTDI Present: {rfg.io.ftdi.isFTDIConnected()}")

for device in rfg.io.ftdi.listFTDIDevices(rfg.io.ftdi.FLAG_LIST_DESCRIPTOR):
    print(f"Device: {str(device)}")


for device in rfg.io.ftdi.listFTDIDevicesMatching("Device A",rfg.io.ftdi.FLAG_LIST_DESCRIPTOR):
    print(f"Found Device: {str(device)}")

## Open RFG IO
rf.withFTDIIO("Device A",rfg.io.ftdi.FLAG_LIST_DESCRIPTOR)
rf.io.open()

## Write to LED
asyncio.run(rf.write_io_led(0xAB,True))