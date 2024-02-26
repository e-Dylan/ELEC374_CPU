module shiftrightari32(
    input signed [31:0] data_in,
    input signed [31:0]  num_shifts,
    output wire [31:0] out
);												
	assign out[31:0] = data_in>>>num_shifts;
endmodule