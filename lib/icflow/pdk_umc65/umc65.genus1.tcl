set ::umcFolder [file normalize [file dirname [info script]]]

sourceFile $::umcFolder/umc65.common1.tcl

icApply configure {
    icInfo "Configuration for UMC 65nm"

    set_db design_process_node          65
    set_db scale_of_cap_per_unit_length 1.5
    set_db scale_of_res_per_unit_length 1.07

}