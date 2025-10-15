#################################################################################
#
#   Set some parameters in order to customize the script
#
################################################################################


set IC_PWR_CORERING_WIDTH   10
set IC_PWR_CORERING_SPACING 5

set IC_RING_SIZE  [expr {$::IC_PWR_CORERING_WIDTH * 2 + 3 * $::IC_PWR_CORERING_SPACING}]
set IC_CORE_ROWS  348

set IC_DIE_WIDTH  1022.4
set IC_DIE_HEIGHT [expr {$::IC_CORE_ROWS * $::IC_STDCELL_HEIGHT + 2* $::IC_RING_SIZE }]

set IC_CORE_X      [expr $IC_RING_SIZE]
set IC_CORE_WIDTH  [expr $IC_DIE_WIDTH - 2*$IC_RING_SIZE]
set IC_CORE_Y      [expr $IC_RING_SIZE]
set IC_CORE_HEIGHT [expr {$::IC_CORE_ROWS * $::IC_STDCELL_HEIGHT}]

icApply floorplan.die {



    floorPlan -d [list $::IC_DIE_WIDTH $::IC_DIE_HEIGHT $::IC_RING_SIZE $::IC_RING_SIZE $::IC_RING_SIZE $::IC_RING_SIZE ]

}

icApply floorplan.blocks {

    ## Add your Block placements here
    #######
    setObjFPlanBox Instance adc_system_top_analog_system/analog/dac 268.611 428.311 870.461 612.121

    setObjFPlanBox Instance adc_system_top_analog_system/test_dac 267.778 189.977 869.628 373.787

    setObjFPlanBox Instance oscillator 265.8525 81.276 367.8525 121.176

    setObjFPlanBox Instance adc_system_top_analog_system/analog/comparator 822.1035 110.532 859.7635 140.712

    cutRow -halo 10

    fit


}

icApply floorplan.tap_spare {

    ## Adding Well Taps
    # LUP.6 states the maximus radius R for a well-tap as 30um
    # spacing between well-tap cells must be less than 2*sqrt (R^2 - H^2) with H being the std. cell height
    # --> S = 2*sqrt (30^2 - 2.4^2) = 59.80 which aligns to the M2 routing pitch of 0.2um
    catch {deleteInst *WELL*}
    addWellTap -cell WT3R -cellInterval 118 -checkerBoard -prefix WELLTAP_top


    ## Place spares
	## Spares can be connected to the clock network or not, depending if we know in advance which clock will be used by the spare flip-flops
	## In our case there is only one clock.
	icIgnoreError {

    	catch {

            catch {deleteSpareModule *spare*}
            catch {createSpareModule -cell {DFQBRM4RA 2 ND2M4R 2 INVM4R 3 INVM12R 1 NR2M2R 2} \
    			-moduleName spare_cells_top -tie {TIE1R TIE0R}}

      	    placeSpareModule -moduleName spare_cells_top -prefix spare -stepx 200 -stepy 200 -util .7

        }
	}
}

icApply floorplan.pins {


	set pinWidth 0.5
	set pinPitch 25
	set pinArgs [list -use SIGNAL -pinWidth $pinWidth -pinDepth  1 -fixedPin 1 -fixOverlap 0 -honorConstraint 0  -snap USERGRID -layer 2]

	setPinAssignMode -pinEditInBatch true

	## Place SPI on the left
	set spiBaseY [expr {int($::IC_CORE_Y + $::IC_CORE_HEIGHT / 2)}]

	editPin {*}$pinArgs -side left -pin spi_clk     -assign $::IC_CORE_X $spiBaseY
	incr spiBaseY $pinPitch

	editPin {*}$pinArgs -side left -pin spi_csn     -assign $::IC_CORE_X $spiBaseY
	incr spiBaseY $pinPitch

	editPin {*}$pinArgs -side left -pin spi_miso    -assign $::IC_CORE_X $spiBaseY
	incr spiBaseY $pinPitch

	editPin {*}$pinArgs -side left -pin spi_mosi    -assign $::IC_CORE_X $spiBaseY
	incr spiBaseY $pinPitch

	## Place extra clock and resn on top and VIN + VREF
	set topX  [expr {int($::IC_CORE_X + $::IC_CORE_HEIGHT / 2)}]
	set topY  [expr {$::IC_CORE_Y + $::IC_CORE_HEIGHT}]

	editPin {*}$pinArgs -side top -pin clk    -assign $topX  $topY
	incr topX $pinPitch

	editPin {*}$pinArgs -side top -pin resn    -assign $topX $topY
	incr topX $pinPitch

	editPin {*}$pinArgs -side top -pin clk    -assign $topX $topY
	incr topX $pinPitch

	incr topX $pinPitch
	incr topX $pinPitch
	editPin {*}$pinArgs -side top -pin VIN   -assign $topX $topY
	incr topX $pinPitch
	editPin {*}$pinArgs -side top -pin VREF  -assign $topX $topY
	incr topX $pinPitch

	#incr topX [expr 4*$pinPitch]
	#editPin {*}$pinArgs -side top -pin VDD  -assign $topX $topY
	#incr topX $pinPitch
	#editPin {*}$pinArgs -side top -pin GND  -assign $topX $topY

	fit

}

