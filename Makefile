
export BASE=$(PWD)/
GENUS_ARGS?=-overwrite

PYTHON_EXE?=python3.12

setup: cocotb

## Main Testbenches
#############

tb_counter_halfadder: cocotb
	@source ./load.sh && reset && make -C tb_counter_halfadder

tb_counter_dff: cocotb
	@source ./load.sh && reset && make -C tb_counter_dff

tb_counter_4bit: cocotb
	@source ./load.sh && reset && make -C tb_counter_4bit

tb_counter_hdl: cocotb
	@source ./load.sh && reset && make -C tb_counter_hdl

tb_adc_analog: cocotb
	@source ./load.sh && reset && make -C tb_adc_analog

tb_adc: cocotb
	@source ./load.sh && reset && make -C tb_adc

tb_adc_sar: cocotb
	@source ./load.sh && reset && make -C tb_adc SAR=1


tb_adc_spice: cocotb
	@source ./load.sh && reset && make -C tb_adc SPICE=1

tb_adc_spice_worst: cocotb
	@source ./load.sh && reset && make -C tb_adc SPICE=1 SPICE_WORST=1

tb_adc_spice_best: cocotb
	@source ./load.sh && reset && make -C tb_adc SPICE=1 SPICE_BEST=1

simvision:
	@source ./load.sh && simvision &

## Synthesis
#############
synth_counter: export IC_NETLIST_F=$(BASE)/rtl/counter/counter.f
synth_counter: export IC_TOP=counter
synth_counter: export IC_MMMC_CONSTRAINTS_FUNCTIONAL=$(BASE)/constraints/counter.sdc
synth_counter:
	@source ./load.sh && mkdir -p run-synthesis/counter && cd run-synthesis/counter && reset && genus $(GENUS_ARGS) -files $(BASE)/impl_common/synthesis_fast.tcl

tb_counter_synth: cocotb
	@source ./load.sh && reset && make -C tb_counter_hdl SYNTH=1


## Top level
###############

top_rfg:
	@source ./load.sh && reset && cd rtl/chip_top/ && icf_rfg ./rfg.tcl

top_synthesis: export IC_USER_LEF_FILES="$(BASE)/lib/dds_blocks.lef $(BASE)/lib/dds_gates.lef"
top_synthesis: export IC_NETLIST_F=$(BASE)/rtl/chip_top/chip_top_synthesis.f
top_synthesis: export IC_TOP=chip_top
top_synthesis: export IC_MMMC_CONSTRAINTS_FUNCTIONAL=$(BASE)/constraints/chip_top.sdc
top_synthesis: export IC_SHOW_CONSTRAINTS=1
top_synthesis:
	@source ./load.sh && mkdir -p run/chip_top/synthesis && cd run/chip_top/synthesis && reset && genus $(GENUS_ARGS) -files $(BASE)/impl_common/synthesis_fast.tcl

top_par:
	@source ./load.sh && mkdir -p run/chip_top/par && cd run/chip_top/par && rm -f *.log* *.cmd* && reset && innovus -files $(BASE)/impl_common/innovus.tcl

tb_top: cocotb
	@source ./load.sh && reset && make -C tb_top

tb_top_synth: cocotb
	@source ./load.sh && reset && make -C tb_top SYNTH=1


tb_top_par: cocotb
	@source ./load.sh && reset && make -C tb_top PAR=1

## COCOTB and tools Setup
###########

## Run LCOV
#lcov: node_modules/.bin/lcov-viewer
#@npm install @lcov-viewer/cli

## Cocotb + python setup
cocotb: .venv/bin/cocotb-config
.venv/bin/cocotb-config: .venv/bin/activate
	@.venv/bin/pip3 install -r requirements.txt
.venv/bin/activate:
	@rm -Rf .venv
	@$(PYTHON_EXE) -m venv .venv
