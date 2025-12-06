module alu(
    input MUX_alu1, MUX_alu2,          
    input [1:0] FUNC_alu,         
    input [15:0] src1_reg,
    input [15:0] src2_reg,
    input [9:0] imm,            
    output EQ,
    output [15:0] alu_out
); 
    wire [15:0] src1 = MUX_alu1 ? ({imm, 6'b0}) : src1_reg;
    wire [15:0] src2 = MUX_alu2 ? ({{9{imm[6]}}, imm[6:0]}) : src2_reg;
    assign alu_out =
        (FUNC_alu == 2'b00) ? src1 + src2 :
        (FUNC_alu == 2'b01) ? ~(src1 & src2) :
        (FUNC_alu == 2'b10) ? src1 :
        16'h0000;

    assign EQ = src1==src2;
endmodule
