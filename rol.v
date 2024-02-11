`timescale 1ns / 1ps

module rotate_left_32(
    input [31:0] data_in,
    input [4:0]  rotate_amount,
    output [31:0] data_out
);

assign data_out = {data_in[rotate_amount-1:0], data_in[31:rotate_amount]};

endmodule