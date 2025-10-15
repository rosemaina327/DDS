
/**

Mixed mode testbench here:

 - Wrap the Input/Outputs of the adc_top module for access by cocotb
 - Add the supplies

*/
module adc_mixed_tb_top (



);


    // ADC Top Here -> Make the connections to the testbench module
    adc_top adc (

    );

    // Add the supply module here

endmodule
