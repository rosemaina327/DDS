package require icflow
icSetMainScript

## Load AMS Synthesis parameters and the common genus flow
icSource pdk_umc65/umc65.genus1.tcl
icSource flow_genus1/v1_0/genus1.v1_1.tcl

## Set Design parameters -> These will be set via env variable in the makefile
#set ::IC_NETLIST_F  $BASE/rtl/mightypix_top_verilog.ah18.f
#set ::IC_TOP        mightypix_top
#set ::IC_MMMC_CONSTRAINTS_FUNCTIONAL $BASE/implementation/constraints/constraints_functionalModeSyn.sdc

## Add parameters to tweak the flow for students
icDefineParameter IC_SHOW_ELABORATE     "Suspend after elaborate to look at the schematic" 0
icDefineParameter IC_SHOW_CONSTRAINTS   "Suspend after reading design to show constraints being applied" 0
icDefineParameter IC_SHOW_GENERIC       "Suspend after generic synthesis to look at the schematic" 0

set ::IC_GTL_EXTENSION sv
set ::IC_VERILOG_DEFINES "SYNTHESIS ANALOG_NET_TYPE=wire"
set ::IC_CLOCKGATING false
## Run Parameters to get a report of defined parameters 
icRun parameters
 
icApply elaborate.post {

    # This line is for the Chip top synthesis, will fail otherwise
    # It keeps the analog components in a separated module in the output netlist so that we can easily swap for a simulation model after synthesis
    catch {set_db [get_db hinsts *analog_system] .preserve true}
    if {${::IC_SHOW_ELABORATE}} {
        puts "** Elaborate finished, open the gui using the 'gui_raise' command, then look that the elaborated schematic **"
        suspend
    }
}

icApply init.post {
    if {${::IC_SHOW_CONSTRAINTS}} {
        puts "** Init finished, you should see a report about constraints read above **"
        suspend
    }
}


icApply synthesize.generic.post {
    if {${::IC_SHOW_GENERIC}} {
        puts "** Generic Synthesis finished, open the gui using the 'gui_raise' command, then look that the generic schematic **"
        suspend
    }
    
}

## If running in genus -> run flow
onGenus {
    flow_full
}