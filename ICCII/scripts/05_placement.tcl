#==============================================================
# ICC2 Script 05: Placement
#==============================================================

source scripts/01_setup.tcl

#--------------------------------------------------------------
# 5a. Timing mode / corner / scenario
#--------------------------------------------------------------
remove_modes    -all
remove_corners  -all
remove_scenarios -all

create_mode   func
create_corner nom
create_scenario -name func::nom -mode func -corner nom

current_mode     func
current_scenario func::nom

source $SDC_FILE

set_scenario_status func::nom -active true -setup true -hold true

#--------------------------------------------------------------
# 5b. Parasitic technology
#--------------------------------------------------------------
set tluplus_filep1    "$PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus"
set layer_map_filep1  "$PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"
set tluplus_filep2    "$PDK_PATH/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus"
set layer_map_filep2  "$PDK_PATH/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"

read_parasitic_tech -tlup $tluplus_filep1 -layermap $layer_map_filep1 -name p1
read_parasitic_tech -tlup $tluplus_filep2 -layermap $layer_map_filep2 -name p2

set_parasitic_parameters -late_spec p1 -early_spec p2

#--------------------------------------------------------------
# 5c. DON'T USE cells  (no AND gate only)
#--------------------------------------------------------------
set_dont_use [get_lib_cells */AND*]

#--------------------------------------------------------------
# 5d. Placement app options
#--------------------------------------------------------------
set_app_options -name place.coarse.continue_on_missing_scandef -value true

#--------------------------------------------------------------
# 5e. Run placement
#--------------------------------------------------------------
place_pins -self
place_opt
legalize_placement

#--------------------------------------------------------------
# 5f. Reports
#--------------------------------------------------------------
check_legality -verbose \
    > $REPORTS_DIR/check_legality.rpt

report_timing -delay max -max_paths 10 \
    > $REPORTS_DIR/timing_post_place.rpt

report_qor -summary \
    > $REPORTS_DIR/qor_post_place.rpt

save_block -as ${DESIGN_NAME}_placement
save_lib

puts "INFO: Placement complete."