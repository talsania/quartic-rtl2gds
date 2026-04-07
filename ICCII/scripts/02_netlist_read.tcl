#==============================================================
# ICC2 Script 02: Library & Netlist Read
#==============================================================

source scripts/01_setup.tcl

#--------------------------------------------------------------
# 2a. Create in-memory library
#--------------------------------------------------------------
create_lib \
    -ref_lib $PDK_PATH/lib/ndm/saed32rvt_c.ndm \
    $LIB_NAME

#--------------------------------------------------------------
# 2b. Read synthesised gate-level netlist
#--------------------------------------------------------------
read_verilog $NETLIST_FILE \
    -library $LIB_NAME \
    -design  $DESIGN_NAME  \
    -top     $DESIGN_NAME

#--------------------------------------------------------------
# 2c. Link and constrain
#--------------------------------------------------------------
link_block
read_sdc $SDC_FILE

#--------------------------------------------------------------
# 2d. Pre-placement check
#--------------------------------------------------------------
check_design -checks pre_placement_stage \
    > $REPORTS_DIR/check_design_pre_place.rpt

save_block
save_lib

puts "INFO: Netlist read and design linked successfully."
start_gui
