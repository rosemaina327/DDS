
icDefineStep parameters     "Checks the required parameters for this flow"

icApply parameters {
    
    icCheckParametersFromGlobalVariables  
    if {[icCheckHasErrors]} {
        ## If an error occured, force creating summary to have a nice view
        puts "Error found, create summary"
        icflow::report::resetSummaryMD
        icflow::report::summaryToHTML
    }
}

icApply parameters.post {
    icflow::report::resetSummaryMD
    icflow::report::summaryToHTML
}

