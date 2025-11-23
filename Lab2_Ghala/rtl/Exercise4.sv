/**
  @brief An asynchronous mux/decoder

  @input sel   input select
  @input cs    chip select

  @input alpha alpha input
  @input beta  beta input
  @input gamma gamma input

  @output out output
*/
module Exercise4 (
    input [1:0] sel,
    input cs,

    input [7:0] alpha,
    input [7:0] beta,
    input [7:0] gamma,

    output logic [7:0] out
);
    always_comb begin
      out = 8'b0;
      if(cs) begin
        case(sel)
          2'b00: out = alpha;
          2'b01: out = beta;
          2'b10: out = gamma;
          default: out = 8'b0;
        endcase
      end
    end

endmodule
