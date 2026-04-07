# ==========================================================================
# PrimeTime – Corner p1  (Cmax / SS / worst-case setup)
# Design   : pow4  (Y = 4^X, 2-bit unsigned, sequential)
# Run from : PT/   (pt_shell launched from PT/ directory)
# ==========================================================================

set DESIGN_NAME "pow4"
set LIB_DIR     "../ref/lib/stdcell_rvt"
set ICC2_OUT    "../ICCII/outputs"
set RPT_DIR     "reports/p1"

file mkdir $RPT_DIR

# ---------------------------------------------------------------------------
# Libraries – SS corner (worst-case cell delay, for setup check)
# ---------------------------------------------------------------------------
set target_library "$LIB_DIR/saed32rvt_ss0p7vn40c.db"
set link_library   "* $LIB_DIR/saed32rvt_ss0p7vn40c.db \
                      $LIB_DIR/saed32rvt_tt0p78vn40c.db \
                      $LIB_DIR/saed32rvt_ff1p16v125c.db"

# ---------------------------------------------------------------------------
# Read netlist and link
# PT flow: read_verilog → current_design (command) → link
# ---------------------------------------------------------------------------
read_verilog $ICC2_OUT/${DESIGN_NAME}_final.v

current_design $DESIGN_NAME

link

# ---------------------------------------------------------------------------
# Constraints
# ---------------------------------------------------------------------------
read_sdc $ICC2_OUT/${DESIGN_NAME}_final.sdc

# ---------------------------------------------------------------------------
# Parasitics
# ---------------------------------------------------------------------------
read_parasitics -format spef \
    $ICC2_OUT/${DESIGN_NAME}_final.spef.p1_125.spef

# ---------------------------------------------------------------------------
# Timing update and reports
# ---------------------------------------------------------------------------
update_timing -full

report_timing -delay max -max_paths 20 -input_pins \
    > $RPT_DIR/timing_p1_setup.rpt

report_timing -delay min -max_paths 20 -input_pins \
    > $RPT_DIR/timing_p1_hold.rpt

report_power \
    > $RPT_DIR/power_p1.rpt

report_constraint -all_violators \
    > $RPT_DIR/constraints_p1.rpt

puts "INFO: PrimeTime signoff p1 (Cmax/SS) complete."