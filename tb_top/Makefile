# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL?=chip_top_sim


ifeq ($(PAR),1)
	SIM_BUILD=sim_build_par
	export DDS_WAVES=waves_par
	VERILOG_SOURCES?=$(PWD)/chip_top_sim.sv ${BASE}/rtl/chip_top/mixed_signal_types_pkg.sv $(BASE)/run/chip_top/par/stream_out/chip_top.simulation.nonFlat.v $(BASE)/lib/uk65lscllmvbbr.v $(PWD)/osc_model.sv $(PWD)/dac_model.sv $(PWD)/tgate_model.sv ${BASE}/rtl/adc/adc_analog_model.sv
	DDS_EXTRA_ARGS=-rnm_tech -define SIMULATION -define SDF_MAX -ALLOWREDEFINITION
else ifeq ($(SYNTH),1)
	SIM_BUILD=sim_build_synth
	export DDS_WAVES=waves_synth
	VERILOG_SOURCES?=$(PWD)/chip_top_sim.sv ${BASE}/rtl/chip_top/mixed_signal_types_pkg.sv $(PWD)/../lib/chip_top.gtl.sv $(UMC_HOME)/65nm-stdcells/verilog/uk65lscllmvbbr.v $(PWD)/osc_model.sv $(PWD)/dac_model.sv $(PWD)/tgate_model.sv ${BASE}/rtl/adc/adc_analog_model.sv ${BASE}/rtl/adc/adc_analog_system.sv
	DDS_EXTRA_ARGS=-rnm_tech -define SIMULATION -ALLOWREDEFINITION -define functional -notiming
else
	VERILOG_SOURCES?=$(PWD)/chip_top_sim.sv $(PWD)/osc_model.sv $(PWD)/dac_model.sv $(PWD)/tgate_model.sv ${BASE}/rtl/adc/adc_analog_model.sv
	DDS_EXTRA_ARGS=-f $(BASE)/rtl/chip_top/chip_top.f -rnm_tech -define SIMULATION

endif


export PYTHONPATH := $(BASE)/rtl/chip_top:$(PYTHONPATH)

# include common makefile that gathers common attributes
include $(BASE)/tb_common/Makefile.common
