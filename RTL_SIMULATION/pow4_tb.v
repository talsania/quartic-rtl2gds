`timescale 1ns/1ps

module pow4_tb;

    reg clk;
    reg [1:0] X;
    wire [6:0] Y;

    integer pass_cnt;
    integer fail_cnt;

    pow4 uut (
        .clk(clk),
        .X(X),
        .Y(Y)
    );

    always #5 clk = ~clk;

    task check;
        input [1:0] in_x;
        input [6:0] expected;
        begin
            @(posedge clk);
            X = in_x;

            @(posedge clk);

            if (Y === expected) begin
                $display("PASS: X=%0b  Y=%0d (expected %0d)", in_x, Y, expected);
                pass_cnt = pass_cnt + 1;
            end else begin
                $display("FAIL: X=%0b  Y=%0d  expected %0d", in_x, Y, expected);
                fail_cnt = fail_cnt + 1;
            end
        end
    endtask

    initial begin
        clk = 0;
        X = 0;
        pass_cnt = 0;
        fail_cnt = 0;

        $fsdbDumpfile("pow4.fsdb");
        $fsdbDumpvars(0, pow4_tb);

        check(2'b00, 7'd1);
        check(2'b01, 7'd4);
        check(2'b10, 7'd16);
        check(2'b11, 7'd64);

        $display("----------------------------------");
        $display("Results: %0d PASS  /  %0d FAIL", pass_cnt, fail_cnt);
        $display("----------------------------------");

        if (fail_cnt == 0)
            $display("*** ALL TESTS PASSED ***");
        else
            $display("*** SOME TESTS FAILED ***");

        $finish;
    end

endmodule