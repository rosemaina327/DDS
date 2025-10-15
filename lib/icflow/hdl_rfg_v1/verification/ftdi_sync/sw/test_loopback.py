
## Load RFG
import asyncio
import rfg.core
import rfg.io
import logging
import random
from fsp.ftdi_sync_test import main_rfg 

logging.basicConfig()

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

logger.info("Hi")
rfg.core.debug()



## Create RFG
rf = main_rfg()
rf.withFTDIIO("Device A",rfg.io.ftdi.FLAG_LIST_DESCRIPTOR)
rf.io.open()

async def read():
    try:
        while True:
            print("Reading from USB")
            bytesFromUSB = await rf.io.readBytes(1024)
            print(f"Got Bytes from usb: {len(bytesFromUSB)}")
    except Exception  as e:
        print(f"Out of Async: {str(e)}")


async def parallelReadMain():
    readTask = asyncio.get_running_loop().create_task(read())

    ## Write to FIFO
    bytesToWrite =  [x for x in random.randbytes(1024)] 
    expectedBytes = []
    expectedBytes.extend(bytesToWrite)

    ## Make 2 times write then read, then flush
    ## Then
    #await rf.write_loopback_fifo_w_bytes(bytesToWrite,False)
    rf.addRead(register = rf.Registers['LOOPBACK_FIFO_R'],count = 1024)

    #bytesToWrite =  [x for x in random.randbytes(1024)] 
    #await rf.write_loopback_fifo_w_bytes(bytesToWrite,False)

    #expectedBytes.extend(bytesToWrite)
    #rf.addRead(register = rf.Registers['LOOPBACK_FIFO_R'],count = 1024)

    await rf.flush()

    await asyncio.sleep(2)
    print("Finishing")
    rfg.io.cancelIO()
    readTask.cancel()
    #asyncio.get_running_loop().stop()




#asyncio.run(rf.write_loopback_fifo_w_bytes(bytesToWrite,False))
#readBytes = asyncio.run(rf.read_loopback_fifo_r_raw(len(bytesToWrite)))

## Now Read 2048 from USB
#readBytes =  asyncio.run(rf.io.readBytes(1024))

#print(f"I: {list(expectedBytes)}")
#print(f"O: {list(readBytes)}")

#assert expectedBytes == list(readBytes)

asyncio.run(parallelReadMain(), debug = True)
print("Exiting")