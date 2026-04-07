# ==========================================================================
# Synopsys Design Compiler – Synthesis Script
# Design: pow4   (Y = 4^X, 2-bit unsigned X)
# ==========================================================================

set DESIGN_NAME "pow4"

# --- Paths ------------------------------------------------------------------
set RTL_FILE    "../RTL/${DESIGN_NAME}.v"
set SDC_FILE    "../constraints/${DESIGN_NAME}.sdc"
set LIB_DIR     "../ref/lib/stdcell_rvt"
set OUTPUT_DIR  "../DC/outputs"
set REPORTS_DIR "../DC/reports"

file mkdir $OUTPUT_DIR
file mkdir $REPORTS_DIR

# --- Libraries --------------------------------------------------------------
set target_library "$LIB_DIR/saed32rvt_tt0p78vn40c.db"
set link_library   "* $LIB_DIR/saed32rvt_tt0p78vn40c.db \
                       $LIB_DIR/saed32rvt_ff1p16v125c.db \
                       $LIB_DIR/saed32rvt_ss0p7vn40c.db"

# --- DON'T USE: ban AND gates only ------------------------------------------
set_dont_use [get_lib_cells */AND*]

# --- Read RTL ---------------------------------------------------------------
analyze   -format verilog $RTL_FILE
elaborate $DESIGN_NAME
current_design $DESIGN_NAME

# --- Link & constrain -------------------------------------------------------
link
read_sdc $SDC_FILE

# --- Compile ----------------------------------------------------------------
compile_ultra -no_autoungroup

set_propagated_clock [all_clocks]
set_ideal_network -clear [all_clocks]

# --- Reports ----------------------------------------------------------------
report_area        > $REPORTS_DIR/area.rpt
report_power       > $REPORTS_DIR/power.rpt
report_timing      > $REPORTS_DIR/timing_setup.rpt
report_timing -delay min > $REPORTS_DIR/timing_hold.rpt
report_qor         > $REPORTS_DIR/qor.rpt
report_constraint  > $REPORTS_DIR/constraints.rpt
report_cell        > $REPORTS_DIR/cells.rpt
report_net         > $REPORTS_DIR/nets.rpt

# --- Write outputs ----------------------------------------------------------
write -format verilog -hierarchy -output $OUTPUT_DIR/${DESIGN_NAME}_netlist.v
write_sdc  $OUTPUT_DIR/${DESIGN_NAME}.sdc

puts "INFO: DC synthesis complete for $DESIGN_NAME."
