module adc_top(

    // Analog I/O
    //---------
    input wire VDD,
    input wire GND,

     input `ANALOG_NET_TYPE VREF,
     input `ANALOG_NET_TYPE VIN,

    // Digital
    //---------

    input wire          clk,
    input wire          resn,
    input wire          start,

    output wire [7:0]   adc_value,
    output wire         adc_valid,
    output wire         adc_busy


);


    // Write your code here

endmodule
