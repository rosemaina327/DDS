// mixed_signal_types_pkg.sv

`ifdef SYNTHESIS
`define ANALOG_NET_TYPE wire
`endif

`ifdef SIMULATION 
import cds_rnm_pkg::*;
`define ANALOG_NET_TYPE wreal1driver
`endif

/*
interface analog_if;

    `ifdef SYNTHESIS
    wire val; 
    `else 
    import cds_rnm_pkg::*;
    wreal1driver val;
    `endif


endinterface*/
/*
package mixed_signal_types_pkg;

    // Define a macro to indicate synthesis mode
    // This macro would be passed to the compiler during synthesis
    // For simulation, this macro would NOT be defined

`ifdef SYNTHESIS
    // --- Synthesis Definition ---
    // For synthesis, the "analog_val_t" is a digital bus
    typedef logic analog_val_t; // Example: 10-bit digital representation
`else
    // --- Simulation Definition ---
    // For mixed-signal simulation, the "analog_val_t" is a wreal
    // Note: 'wreal' itself is typically recognized by AMS simulators.
    // If using Cadence's specific RNM features, you might use their
    // specific nettypes, e.g., typedef cds_rnm_pkg::wreal_sum_t analog_val_t;
    
    typedef wreal1driver analog_val_t;
`endif

endpackage : mixed_signal_types_pkg
 */