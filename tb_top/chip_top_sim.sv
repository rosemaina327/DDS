module chip_top_sim(

    input wire clk,
    input wire resn,

    input wire spi_clk,
    input wire spi_csn,
    input wire spi_mosi,
    output wire spi_miso


);


`ifdef SDF_MAX
initial begin

    $sdf_annotate("../run/chip_top/par/stream_out/chip_top.slow.sdf", chip_top_sim.chip_top_inst,, "annotate.log","MAXIMUM");

end
`endif

real VIN;
real VREF;
chip_top  chip_top_inst (
    .clk(clk),
    .resn(resn),
    .spi_clk(spi_clk),
    .spi_csn(spi_csn),
    .spi_mosi(spi_mosi),
    .spi_miso(spi_miso),
    .VIN(VIN),
    .VREF(VREF)
  );


  endmodule
