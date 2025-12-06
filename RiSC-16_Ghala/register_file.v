module register_file (
    input [1:0] MUX_tgt, //          00:mem_out      01:alu_out      10:pc+1
    input MUX_rf, WE_rf, clk, //     MUX_rf -> 0:rC(ADD/NAND)  1:rA(SW/BEQ)
    input [15:0] mem_out, alu_out, pc,
    input [2:0] rA, rB, rC,
    output [15:0] reg_out1, reg_out2
);
    reg [15:0] register_file [0:7];

    //wire [2:0] rA = instruction[12:10];
    //wire [2:0] rB = instruction[9:7];
    //wire [2:0] rC = instruction[2:0];

    assign reg_out1  = register_file[rB];
    assign reg_out2  =  (MUX_rf == 1'b0) ? register_file[rC] : register_file[rA]; 
    wire [15:0] MUX_output;
    assign MUX_output = (MUX_tgt == 2'b00) ? mem_out :
                               (MUX_tgt == 2'b01) ? alu_out :
                               (MUX_tgt == 2'b10) ? pc + 16'd1:
                                16'h0000;
    
    integer i; // loop in verilog
    initial begin
        for (i = 0; i < 8; i = i + 1) register_file[i] = 16'h0000;
    end

    always @(posedge clk) begin
        register_file[0] <= 16'h0000; //r0 has to stay 0
        if (WE_rf && (rA != 3'b0)) begin 
            register_file[rA] <= MUX_output;
        end
    end
endmodule
