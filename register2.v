module register_file (
    input clk,
    input [1:0] MUX_tgt,
    input MUX_rf,
    input WE_rf,
    input [15:0] mem_out, alu_out, pc, instruction,
    output reg [15:0] reg_out1, reg_out2
);

reg [15:0] register_file [7:0];

parameter
    add = 3'b000,   addi = 3'b001,
    Nand = 3'b010,  lui = 3'b011,
    sw = 3'b101,    lw = 3'b100,
    beq = 3'b110,   jalr = 3'b111;

wire [2:0] opCode, rA, rB, rC;
wire [6:0] signed_imm;
wire [9:0] imm;

assign opCode = instruction[15:13];
assign rA = instruction[12:10];
assign rB = instruction[9:7];
assign rC = instruction[2:0];
assign signed_imm = instruction[6:0];
assign imm = instruction[9:0];

integer i;
initial begin
    for (i = 0; i < 8; i = i + 1)
        register_file[i] = 16'h0;
end

always @(*) begin
    case(opCode)
        add, Nand:
        begin
            reg_out1 = register_file[rB];
            reg_out2 = (MUX_rf == 1'b0) ? register_file[rC] : register_file[rA];
        end
        addi:
        begin
            reg_out1 = register_file[rB];
            reg_out2 = {{9{signed_imm[6]}}, signed_imm};
        end
        lui:
        begin
            reg_out1 = imm << 6;
            reg_out2 = 16'b0;
        end
        sw:
        begin
            reg_out1 = register_file[rB];
            reg_out2 = (MUX_rf == 1'b0) ? register_file[rC] : register_file[rA];
        end
        lw:
        begin
            reg_out1 = register_file[rB];
            reg_out2 = {{9{signed_imm[6]}}, signed_imm};
        end
        beq:
        begin
            reg_out1 = register_file[rB];
            reg_out2 = (MUX_rf == 1'b0) ? register_file[rC] : register_file[rA];
        end
        jalr:
        begin
            reg_out1 = register_file[rB];
            reg_out2 = pc + 1;
        end
        default: 
        begin
            reg_out1 = 16'h0;
            reg_out2 = 16'h0;
        end
    endcase
end

always @(posedge clk) begin
    if (WE_rf == 1'b1 && rA != 3'b000) begin
        register_file[rA] = (MUX_tgt == 2'b00) ? mem_out :
                            (MUX_tgt == 2'b01) ? alu_out : pc + 1;
    end
end

endmodule