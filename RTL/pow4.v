// pow4.v  –  Y = 4^X,  X is 2-bit unsigned
module pow4 (
    input  wire        clk,
    input  wire [1:0]  X,
    output reg  [6:0]  Y
);
    reg [1:0] X_reg;
    reg [6:0] Y_comb_reg;   // explicit intermediate stage

    // Stage 1: register the input
    always @(posedge clk)
        X_reg <= X;

    // Stage 2: register the output  (4^X = 1 << 2X)
    always @(posedge clk)
        Y <= 7'd1 << ({1'b0, X_reg} << 1);

endmodule