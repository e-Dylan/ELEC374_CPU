module shra(
    input wire [31:0] data_in,
    input wire [31:0]  shift_amount,
    output wire [31:0] data_out
);

reg [31:0] out;

always @(*)
begin
    if (shift_amount >= 32)
        out = (data_in[31] == 1) ? 32'b11111111111111111111111111111111 : 32'b00000000000000000000000000000000;
    else if (data_in[31] == 1)
        out = { {shift_amount{1'b1}}, data_in[31-shift_amount:0] };
    else
        out = { {shift_amount{1'b0}}, data_in[31-shift_amount:0] };
end

assign data_out = out;

endmodule