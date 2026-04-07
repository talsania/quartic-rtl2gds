// IC Compiler II Version W-2024.09 Verilog Writer
// Generated on 4/7/2026 at 9:49:31
// Library Name: POW4_LIB
// Block Name: pow4
// User Label: 
// Write Command: write_verilog -exclude { pg_objects } ../ICCII/outputs/pow4_final.v
module pow4 ( clk , X , Y ) ;
input  clk ;
input  [1:0] X ;
output [6:0] Y ;

wire N0 ;
wire N2 ;
wire N4 ;
wire N6 ;
wire n4 ;
wire n5 ;
wire n6 ;
wire [1:0] X_reg ;
wire SYNOPSYS_UNCONNECTED_1 ;
wire SYNOPSYS_UNCONNECTED_2 ;
wire SYNOPSYS_UNCONNECTED_3 ;
wire SYNOPSYS_UNCONNECTED_4 ;
wire SYNOPSYS_UNCONNECTED_5 ;

assign Y[5] = 1'b0 ;
assign Y[3] = 1'b0 ;
assign Y[1] = 1'b0 ;

DFFX1_RVT \X_reg_reg[1] ( .D ( X[1] ) , .CLK ( clk ) , .Q ( X_reg[1] ) , 
    .QN ( n6 ) ) ;
DFFX1_RVT \X_reg_reg[0] ( .D ( X[0] ) , .CLK ( clk ) , .Q ( X_reg[0] ) , 
    .QN ( SYNOPSYS_UNCONNECTED_1 ) ) ;
DFFX1_RVT \Y_reg[6] ( .D ( N6 ) , .CLK ( clk ) , .Q ( Y[6] ) , 
    .QN ( SYNOPSYS_UNCONNECTED_2 ) ) ;
DFFX1_RVT \Y_reg[4] ( .D ( N4 ) , .CLK ( clk ) , .Q ( Y[4] ) , 
    .QN ( SYNOPSYS_UNCONNECTED_3 ) ) ;
DFFX1_RVT \Y_reg[2] ( .D ( N2 ) , .CLK ( clk ) , .Q ( Y[2] ) , 
    .QN ( SYNOPSYS_UNCONNECTED_4 ) ) ;
DFFX1_RVT \Y_reg[0] ( .D ( N0 ) , .CLK ( clk ) , .Q ( Y[0] ) , 
    .QN ( SYNOPSYS_UNCONNECTED_5 ) ) ;
NAND2X0_RVT U11 ( .A1 ( X_reg[0] ) , .A2 ( n6 ) , .Y ( n4 ) ) ;
INVX0_RVT U12 ( .A ( n4 ) , .Y ( N2 ) ) ;
NAND2X0_RVT U13 ( .A1 ( X_reg[1] ) , .A2 ( X_reg[0] ) , .Y ( n5 ) ) ;
INVX0_RVT U14 ( .A ( n5 ) , .Y ( N6 ) ) ;
NOR2X0_RVT U15 ( .A1 ( X_reg[0] ) , .A2 ( n6 ) , .Y ( N4 ) ) ;
NOR2X0_RVT U16 ( .A1 ( X_reg[1] ) , .A2 ( X_reg[0] ) , .Y ( N0 ) ) ;
endmodule


