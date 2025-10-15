package require icflow

icSetMainScript

## Load UM65 Innovus parameters and the common innovus flow
icSource pdk_umc65/umc65.innovus1.tcl
icSource flow_innovus1/v1_0/innovus1.v1_0.tcl

## Set parameters
#set ::IC_PAR_NETLIST $::IC_MAIN_FOLDER/../adc_top.sv
set ::IC_PAR_NETLIST $::env(BASE)/lib/chip_top.gtl.sv
lappend ::IC_LEF_FILES $::env(BASE)/lib/dds_blocks.lef $::env(BASE)/lib/dds_gates.lef
#$::env(UMC_HOME)/rams/512x32/SJKA65_512X32X1CM4/SJKA65_512X32X1CM4.lef

set ::IC_MMMC_CONSTRAINTS_FUNCTIONAL $::env(BASE)/constraints/chip_top.sdc

set ::IC_TOP chip_top
