module register (
    input [1:0] MUX_tgt,        // already chosen??
    input MUX_rf,               // choose rA or rC
    input WE_rf,                // ????
    input mem_out, alu_out, pc,
    input [15:0] instruction,
    output [2:0] reg_out1, reg_out2
);

reg [15:0] reg_arr [7:0];

parameter
    add = 3'b000,   addi = 3'b001,
    Nand = 3'b010,  lui = 3'b011,
    sw = 3'b101,    lw = 3'b100,
    beq = 3'b110,   jalr = 3'b111;

wire [3:0] opCode, rA, rB, rC;
wire [6:0] signed_imm;
wire [9:0] imm;

assign opCode = instruction[15:13];
assign rA = instruction[12:10];
assign rB = instruction[9:7];
assign rC = instruction[2:0];
assign signed_imm = instruction[6:0];
assign imm = instruction[9:0];

// ALU: add, addi, nand,            lui????
// Data Memoryl: sw, lw, beq, jalr

always @(*)
    begin
        if WE_rf == 1'b1:
            assign reg_arr[rA] = (MUX_tgt == 2'b00) ? mem_out :
                                 (MUX_tgt == 2'b01) ? alu_out : pc + 1;
        case(opCode)
        add, Nand:
            assign reg_out1 <= reg_arr[rB];
            assign reg_out2 <= reg_arr[rC];
        addi:
            assign reg_out1 <= reg_arr[rB];
            assign reg_out2 <= signed_imm;
        lui:
            assign reg_out1 <= imm;
        sw:
            assign reg_out1 <= reg_arr[rA];
            assign reg_out2 <= reg_arr[rB];
        lw:
            assign reg_out1 <= reg_arr[rB];
            assign reg_out2 <= signed_imm;
        beq:
            assign reg_out1 <= reg_arr[rA];
            assign reg_out2 <= reg_arr[rB];
        jalr:
            assign reg_out1 <= pc + 1;
        endcase
    end

endmodule