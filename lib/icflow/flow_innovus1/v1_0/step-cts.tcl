###################################
## CTS
####################################

icApply cts.setup {
    ## First remove clock trees to ease reusing this step when debugging
	#############
	reset_ccopt_config
	delete_ccopt_clock_trees *

	# Set ccopt properties
	icRun set_mode.cts

	## Create Clock Spec
	####################
	exec mkdir -p cts
	create_ccopt_clock_tree_spec -file ./cts/ccopt_spec.tcl
}

icApply cts.run {

    ####### New CCOPT ####################
	source cts/ccopt_spec.tcl

	#ccopt_design
	clock_opt_design

	cts_refine_clock_tree_placement
}

icApply cts.opt {

    setOptMode -reset
	setOptMode -powerEffort low
	setOptMode -usefulSkewCCOpt standard
	setOptMode -fixHoldAllowSetupTnsDegrade true
	setOptMode -usefulSkewCCOpt standard

	setExtractRCMode -engine preroute

	optDesign -postCTS
	optDesign -postCTS -hold

	#optDesign -postCTS -incr
	#optDesign -postCTS -hold -incr

	## Time Design
    ######################
    icf_utils_timedesign $reportFolder/timing cts_setup -postCTS
    icf_utils_timedesign $reportFolder/timing cts_hold  -postCTS -hold

	##exec mkdir -p reports/timing/
	##timeDesign 	-postCTS -reportOnly -expandedViews -outDir reports/timing/  -numPaths 100 -prefix cts
	##timeDesign 	-postCTS -hold -reportOnly -expandedViews -outDir reports/timing/  -numPaths 100 -prefix cts_hold
}

icApply cts.post {
    ::innovus::saveAfterStep cts
}
