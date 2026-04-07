#==============================================================
# ICC2 Script 03: Floorplan
# Active scenario: Scenario 3 – L-shaped, pins on side 6
#==============================================================

source scripts/01_setup.tcl

#--------------------------------------------------------------
# SCENARIO 3
#--------------------------------------------------------------
initialize_floorplan \
    -shape L \
    -control_type die \
    -side_length {8 8 4 4 8 8} \
    -core_offset {0.5 0.5} \
    -coincident_boundary false

set_individual_pin_constraints -ports [get_ports X[*]] -sides 6
set_individual_pin_constraints -ports [get_ports Y[*]] -sides 6
set_individual_pin_constraints -ports [get_ports clk]  -sides 2

place_pins -self
create_placement -floorplan -effort high

#--------------------------------------------------------------
# Other scenarios (commented out for reference)
#--------------------------------------------------------------

#scenario1:
#initialize_floorplan -core_offset 1
#set_individual_pin_constraints -ports [get_ports] -sides 3
#place_pins -self
#create_placement -floorplan

#scenario2:
#initialize_floorplan -side_ratio {1.5 1} -core_offset 1
#set_individual_pin_constraints -ports [get_ports {X[0]}] -sides 2
#place_pins -self
#create_placement -floorplan -effort very_low

#scenario4:
#initialize_floorplan -core_utilization 0.6 -core_offset {3 3} -coincident_boundary false
#set_individual_pin_constraints -ports [get_ports {X[0] X[1]}] -sides {1 4} -pin_spacing_distance 2
#set_individual_pin_constraints -ports [get_ports {Y[*]}] -sides 3 -pin_spacing_distance 2
#place_pins -self
#create_placement -floorplan -effort high

#scenario5:
#initialize_floorplan -shape L -control_type die -side_length {20 30 20 20} -core_offset {5}
#set_individual_pin_constraints -ports [get_ports {X[0]}] -exclude_sides {1 2 3 4 5}
#place_pins -self
#create_placement -floorplan -effort low

check_pin_placement \
    > $REPORTS_DIR/check_pin_placement.rpt

save_block -as [string toupper $DESIGN_NAME]
save_lib

puts "INFO: Floorplan (Scenario 3) complete."