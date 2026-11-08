module pc_tb;
    logic clk;
    logic reset;
    logic [31:0] pc_out;

    pc dut (
        .clk(clk),
        .reset(reset),
        .pc_out(pc_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("pc_tb.vcd");
        $dumpvars(0, pc_tb);
        $monitor("time=%0t reset=%b pc_out=%0d", $time, reset, pc_out);
        reset = 1;
        #12;
        reset = 0;
        #40;
        $finish;
    end
endmodule
