package require icflow::rfg::hdlbuild
package require icflow::hdlbuild::verilog
package require icflow::hdlbuild::generate 

set igressModule [icflow::hdlbuild::verilog::loadFile     ../../rtl/spi/spi_slave_axis_igress.sv]


icflow::hdlbuild::generate::generateVerilog ./generated