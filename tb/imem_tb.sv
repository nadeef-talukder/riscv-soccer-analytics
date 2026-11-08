module imem_tb;
    logic [31:0] addr;
    logic [31:0] instr;

    imem dut (
        .addr(addr),
        .instr(instr)
    );

    task check(input [31:0] a, input [31:0] expected);
        begin
            addr = a;
            #10;
            if (instr === expected)
                $display("PASS addr=%0d instr=%h", a, instr);
            else
                $display("FAIL addr=%0d expected=%h got=%h", a, expected, instr);
        end
    endtask

    initial begin
        check(32'd0,  32'h00500093);
        check(32'd4,  32'h00700113);
        check(32'd8,  32'h001101B3);
        check(32'd12, 32'h40118233);
        check(32'd8,  32'h001101B3);
        $finish;
    end
endmodule
