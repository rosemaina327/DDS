## Base Parameters and variables
##########################

## Base from environment
set BASE $::env(BASE)


## Load Library files using Multi Mode Multi Corner
#########################

#### First: Create Library Sets
if {$::IC_MMMC_SLOW_CDB!=false} {
    create_library_set -name slowHT \
        -timing $::IC_MMMC_SLOW_LIB \
        -si     $::IC_MMMC_SLOW_CDB
} else {
    create_library_set -name slowHT \
        -timing $::IC_MMMC_SLOW_LIB
}
if {$::IC_MMMC_FAST_CDB!=false} {
    create_library_set -name fastLT \
        -timing $::IC_MMMC_FAST_LIB \
        -si     $::IC_MMMC_FAST_CDB
} else {
    create_library_set -name fastLT \
        -timing $::IC_MMMC_FAST_LIB
}


#create_library_set -name slowHT -timing /adl/design_kits/pdk-ams/ac18-ah18-414_2311/liberty/ah18_1.8V/ah18_CORELIB_DCV_HV_WC.lib
#create_library_set -name fastLT -timing /adl/design_kits/pdk-ams/ac18-ah18-414_2311/liberty/ah18_1.8V/ah18_CORELIB_DCV_HV_BC.lib
#### Second: Constraints
create_constraint_mode -name functional 		-sdc_files $::IC_MMMC_CONSTRAINTS_FUNCTIONAL
#create_constraint_mode -name functional 		-sdc_files $BASE/implementation/constraints/constraints_functionalModeSyn.sdc
#create_constraint_mode -name test 				-sdc_files $BASE/implementation/constraints/constraints_testModeSyn.sdc

#### Third: Create a delay corner
##############

## Adapt arguments based on parameters
set rcCornerMaxArgs {}
set rcCornerMinArgs {}
if {[info exists $::IC_CAPTABLE_MAX]} {
    lappend rcCornerMaxArgs -cap_table $::IC_CAPTABLE_MAX
}
if {[info exists $::IC_CAPTABLE_MIN]} {
    lappend rcCornerMinArgs -cap_table $::IC_CAPTABLE_MIN
}


if {${::IC_STAGE} == "SYN" } {

    if {[file exists $::IC_QRC_TECH_MAX]} {
        lappend rcCornerMaxArgs -qrc_tech $::IC_QRC_TECH_MAX
    }
    if {[file exists $::IC_QRC_TECH_MIN]} {
        lappend rcCornerMinArgs -qrc_tech $::IC_QRC_TECH_MIN
    }

    puts "Args: $rcCornerMaxArgs // $rcCornerMinArgs"
	#  -cap_table $::IC_CAPTABLE_MIN
    create_rc_corner -name rcfastLT \
	-pre_route_res          0.5 \
	-pre_route_cap          0.93 \
	-pre_route_clock_res    0.5 \
	-pre_route_clock_cap    0.93 \
	-post_route_res          0.5 \
	-post_route_cap          0.93 \
	-post_route_clock_res    0.5 \
	-post_route_clock_cap    0.93 \
	-temperature $::IC_MMMC_FAST_CORNER_TEMPERATURE {*}$rcCornerMinArgs

    create_rc_corner -name rcslowHT \
	-pre_route_res              1.5 \
	-pre_route_cap              1.07 \
	-pre_route_clock_res        1.5 \
	-pre_route_clock_cap        1.07 \
	-post_route_res             1.5 \
	-post_route_cap             1.07 \
	-post_route_clock_res       1.5 \
	-post_route_clock_cap       1.07 \
	-temperature $::IC_MMMC_SLOW_CORNER_TEMPERATURE {*}$rcCornerMaxArgs

} else {

    if {[file exists $::IC_QRC_TECH_MAX]} {
        lappend rcCornerMaxArgs -qx_tech_file $::IC_QRC_TECH_MAX
    }
    if {[file exists $::IC_QRC_TECH_MIN]} {
        lappend rcCornerMinArgs -qx_tech_file $::IC_QRC_TECH_MIN
    }

    create_rc_corner -name rcfastLT \
	-preRoute_res 0.5 \
	-preRoute_cap 0.93 \
	-preRoute_clkres 0.5 \
	-preRoute_clkcap 0.93 \
	-postRoute_res 0.5 \
	-postRoute_cap 0.93 \
	-postRoute_clkres 0.5 \
	-postRoute_xcap 0.93 \
	-T $::IC_MMMC_FAST_CORNER_TEMPERATURE {*}$rcCornerMaxArgs

    create_rc_corner -name rcslowHT \
	-preRoute_res 1.5 \
	-preRoute_cap 1.07 \
	-preRoute_clkres 1.5 \
	-preRoute_clkcap 1.07 \
	-postRoute_res 1.5 \
	-postRoute_cap 1.07 \
	-postRoute_clkres 1.5 \
	-postRoute_xcap 1.07 \
	-T $::IC_MMMC_SLOW_CORNER_TEMPERATURE {*}$rcCornerMinArgs

}

if {${::IC_STAGE} == "SYN" } {

    create_timing_condition -name slowHT -library_sets slowHT
    create_timing_condition -name fastLT -library_sets fastLT

    create_delay_corner -name slowHTrcw -timing_condition slowHT -rc_corner rcslowHT
    create_delay_corner -name fastLTrcb -timing_condition fastLT -rc_corner rcfastLT

} else {

    # -opcond_library {ah18_CORELIB_HV_WC} -opcond {worst} -pg_net_voltages {vdd!@1.8}
    # -opcond_library {ah18_CORELIB_HV_BC} -opcond {best} -pg_net_voltages {vdd!@1.8} 
    create_delay_corner -name slowHTrcw -library_set slowHT  -rc_corner rcslowHT
    create_delay_corner -name fastLTrcb -library_set fastLT  -rc_corner rcfastLT

    update_delay_corner -name slowHTrcw -power_domain default
    update_delay_corner -name fastLTrcb -power_domain default

}

#### Final: Create view
create_analysis_view -name functional_slowHT -constraint_mode functional -delay_corner slowHTrcw
create_analysis_view -name functional_fastLT -constraint_mode functional -delay_corner fastLTrcb


