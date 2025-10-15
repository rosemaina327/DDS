database -open -default $::env(DDS_WAVES)
probe -create $::env(TOPLEVEL) -name all -depth all -all -dynamic -tasks -functions -uvm -database $::env(DDS_WAVES) -memories

run
#if { ![info exists ::env(GUI) ]   } {
#    run
#}
