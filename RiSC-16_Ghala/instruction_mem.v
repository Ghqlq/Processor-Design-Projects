module instruction_mem(
    input  [15:0] pc,
    output [15:0] instr_out
);
    reg [15:0] mem [0:65535];

    initial begin
        $readmemb("program.mem", mem, 0, 8);
    end

    assign instr_out = mem[pc];
endmodule