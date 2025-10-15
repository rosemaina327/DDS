# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL?=adc_top
SAR?=0
SPICE?=0
TB_FOLDER?=$(shell pwd)
SPICE_WORST?=0
SPICE_BEST?=0

export DDS_WAVES?=waves_typical

ifeq ($(SPICE),1)

	SIM_BUILD=sim_build_spice
	VERILOG_SOURCES?=$(BASE)/rtl/adc/adc_top.sv
	TOPLEVEL=adc_mixed_tb_top

	ifeq ($(SPICE_WORST),1)
    	export DDS_WAVES=waves_worst
     	export SPICE_CONTROL=$(BASE)/tb_adc/adc_analog_ss.scs
    	DDS_EXTRA_ARGS=-f $(BASE)/tb_adc/adc_spice.f
    else ifeq ($(SPICE_BEST),1)
    	export DDS_WAVES=waves_best
    	export SPICE_CONTROL=$(BASE)/tb_adc/adc_analog_ff.scs
    	DDS_EXTRA_ARGS=-f $(BASE)/tb_adc/adc_spice.f
    else
     	export DDS_WAVES=waves_typical
     	export SPICE_CONTROL=$(BASE)/tb_adc/adc_analog_tt.scs
     	DDS_EXTRA_ARGS=-f $(BASE)/tb_adc/adc_spice.f
    endif

else ifeq ($(SAR),1)
	VERILOG_SOURCES?=$(BASE)/rtl/adc/adc_analog_model.sv $(BASE)/rtl/adc/adc_digital_sar.sv $(BASE)/rtl/adc/adc_top.sv
else
	VERILOG_SOURCES?=$(BASE)/rtl/adc/adc_analog_model.sv $(BASE)/rtl/adc/adc_digital_counter.sv $(BASE)/rtl/adc/adc_top.sv
endif


# include common makefile that gathers common attributes
include $(BASE)/tb_common/Makefile.common
