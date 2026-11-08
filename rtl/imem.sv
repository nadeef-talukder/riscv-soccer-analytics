module imem #(
    parameter INIT_FILE = "asm/test_basic.hex"
) (
    /* verilator lint_off UNUSEDSIGNAL */
    input  logic [31:0] addr,
    /* verilator lint_on UNUSEDSIGNAL */
    output logic [31:0] instr
);

    logic [31:0] mem [0:63];

    initial begin
        $readmemh(INIT_FILE, mem);
    end

    assign instr = mem[addr[7:2]];

endmodule
