
icCheckEnvVariables {BASE ADL_HOME}

set innovus1Folder [file normalize [file dirname [info script]]]


set ::IC_STAGE PAR

## Load Common Parameters
###################
icSource flow_common/mmmc_v1/mmmc_parameters.tcl
icSource flow_common/physical_parameters_v1.tcl

## Parameters
##################
icDefineParameter IC_RUN_TYPE         "The Type of run"                             default
icDefineParameter IC_POWER_VDD_NAME   "The name of the VDD Global Wire"             VDD
icDefineParameter IC_POWER_GND_NAME   "The name of the GND Global Wire"             GND
icDefineParameter IC_POWER_HORIZONTAL_LAYER  "Layer for Horizontal Ring/Stripes"
icDefineParameter IC_POWER_VERTICAL_LAYER     "Layer for Vertical Ring/Stripes"

#icDefineParameter IC_STDCELL_VDD_NAME "The name of the Stdcells Global Wire"
#icDefineParameter IC_STDCELL_GND_NAME "The name of the Stdcells GND Global Wire"

icDefineParameter IC_CELLS_CLOCKINVERTER        "The list of Cells used for Clock Inverting"
icDefineParameter IC_CELLS_CLOCKBUFFERS         "The list of Cells used for Clock Buffering"
icDefineParameter IC_CELLS_CLOCKGATING          "The list of Cells used for Clock Gating"
icDefineParameter IC_CELLS_FORBIDDEN_BUFFERS    "List of Buffers or Cells to forbid"
icDefineParameter IC_CELLS_TIE                  "List of Tie Cells"
icDefineParameter IC_CELLS_ANTENNA              "The name of the Antenna Cell"
icDefineParameter IC_CELLS_FILLERS              "List of Filler Cells"
icDefineParameter IC_CELLS_FILLCAPS              "List of Fillcaps Cells"

icDefineParameter IC_CTS_ROUTE_RULE_BOTTOM  "Bottom Layer for CTS Routing Rule"
icDefineParameter IC_CTS_ROUTE_RULE_TOP     "Top Layer for CTS Routing Rule"

icDefineParameter IC_ROUTING_BOTTOM     "Bottom Layer for main Routing"
icDefineParameter IC_ROUTING_TOP        "Top Layer for main Routing"

icDefineParameter IC_PAR_NETLIST     "Path for Netlist to load" false

## Define steps
############
icSource flow_common/step_parameters_v1.tcl

icDefineStep {set_mode place cts route timing.bcwc timing.ocv optDesign.routed} "Utility Steps to set mode options"
#icDefineStep {optDesign routed.bcwc routed.ocv} "Utility Steps to set mode options"

icDefineStep load_design                "Configures Genus with top level attributes"
icDefineStep {floorplan die blocks tap_spare pins power} "Loads the MultiMode/MultiCorner Configuration"
icDefineStep {place run addTieHighLow}  "Load the HDL Design"
icDefineStep {cts setup run opt}        "Run Clock Tree Synthesis"
icDefineStep {route setup run opt.vias opt.bcwc opt.ocv time.bcwc time.ocv fix_drc}          "Run Routing"
icDefineStep fill                       "Place filler cells"
icDefineStep signoff_timing             "Timing with Signoff config"
icDefineStep streamout                  "Finish by saving outputs"

icSourceScripts ./step*.tcl
icSourceScripts ./par-step*.tcl -maindir


## Utilities
#################
namespace eval innovus {

    proc saveAfterStep step {
        mkdir -p icflow/saves/$step
        saveDesign icflow/saves/$step/${step}.enc
    }

}

proc icRestore step {
    set targetFiles [glob icflow/saves/$step/$step*.enc]
    if {[llength $targetFiles]==0} {
        icError "Cannot restore, no enc file found in directory icflow/saves/$step/"
    } else {
        sourceFile [lindex $targetFiles 0]
    }

}

proc onInnovus script {
    set exe [info nameofexecutable]
    if {[string match */innovus $exe]} {
        uplevel $script
    }
}

proc icf_utils_verify_drc args {

	clearDrc
	verifyConnectivity -noAntenna
	#verify_drc -ignore_trial_route -report verifyDRC.rpt
	verify_drc
	verifyProcessAntenna
	verifyTieCell
    ## if nofiller not found, run filler check
    if {[lsearch -exact $args -no_fillers]==-1} {
        checkFiller
    }

}


proc icf_utils_fix_drc args {

	icf_utils_verify_drc -no_fillers
	setNanoRouteMode -reset
	ecoRoute
	ecoRoute -fix_drc
	icf_utils_verify_drc -no_fillers

}


