set sdc_version 2.0


set hS "/"
set q q
if {${::IC_STAGE}!="SYN"} {
	## Hierarchy separator is different in P&R Tool -> _
	set hS "_"
    set q Q
}



# 100ns / 10Mhz period clock for SPI
create_clock -name spi_clk -period 100 [get_ports spi_clk]

# Ring Oscillator: Base clock is 350Mhz, then divider should be max to c.a 50Mhz, not faster
create_clock            -name osc_clk       -period 2.8 [get_pin oscillator/CKOUT]
create_generated_clock  -name internal_clk -divide_by 4 -source  [get_pin oscillator/CKOUT] [get_pin divided_clock_reg/$q]

set_clock_groups -asynchronous -group {spi_clk} -group {osc_clk internal_clk}

# I/O
set_load 0.5 [all_outputs]
set_max_transition 0.5 [all_outputs]
set_output_delay  -clock spi_clk -min 1.0 [get_ports {spi_miso}]
set_output_delay  -clock spi_clk -max 25 [get_ports {spi_miso}]
