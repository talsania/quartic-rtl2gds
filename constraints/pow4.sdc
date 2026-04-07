# pow4.sdc  –  add/replace the clock + hold section

# 1. Clock definition (adjust period to match your design)
create_clock -name clk -period 2.0 [get_ports clk]

# 2. I/O delays
set_input_delay  0.2 -clock clk [get_ports X]
set_output_delay 0.2 -clock clk [get_ports Y]

# 3. *** KEY FIX: explicit hold uncertainty ***
#    Forces the tool to add hold margin >= 0.05 ns
set_clock_uncertainty -hold 0.05 [get_clocks clk]
set_clock_uncertainty -setup 0.1 [get_clocks clk]

# 4. Tell DC to propagate clock skew realistically
set_propagated_clock [all_clocks]