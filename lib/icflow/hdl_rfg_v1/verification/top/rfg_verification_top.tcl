package require icflow::rfg::hdlbuild


icflow::hdlbuild::verilog::loadFile     ../rtl/basics/async_input_sync.v
icflow::hdlbuild::verilog::loadFile     ../rtl/spi/spi_fifo_qspi_io_readout1.sv

icflow::hdlbuild::top rfg_verification_top {

    - inputs clk resn

    ## SW Interface

    ## RFG
    - register_file main_rfg {

    } {
        - connect clk @.clk resn @.resn

    }

}

