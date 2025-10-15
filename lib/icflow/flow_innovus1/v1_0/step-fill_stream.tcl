icApply fill {

    #add filler cells to the design
	#addFiller -cell [concat $::IC_CELLS_FILLCAPS $::IC_CELLS_FILLERS] -prefix FILLER
	addFiller -cell [concat  $::IC_CELLS_FILLERS] -prefix FILLER

    ## Check DRC
    icf_utils_verify_drc

	## Fix DRC
	ecoRoute -target

    ## Check DRC
    icf_utils_verify_drc
}

icApply fill.post {
     ::innovus::saveAfterStep filled
}

icApply signoff_timing {

    ## BCWC
    icRun set_mode.timing.bcwc

    setExtractRCMode -reset
	setExtractRCMode -engine postRoute -effortLevel signoff -coupled true
	setDelayCalMode -reset
	setDelayCalMode -engine default -SIaware false

    icf_utils_timedesign $reportFolder/timing signoff_bcwc -signoff
    icf_utils_timedesign $reportFolder/timing signoff_bcwc -signoff -hold

    ## OCV
    #icRun set_mode.timing.ocv

   # setExtractRCMode -reset
	#setExtractRCMode -engine postRoute -effortLevel signoff -coupled true
	#setDelayCalMode -reset
	#setDelayCalMode -engine default -SIaware true

   # icf_utils_timedesign $reportFolder/timing signoff_ocv -signoff
   # icf_utils_timedesign $reportFolder/timing signoff_ocv -signoff -hold

}

icApply signoff_timing.post {
    innovus::saveAfterStep signoff_timing
}

icApply streamout {

    exec mkdir -p stream_out


    ## GDS  -mapFile $STD_CELLS(physical/gdsmap)
	###################
	setStreamOutMode -textSize .2
    puts "Streamout Map: $::IC_GDSMAP"
    streamOut -outputMacros -mapFile $::IC_GDSMAP ./stream_out/${::IC_TOP}.gds


    ## Power report
    ############
    #report_power -outfile $reportFolder/power_streamout.rtp -clock_network all -hierarchy all -cell_type all -power_domain all -pg_net all -sort { total }

	## SDF
	############
    write_sdf -target_application verilog -exclude_cells [get_cells *spare*] -view functional_slowHT  -recompute_delay_calc ./stream_out/${::IC_TOP}.slow.sdf
    write_sdf -view functional_fastLT -target_application verilog -recompute_delay_calc ./stream_out/${::IC_TOP}.fast.sdf

	## Save Netlist for LVS -includePowerGround
	saveNetlist -flat -exportTopPGNets  -includePowerGround  -excludeLeafCell ./stream_out/${::IC_TOP}.lvs.v
	#-includePhysicalCell [concat $::IC_CELLS_FILLCAPS $::IC_CELLS_FILLERS]
	#saveNetlist -flat includePhysicalInst -shortenNames -includePowerGround -excludeLeafCell ./stream_out/${::IC_TOP}.lvs.v


	## Save Netlist for Simulation
	#saveNetlist -excludeCellInst [get_cells *spare*] -excludeCellDef adc_analog  ./stream_out/${::IC_TOP}.simulation.nonFlat.v
	saveNetlist -excludeCellDef [list adc_analog]  ./stream_out/${::IC_TOP}.simulation.nonFlat.v




}



icApply streamout.post {
    innovus::saveAfterStep streamout
}
