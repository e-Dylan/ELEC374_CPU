`timescale 1ns/10ps
module datapath_phase3_tb;
	reg clock, clear, stop;
	wire[31:0] InPort_input, OutPort_output;
	
	datapath DUT(
		.clock(clock),
		.clear(clear),
		.stop(stop),
		.InPort_input(InPort_input),
		.OutPort_output(OutPort_output)
	);

	initial
		begin
			clock = 0;
			clear = 0;
			forever #10 clock = ~clock;
	end
endmodule