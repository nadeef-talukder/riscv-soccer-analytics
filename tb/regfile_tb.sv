module regfile_tb;
    logic        clk;
    logic        we;
    logic [4:0]  rs1, rs2, rd;
    logic [31:0] wd;
    logic [31:0] rd1, rd2;

    regfile dut (
        .clk(clk), .we(we),
        .rs1(rs1), .rs2(rs2), .rd(rd),
        .wd(wd), .rd1(rd1), .rd2(rd2)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    task check(input [31:0] actual, input [31:0] expected, input [255:0] name);
        begin
            if (actual === expected)
                $display("PASS %0s: %0d", name, actual);
            else
                $display("FAIL %0s: expected=%0d got=%0d", name, expected, actual);
        end
    endtask

    initial begin
        // Write 5 into x1
        we = 1; rd = 5'd1; wd = 32'd5;
        @(posedge clk); #1;

        // Write 7 into x2
        rd = 5'd2; wd = 32'd7;
        @(posedge clk); #1;

        // Read both back
        we = 0; rs1 = 5'd1; rs2 = 5'd2;
        #1;
        check(rd1, 32'd5, "read x1");
        check(rd2, 32'd7, "read x2");

        // we=0 must block a write
        rd = 5'd1; wd = 32'd99;
        @(posedge clk); #1;
        check(rd1, 32'd5, "we=0 blocks write");

        // Try writing to x0, it must still read 0
        we = 1; rd = 5'd0; wd = 32'd55;
        @(posedge clk); #1;
        we = 0; rs1 = 5'd0;
        #1;
        check(rd1, 32'd0, "x0 stays 0");

        $finish;
    end
endmodule