module block(enable, comp, write, tag_in, data_in,
	valid_in, hit, dirty, tag_out, data_out, valid);
	
	input enable;
	input comp;
	input write;
	input [0:4] tag_in;
	input [0:15] data_in;
	input valid_in;

	output hit;
	output dirty;
	output [0:4] tag_out;
	output [0:15] data_out;
	output valid;

endmodule
