icApply route.setup {
    icRun set_mode.route
}
icApply route.run {

    ## Ensure Routing mode is set
    icRun set_mode.timing.ocv
    icRun set_mode.optDesign.routed
    

    ## Run routing
    routeDesign

	## CTS Fixing if necessary
    icRun set_mode.optDesign.routed
	ccopt_pro
	

}


icApply route.opt.vias {

    ## Optimize vias
    ###############
    setNanoRouteMode -drouteMinSlackForWireOptimization 0.1
	setNanoRouteMode -droutePostRouteSwapVia multiCut
	routeDesign -viaOpt
}


icApply route.opt.bcwc {
    
    icRun set_mode.timing.bcwc
    icRun set_mode.optDesign.routed

    optDesign -postRoute
	optDesign -postRoute -hold

    icf_utils_timedesign $reportFolder/timing routed_setup -postRoute
    icf_utils_timedesign $reportFolder/timing routed_hold  -postRoute -hold

}
icApply route.opt.ocv {
    
    
    icRun set_mode.optDesign.routed
    icRun set_mode.timing.ocv

    optDesign -postRoute
	optDesign -postRoute -hold

    icf_utils_timedesign $reportFolder/timing routed_setup -postRoute
    icf_utils_timedesign $reportFolder/timing routed_hold  -postRoute -hold

}

icApply route.time.bcwc {

    icRun set_mode.optDesign.routed
    icRun set_mode.timing.bcwc

    icf_utils_timedesign $reportFolder/timing routed_bcwc_setup -postRoute
    icf_utils_timedesign $reportFolder/timing routed_bcwc_hold  -postRoute -hold

}

icApply route.time.ocv {

    icRun set_mode.optDesign.routed
    icRun set_mode.timing.ocv

    icf_utils_timedesign $reportFolder/timing routed_ocv_setup -postRoute
    icf_utils_timedesign $reportFolder/timing routed_ocv_hold  -postRoute -hold

}

icApply route.fix_drc {
    ## Check DRC 
    icf_utils_verify_drc -no_fillers

	## Fix DRC
	ecoRoute -target

    ## Check DRC 
    icf_utils_verify_drc -no_fillers
    #routeDesign
}

icApply route.fix_drc_agressive {
    ## Check DRC 
    icf_utils_verify_drc -no_fillers

	## Delete DRC violating wires and reroute
    editDelete -regular_wire_with_drc
    routeDesign

    ## Check DRC 
    icf_utils_verify_drc -no_fillers
    #routeDesign
}

icApply route.post {
    ::innovus::saveAfterStep route
}
