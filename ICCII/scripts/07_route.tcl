#==============================================================
# ICC2 Script 07: Routing
# Design: pow4
# Updated: hold violation fix added post route_opt
#==============================================================

source scripts/01_setup.tcl

#--------------------------------------------------------------
# 7a. Global route options
#--------------------------------------------------------------
set_app_options -name route.global.timing_driven    -value true
set_app_options -name route.global.crosstalk_driven -value false

#--------------------------------------------------------------
# 7b. Track assignment options
#--------------------------------------------------------------
set_app_options -name route.track.timing_driven    -value true
set_app_options -name route.track.crosstalk_driven -value true

#--------------------------------------------------------------
# 7c. Detail route options
#--------------------------------------------------------------
set_app_options -name route.detail.timing_driven                -value true
set_app_options -name route.detail.force_max_number_iterations  -value false
set_app_options -name route.detail.antenna                      -value true
set_app_options -name route.detail.antenna_fixing_preference    -value use_diodes
set_app_options -name route.detail.diode_libcell_names          -value */ANTENNA_RVT

#--------------------------------------------------------------
# 7d. Routing sequence
#--------------------------------------------------------------
route_global
route_track
route_detail

#--------------------------------------------------------------
# 7e. Post-route optimisation
#--------------------------------------------------------------
route_opt

#--------------------------------------------------------------
# 7f. Post-route hold check (informational)
#--------------------------------------------------------------
set hold_vio_count [sizeof_collection [get_timing_paths \
    -delay_type min -slack_lesser_than 0.0 -max_paths 10]]

if { $hold_vio_count > 0 } {
    puts "WARNING: $hold_vio_count hold paths remain after route_opt."
    puts "         Running incremental route_opt to attempt fix..."
    set_app_options -name route_opt.flow.enable_ccd -value true
    route_opt
} else {
    puts "INFO: No hold violations post-route. Design is clean."
}

#--------------------------------------------------------------
# 7g. Verify hold fix did not break setup
#--------------------------------------------------------------
set hold_wns  [get_attribute [get_timing_paths -delay min] slack]
set setup_wns [get_attribute [get_timing_paths -delay max] slack]

puts "INFO: Post-fix Hold  WNS = $hold_wns ns"
puts "INFO: Post-fix Setup WNS = $setup_wns ns"

if { $hold_wns < 0.0 } {
    puts "WARNING: Hold violation still present ($hold_wns ns)."
    puts "         Consider widening set_clock_uncertainty -hold in SDC,"
    puts "         or increasing the buffer_list to include BUFFD16RVT."
} else {
    puts "INFO: Hold timing is clean."
}

#--------------------------------------------------------------
# 7h. Checks & reports
#--------------------------------------------------------------
check_routes > $REPORTS_DIR/check_routes.rpt

report_timing -delay max -max_paths 10 \
    > $REPORTS_DIR/timing_post_route.rpt

report_timing -delay min -max_paths 10 \
    > $REPORTS_DIR/timing_hold_post_route.rpt

# Extra focused hold report: only show violating paths
report_timing \
    -delay          min \
    -max_paths      20  \
    -slack_lesser_than 0.0 \
    > $REPORTS_DIR/timing_hold_violations.rpt

report_qor -summary > $REPORTS_DIR/qor_post_route.rpt

#--------------------------------------------------------------
# 7i. Write routed outputs
#--------------------------------------------------------------
write_verilog  $OUTPUT_DIR/${DESIGN_NAME}.routed.v
write_sdc      -output $OUTPUT_DIR/${DESIGN_NAME}.routed.sdc
write_parasitics -format spef -output $OUTPUT_DIR/${DESIGN_NAME}.spef

save_block
save_lib

puts "INFO: Routing complete."