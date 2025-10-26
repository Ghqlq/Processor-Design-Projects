module control(
    input [2:0] op,
    input       EQ,
    output reg WErf, WEdmem,            // 0: disable   1: enable
    output reg MUXalu1,                 // 0: rB        1: left-shift imm
    output reg MUXalu2,                 // 0: rC        1: sign-ext imm
    output reg MUXrf,                   // 0: rC        1: rA
    output reg [1:0] MUXtgt,            // 0: data mem  1: alu_out  2: pc + 1
    output reg [1:0] FUNCalu, MUXpc
);

always @(*) begin
    case(op):
        3'b000: begin       // add
            FUNCalu = 2'b00;
            MUXalu1 = 1'b0;
            MUXalu2 = 1'b0;
            MUXpc = 2'b00;
            MUXrf = 1'b0;
            MUXtgt = 2'b01;
            WErf = 1'b1;
            WEdmem = 1'b0;
        end
        3'b001: begin       // addi
            FUNCalu = 2'b00;
            MUXalu1 = 1'b0;
            MUXalu2 = 1'b1;
            MUXpc = 2'b00;
            MUXrf = 1'b1;
            MUXtgt = 2'b01;
            WErf = 1'b1;
            WEdmem = 1'b0;
        end
        3'b010: begin       // nand
            FUNCalu = 2'b01;
            MUXalu1 = 1'b0;
            MUXalu2 = 1'b0;
            MUXpc = 2'b00;
            MUXrf = 1'b0;
            MUXtgt = 2'b01;
            WErf = 1'b1;
            WEdmem = 1'b0;
        end
        3'b011: begin       // lui
            FUNCalu = 2'b10;
            MUXalu1 = 1'b1;
            MUXalu2 = 1'b1;
            MUXpc = 2'b00;
            MUXrf = 1'b1;
            MUXtgt = 2'b01;
            WErf = 1'b1;
            WEdmem = 1'b0;
        end
        3'b100: begin       // sw
            FUNCalu = 2'b00;
            MUXalu1 = 1'b0;
            MUXalu2 = 1'b1;
            MUXpc = 2'b00;
            MUXrf = 1'b1;
            MUXtgt = 2'b00; // ???? (no input to rf)
            WErf = 1'b0;
            WEdmem = 1'b1;
        end
        3'b101: begin       // lw
            FUNCalu = 2'b00;
            MUXalu1 = 1'b0;
            MUXalu2 = 1'b1;
            MUXpc = 2'b00;
            MUXrf = 1'b1;
            MUXtgt = 2'b00;
            WErf = 1'b1;
            WEdmem = 1'b0;
        end
        3'b110: begin       // beq
            FUNCalu = 2'b11;
            MUXalu1 = 1'b0;
            MUXalu2 = 1'b0;
            MUXpc = (EQ) ? 2'b01 : 2'b00;
            MUXrf = 1'b1;
            MUXtgt = 2'b01; // ????
            WErf = 1'b0;
            WEdmem = 1'b0;
        end
        3'b111: begin       // jalr
            FUNCalu = 2'b10;
            MUXalu1 = 1'b0;
            MUXalu2 = 1'b0; // ????
            MUXpc = 2'b10;
            MUXrf = 1'b1;
            MUXtgt = 2'b10;
            WErf = 1'b1;
            WEdmem = 1'b0;
        end
        default: begin
            FUNCalu = 2'b00;
            MUXalu1 = 1'b0;
            MUXalu2 = 1'b0;
            MUXpc = 2'b00;
            MUXrf = 1'b0;
            MUXtgt = 2'b00;
            WErf = 1'b0;
            WEdmem = 1'b0;
        end
    endcase
end

endmodule