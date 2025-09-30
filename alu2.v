module alu (
    input [9:0] imm,
    input [15:0] src1, src2,
    input [1:0] mux_alu1, mux_alu2,
    input [1:0] func_alu,
    output reg EQ,
    output reg [15:0] alu_out
);

wire [15:0] imm_left_shift, imm_sign_ext;
assign imm_left_shift = imm << 6;
assign imm_sign_ext = {{9{imm[6]}}, imm[6:0]};

wire [15:0] src1_out, src2_out;
assign src1_out = (mux_alu1) ? imm_left_shift : src1;
assign src2_out = (mux_alu2) ? imm_sign_ext : src2;

always @(*) begin
    alu_out = 16'b0;
    EQ = (src1_out == src2_out);
    begin
        case (func_alu)
            2'b00:
            begin
                alu_out = src1_out + src2_out;
            end
            2'b01:
                alu_out = ~(src1_out & src2_out); 
            2'b10:
                alu_out = src1_out;
            2'b11:
                alu_out = 16'b0;
            default:
            begin
                alu_out = 16'b0;
                EQ = 1'b0;
            end
        endcase
    end
end

endmodule

// when do you use register as outputs?
// when do you use clk? (no iteration...)