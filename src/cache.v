module cache (enable, index, word, comp,
	write, tag_in, data_in, valid_in,
	clk, rst, hit, dirty, tag_out,
	data_out, valid);

	input enable;
	input [0:7] index;
	input [0:3] word;
	input comp;
	input write;
	input [0:4] tag_in;
	input [0:15] data_in;
	input valid_in;
	input clk;
	input rst;

	output hit;
	output dirty;
	output [0:4] tag_out;
	output [0:15] data_out;
	output valid;

endmodule
