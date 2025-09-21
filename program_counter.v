// Program Counter Module for RisC-16 Processor
module Program_Counter (
    input  clk,reset,
    input  [2:0]  op,          
    input  [15:0] alu_out,   
    input  [15:0] regB,        
    input  [7:0] imm,         
    output reg  [15:0] pc
);
    // opcode: 111 - jalr, 110 - beq, others - normal
    wire jalr = (op == 3'b111);
    wire beq  = (op == 3'b110) && (alu_out == regB);

    // RisC-16 beq/jalr address calculation
    wire [15:0] beq_do  = pc + 16'd1 + imm; 
    wire [15:0] jalr_do = alu_out;        

    // Next PC logic
    wire [15:0] next = jalr ? jalr_do :
                        beq  ? beq_do  :
                        pc + 16'd1;

    // PC register update
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 16'd0;
        else
            pc <= next;
    end
endmodule
