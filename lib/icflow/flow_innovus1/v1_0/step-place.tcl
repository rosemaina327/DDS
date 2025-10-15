
icApply place.pre {
    

    createBasicPathGroups -expanded
	setPathGroupOptions reg2reg -effortLevel high
}



icApply place.run {

    ## 02/2020 Richard: Updated to newest "place_design" and "place_opt_design" commands
	## This improves results and speed
	## Also the Trial Route mode is not supported anymode, switching to setRouteMode with "early" parameters switches
	
	#setRouteMode -reset
	#setRouteMode -earlyGlobalMinRouteLayer 2
	#setRouteMode -earlyGlobalMaxRouteLayer 4
	#setDesignMode -topRoutingLayer 6
	#setDesignMode -bottomRoutingLayer 2
	
	# Place the Design with the following command
	# Lots of placement options can be set by means of the setPlaceMode command
	# before executing the placeDesign command
	# the inPlaceOpt switch turns on the optDesign with -preCTS
	#read_activity_file -format TCF -tcf_scope dcd_b_digital_block_full_sim_digital_top/dut_I ./power_intent/dcd_b_digital_block_togglecount.tcf
	#setPlaceMode -powerDriven true -maxRouteLayer 4 -wireLenOptEffort high


	## Select place mode
	if {$::IC_RUN_TYPE=="proto"} {

		puts "####################### Running Place in Prototype mode ####################"
		setPlaceMode -reset
		setPlaceMode -timingDriven true -wireLenOptEffort medium -congEffort medium
		setPlaceMode -place_design_floorplan_mode true
		
		place_design
	
		
	} else {

		## Place
        icRun set_mode.place
        icRun set_mode.cts
		place_design
		
		## Optimize (no hold in prects)
		place_opt_design -out_dir $reportFolder -prefix prects
		place_opt_design -incremental_timing -out_dir $reportFolder -prefix prects


		## Time Design
		######################
        icf_utils_timedesign $reportFolder/timing placed -preCTS
		

	}
}

icApply place.addTieHighLow {

    setTieHiLoMode -cell $::IC_CELLS_TIE
	addTieHiLo
    
}

icApply place.post {

    ## Report
	checkPlace > $reportFolder/checkPlace.rpt

    ::innovus::saveAfterStep placed
}
