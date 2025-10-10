module register_file (
    input clk,
    input [1:0] MUX_tgt,
    input MUX_rf,
    input WE_rf,
    input [15:0] mem_out, alu_out, pc,
    input [2:0] rA, rB, rC,
    output reg [15:0] reg_out1, reg_out2
);

reg [15:0] register_file [0:7];

// Intialize reigster file with 0s
integer i;
initial begin
    for (i = 0; i < 8; i = i + 1)
        register_file[i] = 16'h0;
end

assign reg_out1 = register_file[rB];
assign reg_out2 = (MUX_rf == 1'b0) ? register_file[rC] : register_file[rA];

// Store appropriate value into register file
always @(posedge clk) begin
    if (WE_rf == 1'b1 && rA != 3'b000) begin
        register_file[rA] = (MUX_tgt == 2'b00) ? mem_out :
                            (MUX_tgt == 2'b01) ? alu_out : pc + 1;
    end
end

endmodule