proc icf_utils_timedesign {folder prefix args} {

    exec mkdir -p $folder
    set cmdArgs [concat -expandedViews -outDir $folder/ -numPaths 100 -prefix $prefix $args]

    ## If Signoff, use signoff command type to switch to tempus
    ## Doesn't work at the moment (too did not start error), investigating
    if {[lsearch $args -signoff]!=-1} {
        #icWarn "Requested Signoff timing, using signoffTimeDesign command"
        #signoffTimeDesign -outDir $folder/ -prefix $prefix
        timeDesign {*}$cmdArgs
    } else {
        timeDesign {*}$cmdArgs
    }


}

## Use this utility to check which pins are not placed, or maybe wrongly placed
proc icf_utils_info_pins_placement args {
    set ignores {
        pin_guide
        pin_layer
        pin_on_fence
        pin_on_track
    }
    checkPinAssignment  -ignore $ignores

    ## Get Unplaced Pins
    set unplacedPins [dbGet -p top.terms.pStatus unplaced]
    if {[llength $unplacedPins]==1 && [lindex $unplacedPins 0]==0} {
        icInfo "*ADL*: All pins are placed :-)"
    } else {
        icWarn "*ADL*: Some pins are not placed, here's the list:"
        foreach pinName [dbGet ${unplacedPins}.name] {
            icWarn "- [lindex $pinName 0]"
        }
    }

}

## Scripts
###########
icApply load_design {

	## First Free the design
	################
	catch {freeDesign}

	## 180nm configuration
	####################

	setDesignMode -process ${::IC_PROCESS_NODE}
	setDelayCalMode -engine default -signoff false -SIAware true

    #set ::init_cpf_file ./test.cpf
    set ::init_lef_file $::IC_LEF_FILES
	puts "LEF: ${::init_lef_file}"

	#set ::init_lef_file [list \ $STD_CELLS($cell_lib/lef/$selected_metal) \ $STD_CELLS($cell_lib/lef/common) ]

	## Tool setup
	#######################
	setLimitedAccessFeature ediUsePreRouteGigaOpt 1
	#setDesignMode -highSpeedCore true
	setMultiCpuUsage -localCpu 8 -keepLicense false
	setDistributeHost -local

	## Set Design
	###############################
    if {${::IC_PAR_NETLIST}!=false} {
         set ::init_verilog ${::IC_PAR_NETLIST}
    }  else {
        set ::init_verilog "../synthesis/netlist/${::IC_TOP}.gtl.v"
    }
	set ::init_top_cell ${::IC_TOP}
	set init_design_uniquify 1

	#### MMMC Setup
	###############################

	puts "Will Load MMMC mode"

	#source ../OA/innovus/out.mmmc.tcl
    if {[catch {set ::IC_MMMC_CONSTRAINTS_FUNCTIONAL}]} {
        icWarn "No Constraints defined, not loaded MMMC views"
    } else {
        #icSource flow_common/mmmc_v1/common_load_mmmc.tcl
        set ::init_mmmc_file [icSourcePath flow_common/mmmc_v1/common_load_mmmc.tcl]
    }

	#source  $location/../common_load_mmmc.tcl
	puts "Out of load libraries \n"

	## Init
	#########################
	#suppressMessage ENCLF-122
    set_message -id IMPFP-3961 -no_limit

	## Init design by giving corner pairs for hold/setup
	puts "########################## INIT DESIGN #####################################"
    if {[catch {set ::IC_MMMC_CONSTRAINTS_FUNCTIONAL}]} {
        if {${::IC_STAGE}=="PRQ"} {
            init_design
        } else {
            init_design
        }
    } else {
        if {${::IC_STAGE}=="PRQ"} {
            init_design  -setup {functional_slowHT} -hold {functional_fastLT}
        } else {
            init_design  -setup {functional_slowHT} -hold {functional_fastLT}
        }
    }

	#init_design  -setup {functional_800p_slowHT functional_1n25_slowHT} -hold {functional_800p_fastLT functional_1n25_fastLT}
	#init_design  -setup { functional_1n25_slowHT} -hold { functional_1n25_fastLT}
	#init_design  -setup {functional_800p_slowHT} -hold {functional_800p_fastLT}
	#puts "########################## EOF INIT DESIGN #####################################"
}

icApply floorplan.post {

    ::innovus::saveAfterStep floorplan

    ## Save Plan
	exec mkdir -p floorplan
	defOut -floorplan ./floorplan/floorplan.def

    ## Info
    icf_utils_info_pins_placement
}
