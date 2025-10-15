package require icflow 1.0

set genus1Folder [file normalize [file dirname [info script]]]

set ::IC_STAGE SYN

## Define Parameters
####################
icCheckEnvVariables BASE

icSource flow_common/mmmc_v1/mmmc_parameters.tcl
icSource flow_common/physical_parameters_v1.tcl

icDefineParameter IC_TOP "Name of the toplevel module"

icDefineParameter IC_NETLIST_F           "Path to Netlist F File"               false
icDefineParameter IC_GENERATE_SV_WRAPPER "Request SV Wrapper generation (for designs using SV interfaces at the top level)" 10
icDefineParameter IC_VERILOG_DEFINES "List of defines for read_hdl step" {}
icDefineParameter IC_GTL_EXTENSION       "File extension for GTL netlist, default to 'v' for verilog, can be set to sv" v


icDefineParameter IC_CELLS_DONTUSE "A list of don't use cells" {}

icDefineParameter IC_CLOCKGATING "True/False to enable/disable clock gating"    true
icDefineParameter IC_POWEREFFORT "General Power Effort configuration"           low

icDefineParameter IC_SYN_EFFORT "Set the effort for Synthesis" low
icDefineParameter IC_SYN_OPT_EFFORT "Set the effort for post-mapping opt" low
icDefineParameter IC_SYN_INSERT_SCANCHAIN_ENABLE "Set to true to enable scan chain insertion" false
icDefineParameter IC_SYN_PHYSICAL_ENABLE "Set to true to enable Physical synthesis" false

icDefineParameter IC_SYN_GENERIC_ARGS   "Extra Args for syn generic" {}
icDefineParameter IC_SYN_MAP_ARGS       "Extra Args for syn map" {}
icDefineParameter IC_SYN_OPT_ARGS       "Extra Args for syn opt" {}
## Define steps
############
icDefineStep parameters             "Checks the required parameters for this flow"
icDefineStep configure              "Configures Genus with top level attributes"
icDefineStep mmmc                   "Loads the MultiMode/MultiCorner Configuration"
icDefineStep read_hdl               "Load the HDL Design"
icDefineStep elaborate              "Elaborate"
icDefineStep init                   "Init the whole design, HDL + Timing config"
icDefineStep dft                    "Setup DFT"
icDefineStep synthesize.generic     "Synthesis Generic"
icDefineStep synthesize.map         "Synthesis Map"
icDefineStep synthesize.opt         "Synthesis Opt"
icDefineStep finish                 "Finish by saving outputs"



## Flows
#############


proc flow_elaborate args {
    icRun parameters
    icRun configure
    icRun mmmc
    icRun read_hdl
    icRun elaborate
}


proc flow_init args {
    flow_elaborate
    icRun init
}

proc flow_full args {
    flow_init
    icRun synthesize
    icRun finish
}

proc flow_full_dft args {
    set ::IC_SYN_INSERT_SCANCHAIN_ENABLE true
    flow_init
    icRun dft
    icRun synthesize
    icRun finish
}


## Code for the Flow
###############

icApply parameters.post {
    icflow::report::resetSummaryMD
    icflow::report::summaryToHTML
}

icApply parameters {

    icCheckParametersFromGlobalVariables
    if {[icCheckHasErrors]} {
        ## If an error occured, force creating summary to have a nice view
        icInfo "Error found in parameters, check all parameters are defined"
        icflow::report::resetSummaryMD
        icflow::report::summaryToHTML
    }
}

icApply configure {

    set_db information_level 3

    ## Warning that cells are not aligned to origin in LEF
    suppress_messages PHYS-127

    ## Globally enable/disable clock gating here first
    set_db lp_insert_clock_gating       $::IC_CLOCKGATING
    set_db lp_clock_gating_infer_enable $::IC_CLOCKGATING

    ## Power config
    set_db design_power_effort $::IC_POWEREFFORT

    ## Utility configs
    set_db lib_lef_consistency_check_enable true

    ##  HDL configs
    set_db hdl_error_on_blackbox true
    set_db hdl_track_filename_row_col 1
    set_db hdl_keep_first_module_definition false
    if {${::IC_GENERATE_SV_WRAPPER}==1} {
        set_db hdl_sv_module_wrapper $::IC_GENERATE_SV_WRAPPER
    }

    #set_multi_cpu_usage -local_cpu 1 -verbose
}

