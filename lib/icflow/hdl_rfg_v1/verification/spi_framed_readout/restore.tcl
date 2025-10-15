
# XM-Sim Command File
# TOOL:	xmsim(64)	22.03-s005
#
#
# You can restore this configuration with:
#
#      xrun -timescale 1ns/1ps -f /home/rleys/git/adl/icflow/packages/hdl_rfg_v1/verification/spi_framed_readout/spi_framed_readout.sim.f -debug_opts indago_pp -loadvpi /home/rleys/git/adl/icflow/packages/hdl_rfg_v1/verification/spi_framed_readout/.icflow/sim/.venv/lib/python3.10/site-packages/cocotb/libs/libcocotbvpi_ius.so:vlog_startup_routines_bootstrap -access +rwc -createdebugdb -s -input /home/rleys/git/adl/icflow/packages/hdl_rfg_v1/verification/spi_framed_readout/restore.tcl
#

ida_database -open -name ida.db
ida_probe -log on
set tcl_prompt1 {puts -nonewline "xcelium> "}
set tcl_prompt2 {puts -nonewline "> "}
set vlog_format %h
set vhdl_format %v
set real_precision 6
set display_unit auto
set time_unit module
set heap_garbage_size -200
set heap_garbage_time 0
set assert_report_level note
set assert_stop_level error
set autoscope yes
set assert_1164_warnings yes
set pack_assert_off {}
set severity_pack_assert_off {note warning}
set assert_output_stop_level failed
set tcl_debug_level 0
set relax_path_name 1
set vhdl_vcdmap XX01ZX01X
set intovf_severity_level ERROR
set probe_screen_format 0
set rangecnst_severity_level ERROR
set textio_severity_level ERROR
set vital_timing_checks_on 1
set vlog_code_show_force 0
set assert_count_attempts 1
set tcl_all64 false
set tcl_runerror_exit false
set assert_report_incompletes 0
set show_force 1
set force_reset_by_reinvoke 0
set tcl_relaxed_literal 0
set probe_exclude_patterns {}
set probe_packed_limit 4k
set probe_unpacked_limit 16k
set assert_internal_msg no
set svseed 1
set assert_reporting_mode 0
set vcd_compact_mode 0
alias . run
alias quit exit
database -open -shm -into ida.db/ida.shm ida.db/ida.shm -default
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout -all -memories -depth all
probe -create -database ida.db/ida.shm spi_framed_readout.igress.m_axis_tvalid spi_framed_readout.igress.m_axis_tdata spi_framed_readout.protocol.aresetn spi_framed_readout.protocol.aclk spi_framed_readout.protocol.rfp_state spi_framed_readout.protocol.rfg_header spi_framed_readout.protocol.rfg_write_value spi_framed_readout.protocol.rfg_write spi_framed_readout.protocol.rfg_read_value spi_framed_readout.protocol.rfg_read_valid spi_framed_readout.protocol.rfg_read spi_framed_readout.main_rfg_I.scratchpad0 spi_framed_readout.main_rfg_I.scratchpad1 spi_framed_readout.readout_framing.s_axis_tdata spi_framed_readout.readout_framing.s_axis_tlast spi_framed_readout.readout_framing.end_of_frame spi_framed_readout.readout_framing.s_axis_tready spi_framed_readout.readout_framing.s_axis_tuser spi_framed_readout.readout_framing.s_axis_tvalid spi_framed_readout.readout_framing.state spi_framed_readout.readout_framing.m_axis_tdata spi_framed_readout.readout_framing.m_axis_tready spi_framed_readout.readout_framing.m_axis_tuser spi_framed_readout.readout_framing.m_axis_tvalid

simvision -input restore.tcl.svcf
