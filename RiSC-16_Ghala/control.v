module control(
    input [2:0] opcode,
    input EQ,
    output [1:0] FUNC_alu,MUX_pc, MUX_tgt,
    output MUX_alu1, MUX_alu2, MUX_rf, WE_rf, WE_dmem
);
    wire add = (opcode == 3'b000);
    wire addi = (opcode == 3'b001);
    wire isnand = (opcode == 3'b010);
    wire lui  = (opcode == 3'b011);
    wire sw  = (opcode == 3'b101);
    wire lw  = (opcode == 3'b100);
    wire beq = (opcode == 3'b110);
    wire jalr = (opcode == 3'b111);

    // alu.v
    assign FUNC_alu = isnand ? 2'b01 :
                      lui ? 2'b10 :
                      2'b00; 
    assign MUX_alu1 = lui;
    assign MUX_alu2 = (addi | sw | lw) ;

    // Program_counter.v
    assign MUX_pc = (beq & EQ) ? 2'b01 :
                    jalr ? 2'b10 :
                    2'b00;

    // register_file.v
    // 00:mem_out (sw)      01:alu_out (add,addi,nand,lui,lw)      10:pc+1(jalr)
    assign WE_rf = (add | addi | isnand | lui | lw | jalr);
    assign WE_dmem = sw;
    assign MUX_tgt = lw ? 2'b00 :
                        (add | addi | isnand | lui) ? 2'b01 :   
                        jalr ? 2'b10 :
                        2'b00;
    assign MUX_rf = (sw | beq); // 0:rC(ADD/NAND)  1:rA(SW/BEQ)
endmodule