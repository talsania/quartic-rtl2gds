#==============================================================
# ICC2 Script 01: Setup & Environment
# Design: pow4  (Y = 4^X, 2-bit unsigned X)
#==============================================================

set DESIGN_NAME   "pow4"

# Input files (from DC output)
set NETLIST_FILE  "../DC/outputs/${DESIGN_NAME}_netlist.v"
set SDC_FILE      "../DC/outputs/${DESIGN_NAME}.sdc"

# PDK / library paths
set PDK_PATH      "../ref"
set LIB_DIR       "$PDK_PATH/lib/stdcell_rvt"
set TECH_DIR      "$PDK_PATH/tech"

# Output / report directories
set OUTPUT_DIR    "../ICCII/outputs"
set REPORTS_DIR   "../ICCII/reports"

file mkdir $OUTPUT_DIR
file mkdir $REPORTS_DIR

# Derived lib/block names
set LIB_NAME      "[string toupper $DESIGN_NAME]_LIB"

puts "INFO: Setup complete for design: $DESIGN_NAME"
