`timescale 1ns / 1ps

module ror(
    input [31:0] data_in,
    input [31:0]  rotate_amount,
    output [31:0] data_out
);

genvar i;
generate
    for (i = 0; i < 32; i = i + 1) begin : rotate_right_gen
        assign data_out[i] = data_in[(i + rotate_amount + 32) % 32];
    end
endgenerate

endmodule