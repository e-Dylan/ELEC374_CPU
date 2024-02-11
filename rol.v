`timescale 1ns / 1ps

module rol(
    input [31:0] data_in,
    input [4:0]  rotate_amount,
    output [31:0] data_out
);

genvar i;
generate
    for (i = 0; i < 32; i = i + 1) begin : rotate_left_gen
        assign data_out[i] = data_in[(i + rotate_amount) % 32];
    end
endgenerate

endmodule