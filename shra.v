module shra(
    input [31:0] data_in,
    input [4:0]  shift_amount,
    output [31:0] data_out
);

always @(*)
begin
    if (shift_amount >= 32)
        data_out = (data_in[31] == 1) ? 32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
    else if (data_in[31] == 1)
        data_out = { {shift_amount{1'b1}}, data_in[31-shift_amount:0] };
    else
        data_out = { {shift_amount{1'b0}}, data_in[31-shift_amount:0] };
end

endmodule