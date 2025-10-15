icCheckEnvVariables {BASE ADL_HOME UMC_HOME}

set ::IC_PROCESS_NODE 65

set ::IC_MMMC_FAST_CORNER_TEMPERATURE -40
set ::IC_MMMC_SLOW_CORNER_TEMPERATURE 125

set ::IC_STDCELL_VDD_NAME vdd!
set ::IC_STDCELL_GND_NAME gnd!
set ::IC_STDCELL_HEIGHT 1.8

set ::IC_POWER_VDD_NAME VDD
set ::IC_POWER_GND_NAME VSS

#set ::IC_POWER_VDD_NAME VDD_CORE
#set ::IC_POWER_GND_NAME GND_CORE

set ::IC_ROUTING_BOTTOM         ME2
set ::IC_ROUTING_TOP            ME5

set ::IC_CTS_ROUTE_RULE_BOTTOM     ME2
set ::IC_CTS_ROUTE_RULE_TOP        ME5

## Select Libs
set ::IC_MMMC_SLOW_LIB $::UMC_HOME/65nm-stdcells/synopsys/uk65lscllmvbbr_090c125_wc.lib
set ::IC_MMMC_SLOW_CDB false
set ::IC_MMMC_FAST_LIB $::UMC_HOME/65nm-stdcells/synopsys/uk65lscllmvbbr_132c0_bc.lib
set ::IC_MMMC_FAST_CDB false

## Select captable
#set ::IC_CAPTABLE_MIN $::STD_CELLS(captable/${::IC_SELECTED_METAL}/min)
#set ::IC_CAPTABLE_MAX $::STD_CELLS(captable/${::IC_SELECTED_METAL}/max)

## Select QRC Tech
#set ::IC_QRC_TECH_MAX $::STD_CELLS(qrc/${::IC_SELECTED_METAL}/max)
#set ::IC_QRC_TECH_MIN $::STD_CELLS(qrc/${::IC_SELECTED_METAL}/min)

## Select LEF
set ::IC_LEF_FILES [concat $::UMC_HOME/65nm-stdcells/lef/tf/uk65lscllmvbbr_8m2t2f.lef $::UMC_HOME/65nm-stdcells/lef/uk65lscllmvbbr.lef]
#set ::IC_GDSMAP    $::UMC_HOME/UMK65FDKLLC00000OA_B11_DESIGNKIT/stream.map
set ::IC_GDSMAP    $::umcFolder/innovus_map.map

## Routing layers
#set ::IC_CTS_ROUTE_RULE_BOTTOM  M${::IC_CTS_ROUTE_RULE_BOTTOM}
#set ::IC_CTS_ROUTE_RULE_TOP     M${::IC_CTS_ROUTE_RULE_TOP}

## Power
set ::IC_POWER_HORIZONTAL_LAYER ME7
set ::IC_POWER_VERTICAL_LAYER   ME6

## Ignore some parameters for now
set ::IC_QRC_TECH_MIN false
set ::IC_QRC_TECH_MAX false


## Buffers etc..


set ::IC_CELLS_CLOCKBUFFERS   [list CKBUFM1R CKBUFM2R CKBUFM4R CKBUFM6R]

set ::IC_CELLS_CLOCKINVERTER [list CKINVM1R CKINVM2R CKINVM4R CKINVM6R]
set ::IC_CELLS_CLOCKGATING   [list ]

set ::IC_CELLS_TIE           [list TIE0R TIE1R]
set ::IC_CELLS_ANTENNA        ANTR
set ::IC_CELLS_FILLERS        [list FIL1R FIL2R FIL16R FIL32R]
set ::IC_CELLS_FILLCAPS        [list FILE3R FILE4R FILE6R FILEP8R FILEP16R]
