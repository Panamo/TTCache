module block(enable, comp, write, data_in, data_out);
	
	input enable;
	input write;
	input [0:15] data_in;

	output [0:15] data_out;

endmodule