icApply mmmc {
    #icCheckGVariable MMMC_SLOW_LIB
    #icCheckGVariable MMMC_SLOW_CDB
    #icCheckGVariable MMMC_FAST_LIB
    #icCheckGVariable MMMC_FAST_CDB
    read_mmmc [icSourcePath flow_common/mmmc_v1/common_load_mmmc.tcl]

    #read_physical -lefs [list  $STD_CELLS($cell_lib/lef/$selected_metal) $STD_CELLS($cell_lib/lef/common) ]
    read_physical -lefs [concat $::IC_LEF_FILES $::IC_USER_LEF_FILES]

    #suspend
    if {[file exists $::IC_QRC_TECH_MAX]} {
        set_db qrc_tech_file $::IC_QRC_TECH_MAX
    }

}

icApply read_hdl {
    if {$::IC_NETLIST_F == false } {
        icError "Read HDL not doing anything because no path to SystemVerilog F File was given (::IC_NETLIST_F parameter)"
    } else {
        #puts "HDL args: [llength $::IC_HDL_ARGS]"
        #read_hdl [split [join $::IC_HDL_ARGS]]
        icInfo "Reading F File $::IC_NETLIST_F"
        mkdir -p icflow/read_hdl
        genus::cleanFFile $::IC_NETLIST_F icflow/read_hdl/hdl_netlist.f
        #uplevel #0 [list read_hdl -language sv -f $::IC_HDL_SV_F]
        read_hdl -sv -f icflow/read_hdl/hdl_netlist.f -define ${::IC_VERILOG_DEFINES}
    }

}

icApply elaborate {
    elaborate $::IC_TOP
}

icApply init {

    ## Init Design
    ###############
    init_design

    ## Check failed SDC
    if {[llength $::dc::sdc_failed_commands]>0} {
        icWarn "There are some failed SDC commands, please check and re-run"
        suspend
    }


}

icApply init.post {

    ## Check Design
    ##########
    check_design -all > check_design.rpt

    report_messages -all

    ## Timing Lint Output, very important to check for wrong things leading to massive logic optimisation
    report timing -lint          > $reportFolder/timing_lint.rpt
    report timing -lint -verbose > $reportFolder/timing_lint.verbose.rpt

    ## Report PLE Config
    ############
    report ple > $reportFolder/ple.rpt


    ## Define cost groups (clock-clock, clock-output, input-clock, input-output)
    ## This is Taken from Genus Reference example template
    ###################################################################################
    icInfo "Creating Cost groups"
    source $::genus1Folder/create_default_cost_groups.tcl

}

icApply dft {

    ##################################################################################################
    ## DFT Setup
    ##################################################################################################

    set_db / .dft_scan_style muxed_scan

    set_db / .dft_prefix DFT_
    # For VDIO customers, it is recommended to set the value of the next two attributes to false.
    set_db / .dft_identify_top_level_test_clocks true
    set_db / .dft_identify_test_signals true

    set_db / .dft_identify_internal_test_clocks false
    set_db / .use_scan_seqs_for_non_dft false

    set_db "design:$::IC_TOP" .dft_scan_map_mode tdrc_pass
    set_db "design:$::IC_TOP" .dft_connect_shift_enable_during_mapping tie_off
    set_db "design:$::IC_TOP" .dft_connect_scan_data_pins_during_mapping loopback
    set_db "design:$::IC_TOP" .dft_scan_output_preference auto
    set_db "design:$::IC_TOP" .dft_lockup_element_type preferred_level_sensitive
    set_db "design:$::IC_TOP" .dft_min_number_of_scan_chains 1
    set_db "design:$::IC_TOP" .dft_mix_clock_edges_in_scan_chains true

    #set_db <instance or subdesign> .dft_dont_scan true
    #set_db "<from pin> <inverting|non_inverting>" .dft_controllable <to pin>

    #define_test_clock -name testclk20M -domain clk_20 "clk_20M_ext clk_20M_pll"
    define_shift_enable -name scan_enable -active high -create_port scan_enable
    define_scan_chain -name top_chain -sdi scan_in -sdo scan_out -shift_enable scan_enable -create_ports
    #define_test_mode -name scan_mode -active high -create_port scan_mode

    # Important to set test signal for clock gating otherwise gated signals are uncontrolable by scanchain
    set_db "design:$::IC_TOP" .lp_clock_gating_test_signal scan_enable

    ## If you intend to insert compression logic, define your compression test signals or clocks here:
    ## define_test_mode...  [-shared_in]
    ## define_test_clock...
    #########################################################################
    ## Segments Constraints (support fixed, floating, preserved and abstract)
    ## only showing preserved, and abstract segments as these are most often used
    #############################################################################

    ##define_scan_preserved_segment -name <segObject> -sdi <pin|port|subport> -sdo <pin|port|subport> -analyze
    ## If the block is complete from a DFT perspective, uncomment to prevent any non-scan flops from being scan-replaced
    #set_db [get_db insts -if {.is_sequential==true && .dft_mapped==false}] .dft_dont_scan true
    ##define_scan_abstract_segment -name <segObject> <-module|-insts|-libcell> -sdi <pin> -sdo <pin> -clock_port <pin> [-rise|-fall] -shift_enable_port <pin> -active <high|low> -length <integer>
    ## Uncomment if abstract segments are modeled in CTL format
    ##read_dft_abstract_model -ctl <file>
}

