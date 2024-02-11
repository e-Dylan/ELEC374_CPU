`timescale 1ns / 1ps

module rotate_right_32(
    input [31:0] data_in,
    input [4:0]  rotate_amount,
    output [31:0] data_out
);

assign data_out = {data_in[31-rotate_amount:31], data_in[31:rotate_amount]};

endmodule