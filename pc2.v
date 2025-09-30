module pc (
    input  clk, reset_n,
    input  [6:0] imm,           // BEQ
    input  [15:0] alu_out,      // JALR
    input  [1:0] mux_output,
    output [15:0] pc_out
);

reg [15:0] pc;
assign pc_out = pc;

wire [15:0] imm_ext;
assign imm_ext = {9'b0, imm};

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        pc <= 16'b0;
    else
    begin
        case (mux_output)
            2'b00:
                pc <= pc + 1;
            2'b01:
                pc <= pc + 1 + imm;
            2'b10:
                pc <= alu_out;
            default:
                pc <= pc + 1;
        endcase
    end
end

endmodule

// why is reset negative?
// why is the imm value inputted as 7-bit not 16-bit