icApply synthesize.pre {

    icInfo "Don't use cells: $::IC_CELLS_DONTUSE, llen=[llength $::IC_CELLS_DONTUSE],strlen=[string length $::IC_CELLS_DONTUSE]"
    if {[llength $::IC_CELLS_DONTUSE]>0} {
        dc::set_dont_use [get_lib_cells $::IC_CELLS_DONTUSE] false
    }

    if {$::IC_SYN_PHYSICAL_ENABLE && [file exists ../par/floorplan/floorplan.def]} {
        icInfo "Using DEF from Innovus for physical synthesis at ../par/floorplan/floorplan.def "

        # Physical Synthesis Mode -> no wire delay
        set_db interconnect_mode ple

        ## Effort
        set_db phys_flow_effort         $::IC_SYN_EFFORT


        read_def ../par/floorplan/floorplan.def

        lappend ::IC_SYN_GENERIC_ARGS   -physical
        lappend ::IC_SYN_MAP_ARGS       -physical
        lappend ::IC_SYN_OPT_ARGS       -spatial


    } else {

        set ::IC_SYN_PHYSICAL_ENABLE false

        if {$::IC_SYN_INSERT_SCANCHAIN_ENABLE} {
            check_dft_rules
        }

    }

    ## Set Effort
    set_db / .syn_generic_effort    $::IC_SYN_EFFORT
    set_db / .syn_map_effort        $::IC_SYN_EFFORT
    set_db / .syn_opt_effort        $::IC_SYN_OPT_EFFORT

}

icApply synthesize.generic {

    syn_generic ${::IC_SYN_GENERIC_ARGS}
}

icApply synthesize.map {

    syn_map ${::IC_SYN_MAP_ARGS}
}

icApply synthesize.opt {

    syn_opt ${::IC_SYN_OPT_ARGS}

    if {$::IC_SYN_INSERT_SCANCHAIN_ENABLE} {
        check_dft_rules >  $reportFolder/${::IC_TOP}-tdrcs
        #syn_opt -incremental
        connect_scan_chains -auto_create_chains -preview
        suspend
        connect_scan_chains -auto_create_chains

        ## Run the DFT rule checks
        #check_dft_rules >  $reportFolder/${::IC_TOP}-tdrcs
        report_scan_registers > $reportFolder/${::IC_TOP}-DFTregs
        report_scan_setup > $reportFolder/${::IC_TOP}-DFTsetup_tdrc

        #syn_opt -incremental -effort high

        ## Fix the DFT Violations
        ## Uncomment to fix dft violations
        ## set numDFTviolations [check_dft_rules]
        ## if {$numDFTviolations > "0"} {
        ##   report_dft_violations > $_REPORTS_PATH/${DESIGN}-DFTviols
        ##   fix_dft_violations -async_set -async_reset [-clock] -test_control <TestModeObject>
        ##   check_dft_rules
        ## }

        ##  Run the Advanced DFT rule checks to identify:
        ## ...  x-source generators, internal tristate nets, and clock and data race violations
        ## Note:  tristate nets are reported for busses in which the enables are driven by
        ## tristate devices.  Use 'check_design' to report other types of multidriven nets.

        check_design -multiple_driver
        check_dft_rules -advanced  > $reportFolder/${::IC_TOP}-Advancedtdrcs
        report_dft_violations -tristate -xsource -xsource_by_instance > $reportFolder/${::IC_TOP}-AdvancedDFTViols
    }

    syn_opt -incremental

    report_messages -all
}


icApply synthesize.post {

    ## Write Timing out
    mkdir -p $reportFolder/timing_summaries
    mkdir -p $reportFolder/timing_reports
    foreach cg [vfind / -cost_group *] {
        foreach mode [vfind / -mode *] {
            icInfo "Reporting timing for group $cg and view $mode "

            if {[genus::getMajorVersion]>=21} {
                report_timing -cost_group [list $cg] -mode $mode > $reportFolder/timing_reports/${::IC_TOP}_[vbasename $cg]_post_map.rpt
                report_timing -cost_group [list $cg] -mode $mode -path_type summary > $reportFolder/timing_summaries/${::IC_TOP}_[vbasename $cg]_post_map.summary
                report_timing -cost_group [list $cg] -mode $mode -output_format gtd > $reportFolder/timing_reports/${::IC_TOP}_[vbasename $cg]_post_map.gtd
            } else {
                report_timing -cost_group [list $cg] -mode $mode > $reportFolder/timing_reports/${::IC_TOP}_[vbasename $cg]_post_map.rpt
                report_timing -cost_group [list $cg] -mode $mode -summary > $reportFolder/timing_summaries/${::IC_TOP}_[vbasename $cg]_post_map.summary
                report_timing -cost_group [list $cg] -mode $mode -gtd > $reportFolder/timing_reports/${::IC_TOP}_[vbasename $cg]_post_map.gtd
            }



        }
    }

    ## Save
    genus::saveAfterStep synthesize

}

