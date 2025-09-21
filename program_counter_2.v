module program_counter(
    input  clk, reset,
    input  wire [150] imm,          BEQ
    input  wire [150] alu_out,      JALR
    input  wire [20] mux_input,
    output wire [150] pc_out
);

    reg [150] pc;

    wire sel_address = (mux_input == 3'b110)  imm 
                       (mux_input == 3'b111)  alu_out  
                       pc = pc + 16'b1;

    assign pc_out = pc;

    always @(posedge clk) begin
        if (reset)
            pc = 16'b0;
        else
            pc = sel_address;
    end

endmodule