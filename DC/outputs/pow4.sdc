###################################################################

# Created by write_sdc on Tue Apr  7 08:03:42 2026

###################################################################
set sdc_version 2.1

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
create_clock [get_ports clk]  -period 2  -waveform {0 1}
set_clock_uncertainty -setup 0.1  [get_clocks clk]
set_clock_uncertainty -hold 0.05  [get_clocks clk]
set_propagated_clock [get_clocks clk]
set_input_delay -clock clk  0.2  [get_ports {X[1]}]
set_input_delay -clock clk  0.2  [get_ports {X[0]}]
set_output_delay -clock clk  0.2  [get_ports {Y[6]}]
set_output_delay -clock clk  0.2  [get_ports {Y[5]}]
set_output_delay -clock clk  0.2  [get_ports {Y[4]}]
set_output_delay -clock clk  0.2  [get_ports {Y[3]}]
set_output_delay -clock clk  0.2  [get_ports {Y[2]}]
set_output_delay -clock clk  0.2  [get_ports {Y[1]}]
set_output_delay -clock clk  0.2  [get_ports {Y[0]}]
