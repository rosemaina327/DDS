# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL?=counter
SYNTH?=0

ifeq ($(SYNTH),1)
	VERILOG_SOURCES?=$(BASE)/run-synthesis/counter/netlist/counter.gtl.sv $(UMC_HOME)/65nm-stdcells/verilog/uk65lscllmvbbr.v
	DDS_EXTRA_ARGS=-notiming -define functional
else
	VERILOG_SOURCES?=$(BASE)/rtl/counter/counter.sv
endif

# include common makefile that gathers common attributes
include $(BASE)/tb_common/Makefile.common
