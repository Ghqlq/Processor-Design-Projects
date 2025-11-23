module Exercise3 (
    input clk,
    input nReset,
    input [3:0] a,
    input [15:0] b,
    input [15:0] c,
    output [15:0] out
);
    wire [7:0] d_alpha;
    wire [7:0] d_beta;
    
    Mystery1 Alpha(
        .a(a[1:0]),
        .b(b[7:0]),
        .c(c[7:0]),
        .d(d_alpha)
    );
    Mystery1 Beta(
        .a(a[3:2]),
        .b(b[15:8]),
        .c(c[15:8]),
        .d(d_beta)
    );
    Mystery2 Gamma(
        .clk(clk),
        .nReset(nReset),
        .a_in(d_alpha),
        .b_in(d_beta),
        .out(out)
    );

endmodule