icApply floorplan.power {

    global core_height
    global core_width
	global ring_size
    #global ring_size
   # global ring_width_left 30
   # global ring_width_right 30

	## Clear All Power Nets
	#############
	clearGlobalNets
	deleteAllPowerPreroutes

    # This names are our internal VDD/GND names
	set VDDNAME VDD
	set GNDNAME GND


	#try to create power nets
	# Errors can be ignored here
	#########################
	catch {
		addNet -physical $VDDNAME
		setNet -net $VDDNAME -type special
		dbSetIsNetPwr $VDDNAME

		addNet -physical $GNDNAME
		setNet -net $GNDNAME -type special
		dbSetIsNetGnd $GNDNAME
	}




    ## Cells and Soft Block
    globalNetConnect $VDDNAME -type pgpin 	-pin ${::IC_POWER_VDD_NAME} -all -verbose
    globalNetConnect $GNDNAME -type pgpin 	-pin ${::IC_POWER_GND_NAME} -all -verbose



    ## Blocks
    puts "Explicit names"
    globalNetConnect $VDDNAME  -type pgpin -pin VDD   -all  -netlistOverride -verbose
    #-singleInstance adc_system_top_analog_system/analog/comparator
    #globalNetConnect $VDDNAME    -type pgpin -pin VCC -all -verbose
	globalNetConnect $GNDNAME  -type pgpin -pin GND -all -netlistOverride  -verbose


	## 0/1 constants in design are tiehi/low
	globalNetConnect $VDDNAME    -type tiehi
	globalNetConnect $GNDNAME    -type tielo




    ## Power Ring around core
	##########
    addRing -nets [list $VDDNAME $GNDNAME] \
		-type core_rings  \
		-layer [list top ${::IC_POWER_HORIZONTAL_LAYER} bottom ${::IC_POWER_HORIZONTAL_LAYER} left ${::IC_POWER_VERTICAL_LAYER} right ${::IC_POWER_VERTICAL_LAYER}]  \
		-width  $::IC_PWR_CORERING_WIDTH \
		-spacing $::IC_PWR_CORERING_SPACING \
		-use_wire_group 1 \
		-center 1


    # Stripes:
    #########

    #Set the number of vertical stripes
    set number_of_vertical_stripes 8

    #Set the number of horizontal stripes
    set number_of_horizontal_stripes 5

    set stripesWidth [expr {$::IC_PWR_CORERING_WIDTH * 2 + $::IC_PWR_CORERING_SPACING}]
    set stripeXOffset [expr {($::IC_CORE_WIDTH - $number_of_vertical_stripes*$stripesWidth) / ($number_of_vertical_stripes+1) }]
    set stripeYOffset [expr {($::IC_CORE_HEIGHT - $number_of_horizontal_stripes*$stripesWidth) / ($number_of_horizontal_stripes+1) }]



    addStripe -nets [list $VDDNAME $GNDNAME] \
    	-layer ${::IC_POWER_VERTICAL_LAYER}  \
    	-direction vertical  \
    	-width $::IC_PWR_CORERING_WIDTH  \
    	-spacing $::IC_PWR_CORERING_SPACING  \
    	-number_of_sets $number_of_vertical_stripes  \
    	-extend_to all_domains  \
    	-start_offset $stripeXOffset \
        -stop_offset $stripeXOffset \
    	-merge_stripes_value auto  \
    	-use_wire_group 1




    setViaGenMode -reset
    setViaGenMode -optimize_cross_via true
    editPowerVia  -add_vias 1 -bottom_layer ME1 -top_layer ME8 -nets [list $VDDNAME $GNDNAME] -split_vias 1 -orthogonal_only 1 -skip_via_on_pin {}



    ## SRoute to connect M1 to Stripes -layerChangeRange {M1 AM} -targetViaLayerRange {M1 AM}
	setSrouteMode -reset
	setSrouteMode -extendNearestTarget true -viaConnectToShape {stripe ring blockring blockpin}
    #-targetSearchDistance 150 -corePinJoinLimit 10
    sroute -deleteExistingRoutes -nets [list $VDDNAME $GNDNAME] \
                                -connect {corePin blockPin floatingStripe} \
                                -floatingStripeTarget {followpin} \
                                -corePinTarget {  stripe padring ringpin blockpin} \
                                -blockPinTarget {ring stripe} -allowLayerChange 1 -layerChangeRange {ME1 ME8} -targetViaLayerRange {ME1 ME8}



    addStripe -nets [list $VDDNAME $GNDNAME]  \
	-layer ${::IC_POWER_HORIZONTAL_LAYER}   \
	-direction horizontal   \
	-width $::IC_PWR_CORERING_WIDTH   \
	-spacing $::IC_PWR_CORERING_SPACING  \
	-number_of_sets $number_of_horizontal_stripes   \
	-extend_to all_domains   \
	-start_offset $stripeYOffset \
    -stop_offset $stripeYOffset \
	-merge_stripes_value auto   \
	-use_wire_group 1

    #editPowerVia -add_vias 1   -bottom_layer ME6 -top_layer ME8 -nets [list $VDDNAME $GNDNAME] -split_vias 1 -orthogonal_only 1 -skip_via_on_pin {}






    verifyConnectivity -noFill -noUnroutedNet -noAntenna

}
