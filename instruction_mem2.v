module instruction_mem(
    input [15:0] pc,
    output [15:0] instr_out
);

reg [15:0] mem [0:65535];

integer i;
initial begin
    for (i = 0; i <= 65535; i = i + 1) begin
        mem_data[i] = 16'h0000;
    end
end

assign instr_out = mem[pc];

endmodule