module program_counter(
    input  clk, reset,
    input  [15:0] imm,          // BEQ
    input  [15:0] alu_out,      // JALR
    input  [15:0] increment,    // increment current address by 1
    input  [2:0] mux_input,
    output [15:0] pc_out
);

    reg [15:0] pc;

    wire sel_address = (mux_input == 3'b110) ? imm :
                       (mux_input == 3'b111) ? alu_out :
                       increment;

    assign pc_out = pc;

    always @(posedge clk) begin
        if (reset)
            pc <= 16'b0;
        else
            pc <= sel_address;
    end

endmodule