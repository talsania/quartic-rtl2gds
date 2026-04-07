################################################################################
#
# Design name:  pow4
#
# Created by icc2 write_sdc on Tue Apr  7 09:48:07 2026
#
################################################################################

set sdc_version 2.1
set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA

################################################################################
#
# Units
# time_unit               : 1e-09
# resistance_unit         : 1000000
# capacitive_load_unit    : 1e-15
# voltage_unit            : 1
# current_unit            : 1e-06
# power_unit              : 1e-12
################################################################################


# Mode: func
# Corner: nom
# Scenario: func::nom

# /home/kris/RTL2GDSII_POW4/DC/outputs/pow4.sdc, line 9
create_clock -name clk -period 2 -waveform {0 1} [get_ports {clk}]
set_propagated_clock [get_clocks {clk}]
# Warning: Libcell power domain derates are skipped!

# Set latency for io paths.
# -origin useful_skew
set_clock_latency -min 3.8147e-05 [get_clocks {clk}]
# -origin useful_skew
set_clock_latency -max 5.72205e-05 [get_clocks {clk}]
# Set propagated on clock sources to avoid removing latency for IO paths.
set_propagated_clock  [get_ports {clk}]
set_clock_uncertainty -setup 0.1 [get_clocks {clk}]
set_clock_uncertainty -hold 0.05 [get_clocks {clk}]
# /home/kris/RTL2GDSII_POW4/DC/outputs/pow4.sdc, line 13
set_input_delay -clock [get_clocks {clk}] 0.2 [get_ports {X[1]}]
# /home/kris/RTL2GDSII_POW4/DC/outputs/pow4.sdc, line 14
set_input_delay -clock [get_clocks {clk}] 0.2 [get_ports {X[0]}]
# /home/kris/RTL2GDSII_POW4/DC/outputs/pow4.sdc, line 15
set_output_delay -clock [get_clocks {clk}] 0.2 [get_ports {Y[6]}]
# /home/kris/RTL2GDSII_POW4/DC/outputs/pow4.sdc, line 16
set_output_delay -clock [get_clocks {clk}] 0.2 [get_ports {Y[5]}]
# /home/kris/RTL2GDSII_POW4/DC/outputs/pow4.sdc, line 17
set_output_delay -clock [get_clocks {clk}] 0.2 [get_ports {Y[4]}]
# /home/kris/RTL2GDSII_POW4/DC/outputs/pow4.sdc, line 18
set_output_delay -clock [get_clocks {clk}] 0.2 [get_ports {Y[3]}]
# /home/kris/RTL2GDSII_POW4/DC/outputs/pow4.sdc, line 19
set_output_delay -clock [get_clocks {clk}] 0.2 [get_ports {Y[2]}]
# /home/kris/RTL2GDSII_POW4/DC/outputs/pow4.sdc, line 20
set_output_delay -clock [get_clocks {clk}] 0.2 [get_ports {Y[1]}]
# /home/kris/RTL2GDSII_POW4/DC/outputs/pow4.sdc, line 21
set_output_delay -clock [get_clocks {clk}] 0.2 [get_ports {Y[0]}]
