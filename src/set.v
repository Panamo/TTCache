/*
 * In The Name Of God
 * ========================================
 * [] File Name : set.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Wed 04 Mar 2015 08:00:58 AM IRST
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
module set (enable, word, comp,
	write, tag_in, data_in, valid_in,
	rst, hit, dirty, tag_out,
	data_out, valid);

	input enable;
	input [0:1] word;
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

	always @ (enable)
	
endmodule
