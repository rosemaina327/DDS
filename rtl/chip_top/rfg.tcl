## Sets the toplevel name only if not set already
icSetParameter IC_RFG_TARGET astep24_20l_top
icSetParameter IC_RFG_NAME   main_rfg

return {

    OSC_CTRL {
        -doc "Controls the Oscillator"
        -bits {
            EN {-doc "Enable Oscillator"}
        }
    }
    OSC_DIVIDER {
        -doc "Internal clock divider value for internal ring oscillator clock"
        -size 8
        -reset 8'd3
    }

    ADC_CTRL {
        -doc "Control the ADC"
        -bits {
            START {-doc "Start a conversion"}
            BUSY {-doc "Start a conversion" -input}
            RESET {-doc "Reset the internal logic"}
        }
    }

    ADC_WAITTIME {
        -doc "Waiting time for ADC"
        -size 32
        -reset 32'd16
    }

    ADC_FIFO_STATUS {
        -bits {
            empty {-doc "0 if the ADC output fifo is not empty"}
        }
    }
    ADC_FIFO_DATA {
        -fifo_axis_slave
    }

    TEST_DAC_CTRL {
        -bits {
            EN {-doc "Enable Test DAC"}
        }
    }
    TEST_DAC_VALUE {
        -size 8
    }

}
