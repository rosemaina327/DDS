icSetParameter IC_RFG_TARGET ftdi_sync_test 
icSetParameter IC_RFG_NAME   main_rfg
return {
    {IO_LED}
    {BLINK   -counter -interrupt -size 32 -match_reset 32'd40000000 -updown}
    {LOOPBACK_FIFO_W -fifo_axis_master}
    {LOOPBACK_FIFO_R -fifo_axis_slave}
}