icApply finish {


    #print reports to the console and the log file
    puts "Finishing, report folder: $reportFolder"

    mkdir -p $reportFolder


    if {$::IC_SYN_INSERT_SCANCHAIN_ENABLE} {
        ## DFT Reports
        report_scan_setup > $reportFolder/${::IC_TOP}-DFTsetup_final
        write_scandef > $reportFolder/${::IC_TOP}-scanDEF
        write_dft_abstract_model > $reportFolder/${::IC_TOP}-scanAbstract
        write_hdl -abstract > $reportFolder/${::IC_TOP}-logicAbstract
        write_script -analyze_all_scan_chains > $reportFolder/${::IC_TOP}-writeScript-analyzeAllScanChains
        ## check_atpg_rules -library <Verilog simulation library files> -compression -directory $MODUS_WORKDIR
        ## write_dft_jtag_boundary_verification -library <Verilog structural library files> -directory $MODUS_WORKDIR
        mkdir -p dft
        write_dft_atpg -library /adl/design_kits/pdk-ams/ac18-ah18-414_2311/verilog/ah18a6/ah18_CORELIB_DCV_HV.v -compression -directory dft/
    }

    report gates
    report gates > $reportFolder/gates.rpt

    #report timing -mode test
    #report timing -mode functional
    report qor
    report qor          > $reportFolder/qor.rpt
    report_clock_gating > $reportFolder/cgate.rpt

    report power        > $reportFolder/power.rpt

    ## Timing Lint Output, very important to check for wrong things leading to massive logic optimisation
    report timing -lint          > $reportFolder/timing_lint.rpt
    report timing -lint -verbose > $reportFolder/timing_lint.verbose.rpt

    ## Write Backend Files
    ###############################
    icInfo "Netlist written to: netlist/${::IC_TOP}.gtl.${::IC_GTL_EXTENSION}"

    exec mkdir -p netlist
    report_summary -directory $reportFolder/
    write_hdl  > netlist/${::IC_TOP}.gtl.${::IC_GTL_EXTENSION}
    write_hdl  > $reportFolder/${::IC_TOP}.gtl.${::IC_GTL_EXTENSION}

    if {${::IC_GENERATE_SV_WRAPPER}==1} {
        catch {write_sv_wrapper  -wrapper_name ${::IC_TOP}_W  -exclude_type_definition  $::IC_TOP > netlist/${::IC_TOP}.wrapper.sv}
    }

}

icApply finish.post {

    genus::saveAfterStep finish
}







## Utils
##############

## Define icRestore Command
###########

proc icRestore step {
    set targetFiles [glob icflow/saves/$step/$step*.db]
    if {[llength $targetFiles]==0} {
        icError "Cannot restore, no db file found in directory icflow/saves/$step/"
    } else {
        read_db [lindex $targetFiles 0]
    }

}

proc onGenus script {
    set exe [info nameofexecutable]
    if {[string match */genus $exe]} {
        uplevel $script
    }
}

namespace eval genus {

    proc getMajorVersion args {
        return [lindex [split [get_db / .program_version] .] 0]
    }

    proc saveAfterStep step {
        mkdir -p icflow/saves/$step
        write_snapshot -outdir icflow/saves/$step -tag $step
    }

    proc cleanFFile {in out args} {

        set results [dict create]
        set nextF {}
        set fchan [open $in]

        if {[lsearch -exact $args -append]==-1} {
            set outchan [open $out w+]
        } else {
            set outchan [open $out a+]
        }


        while {[gets $fchan line] >= 0} {

                #set line [odfi::common::resolveEnvVariable [string trim $line]]
                set line [string trim $line]
                #puts "Parsing line: $line"


                ## Use Switch
                ###################
                switch -glob -- $line {

                    "" {

                    }
                    "#*" {

                    }
                    "-f*" {

                        lappend nextF [icflow::utils::resolveEnvVariable  [regsub -- {-f\s*(.+)} $line {\1}]]

                    }
                    default {
                        puts $outchan $line
                    }
                }
        }
        close fchan
        close $outchan

        ## Process other F Files
        foreach fFile $nextF {
            cleanFFile $fFile $out -append
        }

    }
}
