# 06_clock.tcl 

# ------------------------------------------------------------
# Setup
# ------------------------------------------------------------
source scripts/01_setup.tcl

check_design -checks pre_clock_tree_stage

# ------------------------------------------------------------
# Step 1: Configure CTS options
# ------------------------------------------------------------
set_app_options -name cts.optimize.enable_local_skew  -value true
set_app_options -name cts.compile.enable_local_skew   -value true
set_app_options -name clock_opt.flow.enable_ccd       -value true

# ------------------------------------------------------------
# Step 2: Build Clock Tree
# ------------------------------------------------------------
clock_opt -to build_clock

# ------------------------------------------------------------
# Step 3: Route Clock Tree
# ------------------------------------------------------------
clock_opt -from route_clock -to route_clock

# ------------------------------------------------------------
# Step 4: Full Clock Optimization
# (Includes setup + hold fixing automatically)
# ------------------------------------------------------------
clock_opt

# ------------------------------------------------------------
# Step 5: Optional Hold Fix
# ------------------------------------------------------------
set hold_vio_count [sizeof_collection [get_timing_paths -delay_type min \
    -slack_lesser_than 0.0 -max_paths 10]]

if {$hold_vio_count > 0} {
    puts "WARNING: $hold_vio_count hold paths remain. Running refine_opt..."
    refine_opt
} else {
    puts "INFO: No hold violations. Skipping additional hold fixing."
}

# ------------------------------------------------------------
# Step 6: Reports
# ------------------------------------------------------------
report_clock_qor        > $REPORTS_DIR/clock_qor.rpt
report_clock_settings   > $REPORTS_DIR/clock_settings.rpt

report_timing -delay max -max_paths 10 \
    > $REPORTS_DIR/timing_post_cts.rpt

report_timing -delay min -max_paths 10 \
    > $REPORTS_DIR/timing_hold_post_cts.rpt

# ------------------------------------------------------------
# Step 7: Save Design
# ------------------------------------------------------------
save_block -as ${DESIGN_NAME}_cts
save_lib

puts "INFO: CTS + optimization complete."