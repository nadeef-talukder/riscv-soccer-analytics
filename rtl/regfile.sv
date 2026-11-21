module regfile (
    input  logic clk,
    input  logic we,
    input  logic [4:0] rs1, //read address
    input  logic [4:0] rs2, //read address
    input logic [4:0] rd, //write address
    input logic [31:0] wd,  //write data
    output logic [31:0] rd1,  //read data
    output logic [31:0] rd2  //read data
);

    logic [31:0] bank [0:31];

    always_ff @(posedge clk) begin
        if (we)
            bank[rd] <= wd;
    end

    assign rd1 = (rs1 == 5'd0) ? 32'd0 : bank[rs1];

    assign rd2 = (rs2 == 5'd0) ? 32'd0 : bank[rs2];

endmodule
