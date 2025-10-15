
icApply set_mode.place {

    setDesignMode -bottomRoutingLayer   ${::IC_ROUTING_BOTTOM}
    setDesignMode -topRoutingLayer      ${::IC_ROUTING_TOP}

    setDesignMode -earlyClockFlow true

    setPlaceMode -reset
    setPlaceMode -timingDriven true -wireLenOptEffort high -congEffort high
	setPlaceMode -check_inst_space_group true

    setOptMode -reset
    setOptMode -allEndPoints true
    setOptMode -fixFanoutLoad true
    setOptMode -usefulSkew true
}

icApply set_mode.cts {



	setExtractRCMode -engine preroute
	setNanoRouteMode -reset
	setDesignMode -topRoutingLayer ${::IC_ROUTING_TOP} -bottomRoutingLayer ${::IC_ROUTING_BOTTOM}
	setNanoRouteMode  -routeWithTimingDriven true \
		-routeWithSiDriven true  \
		-routeWithViaInPin true \
		-routeWithViaOnlyForStandardCellPin 1:1 \
		-drouteUseMultiCutViaEffort high

	## Allowed Cells
	#set_ccopt_property buffer_cells 	$clockbuffer_cells
	## Leave empty to force non inverters to be not used
	set_ccopt_property buffer_cells 	    ${::IC_CELLS_CLOCKBUFFERS}
	set_ccopt_property inverter_cells	    ${::IC_CELLS_CLOCKINVERTER}
	set_ccopt_property clock_gating_cells   ${::IC_CELLS_CLOCKGATING}

	set_ccopt_property use_inverters true

	## Create Non default Route for double spacing double width
	#set non_default_rule width2x_space2x

	## Create Route Types -non_default_rule $non_default_rule
    #############
    icIgnoreError {
        catch {delete_route_type -name leaf_rule}
        catch {create_route_type -name leaf_rule    -top_preferred_layer ${::IC_CTS_ROUTE_RULE_TOP} -bottom_preferred_layer ${::IC_CTS_ROUTE_RULE_BOTTOM}}

    }


    #############
    ## Old -> maybe bit useless, simplify
	#catch {delete_route_type -name leaf_rule}
	#create_route_type -name leaf_rule -non_default_rule $non_default_rule   -top_preferred_layer M3 -bottom_preferred_layer M2

	#catch {delete_route_type -name trunk_rule}
	#create_route_type -name trunk_rule -non_default_rule $non_default_rule	-top_preferred_layer M3 -bottom_preferred_layer M3
	## disabled clock shielding  -shield_net GND

	#catch {delete_route_type -name top_rule}
	#create_route_type -name top_rule   -non_default_rule $non_default_rule	-top_preferred_layer M4 -bottom_preferred_layer M4
	###############

	set_ccopt_property -net_type leaf 	route_type leaf_rule
	set_ccopt_property -net_type trunk 	route_type leaf_rule
    # Top Tree routing will be done for large trees only
    set_ccopt_property -net_type top route_type leaf_rule
	set_ccopt_property  routing_top_min_fanout 10000
}

icApply set_mode.route {


    setDesignMode -bottomRoutingLayer   ${::IC_ROUTING_BOTTOM}
    setDesignMode -topRoutingLayer      ${::IC_ROUTING_TOP}

    setNanoRouteMode \
		-routeWithTimingDriven true \
		-routeWithSiDriven true  \
		-routeWithViaInPin true \
		-routeWithViaOnlyForStandardCellPin 1:1 \
		-drouteUseMultiCutViaEffort medium

    setNanoRouteMode -routeEnforceNdrOnSpecialNetWire true
	setNanoRouteMode -droutePostRouteSwapVia multiCut

    ## Antenna Fix (Bridging + Diodes)
	setNanoRouteMode -drouteFixAntenna              true
	setNanoRouteMode -routeInsertAntennaDiode		true
	setNanoRouteMode -routeAntennaCellName          ${::IC_CELLS_ANTENNA}
	setNanoRouteMode -routeInsertDiodeForClockNets  true
	setNanoRouteMode -drouteEndIteration 			default
}

icApply set_mode.optDesign.routed {

    ## Make sure Routing parameters are correct!
    icRun set_mode.route

    setOptMode -reset
	setOptMode -fixFanoutLoad true
	setOptMode -fixDrc true
	setOptMode -powerEffort low
	setOptMode -fixHoldAllowSetupTnsDegrade true

	## Submission last fix
	setOptMode -fixHoldAllowResizing false
	setOptMode -enableDataToDataChecks true
	setOptMode -postRouteAreaReclaim  holdAndSetupAware

	## Changed to standard
	setOptMode -usefulSkewCCOpt standard
	setOptMode -usefulSkewPostRoute false

    setDesignMode -flowEffort standard
}

icApply set_mode.timing.bcwc  {

    setAnalysisMode -reset
	setExtractRCMode -reset
    setDelayCalMode -reset

	## No SI Aware to optimise without OCV
	setDelayCalMode -SIAware false
	setExtractRCMode -engine postRoute -coupled true

    setAnalysisMode -analysisType bcwc -skew true  -clockPropagation sdcControl -cppr both

}

icApply set_mode.timing.ocv  {


    setAnalysisMode -reset
	setExtractRCMode -reset
    setDelayCalMode -reset

	## SI Aware to optimise with OCV
	setDelayCalMode -SIAware true
	setExtractRCMode -engine postRoute -coupled true
	setAnalysisMode -analysisType onChipVariation -skew true  -clockPropagation sdcControl -cppr both

	set_timing_derate -delay_corner slowHTrcw -late 1 -early 0.8 -clock


}
