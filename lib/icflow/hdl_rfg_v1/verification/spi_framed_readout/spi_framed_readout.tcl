
package require icflow::hdlbuild
package require icflow::hdlbuild::verilog
package require icflow::hdlbuild::generate
package require icflow::hdlbuild::spi
package require icflow::hdlbuild::axi
package require icflow::rfg::hdlbuild

icflow::hdlbuild::verilog::loadFile     ../../rtl/protocol/rfg_axis_protocol.sv
icflow::hdlbuild::verilog::loadFile     ../../rtl/protocol/rfg_axis_readout_framing.sv

icflow::hdlbuild::verilog::loadFile     ../../rtl/spi/spi_slave_axis_egress.sv
icflow::hdlbuild::verilog::loadFile     ../../rtl/spi/spi_slave_axis_igress.sv

icflow::hdlbuild::top spi_framed_readout {

    - inputs resn

    - io:spi:slave

    - @:finished axis:connect_path igress -> protocol -> readout_framing -> egress

    ## Igress to RF Protocol
    ##########
    - +:spi_slave_axis_igress igress {
        - connect spi_* @.spi_* resn @.resn
    }

    - +:rfg_axis_protocol protocol {
        - connect *clk @.spi_clk aresetn @.resn

    }

    ## RFG
    - register_file main_rfg {
        
        SCRATCHPAD0
        SCRATCHPAD1

    } {
        - connect *clk @.spi_clk resn @.resn
        - connect rfg* protocol.rfg*
        
    }

    ## Egress 
    ##########
    ## Readout with Frame bytes
    - +:rfg_axis_readout_framing readout_framing {
        - connect *clk @.spi_clk resn @.resn
    } 

    ## Byte Egress
    - +:spi_slave_axis_egress egress {
        - connect spi_* @.spi_* resn @.resn
    }

}

icflow::hdlbuild::generate::generateVerilog ./generated
