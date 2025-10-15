${RFGV1_HOME}/verification/ftdi_sync/ftdi_sync_test.sv

${RFGV1_HOME}/verification/ftdi_sync/test-nexys/ftdi_sync_test.gen/sources_1/ip/clock_module/clock_module_sim_netlist.v
${HDLBUILDV1_HOME}/svlib/sync/reset_sync.sv

#${RFGV1_HOME}/rtl/ftdi/ftdi_sync_fifo_axis_b.sv
${RFGV1_HOME}/rtl/ftdi/ftdi_sync_fifo_axis.sv
${RFGV1_HOME}/rtl/ftdi/ftdi_interface_control_fsm.sv

+incdir+${RFGV1_HOME}/verification/ftdi_sync/test-nexys/ftdi_sync_test.gen/sources_1/ip/ftdio_io_fifo/hdl
${RFGV1_HOME}/verification/ftdi_sync/test-nexys/ftdi_sync_test.gen/sources_1/ip/ftdio_io_fifo/ftdio_io_fifo_sim_netlist.v

${RFGV1_HOME}/rtl/protocol/rfg_axis_protocol.sv
${RFGV1_HOME}/rtl/protocol/rfg_axis_protocol_srl_fifo.sv
${RFGV1_HOME}/verification/ftdi_sync/main_rfg.sv



+incdir+${HDLBUILDV1_HOME}/svlib/includes
-sv 
-64bit
-access +rw
-define SIMULATION

## Xilinx
-reflib ${UNISIM}/
${XILINX_VIVADO}/data/verilog/src/glbl.v