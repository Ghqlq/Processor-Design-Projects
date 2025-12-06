// Program Counter Module for RisC-16 Processor
module pc(
    input  clk,rst_n,
    input  [1:0]  MUX_output,       
    input  [15:0] alu_out,
    input  [6:0] imm,   
    output [15:0] nxt_instr 
);
    reg [15:0] pc; 
    wire [15:0] imm_se = {{9{imm[6]}}, imm};
    wire [15:0] increment = (MUX_output == 2'b01) ? pc + 16'd1 + imm_se :
                       (MUX_output == 2'b10) ? alu_out :
                       pc + 16'd1; 

    always @(posedge clk) begin
        if (rst_n)
            pc <= increment;
        else
            pc <= 16'd0;
    end

    assign nxt_instr = pc;
endmodule
