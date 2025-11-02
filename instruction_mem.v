module instruction_mem(
    input  [15:0] pc,
    output [15:0] instr_out
);
    reg [15:0] mem [0:65535];

    initial begin
        mem[16'h0000] = 16'h;
        mem[16'h0001] = 16'h;
        //....
    end
    assign instr_out = mem[pc];  
endmodule