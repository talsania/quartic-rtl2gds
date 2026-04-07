/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : W-2024.09
// Date      : Tue Apr  7 08:03:42 2026
/////////////////////////////////////////////////////////////


module pow4 ( clk, X, Y );
  input [1:0] X;
  output [6:0] Y;
  input clk;
  wire   N0, N2, N4, N6, n4, n5, n6;
  wire   [1:0] X_reg;
  assign Y[1] = 1'b0;
  assign Y[3] = 1'b0;
  assign Y[5] = 1'b0;

  DFFX1_RVT \X_reg_reg[1]  ( .D(X[1]), .CLK(clk), .Q(X_reg[1]), .QN(n6) );
  DFFX1_RVT \X_reg_reg[0]  ( .D(X[0]), .CLK(clk), .Q(X_reg[0]) );
  DFFX1_RVT \Y_reg[6]  ( .D(N6), .CLK(clk), .Q(Y[6]) );
  DFFX1_RVT \Y_reg[4]  ( .D(N4), .CLK(clk), .Q(Y[4]) );
  DFFX1_RVT \Y_reg[2]  ( .D(N2), .CLK(clk), .Q(Y[2]) );
  DFFX1_RVT \Y_reg[0]  ( .D(N0), .CLK(clk), .Q(Y[0]) );
  NAND2X0_RVT U11 ( .A1(X_reg[0]), .A2(n6), .Y(n4) );
  INVX1_RVT U12 ( .A(n4), .Y(N2) );
  NAND2X0_RVT U13 ( .A1(X_reg[1]), .A2(X_reg[0]), .Y(n5) );
  INVX1_RVT U14 ( .A(n5), .Y(N6) );
  NOR2X0_RVT U15 ( .A1(X_reg[0]), .A2(n6), .Y(N4) );
  NOR2X0_RVT U16 ( .A1(X_reg[1]), .A2(X_reg[0]), .Y(N0) );
endmodule

