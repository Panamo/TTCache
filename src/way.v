/*
 * In The Name Of God
 * ========================================
 * [] File Name : way.v
 *
 * [] Creation Date : 31-03-2015
 *
 * [] Last Modified : Tue 31 Mar 2015 12:54:49 PM IRDT
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
module way (enable, word, comp,
	write, rst, tag_in, data_in, valid_in,
	hit, dirty_out, tag_out,
	data_out, valid_out, ack);

	parameter N = 2;

	input enable;
	input rst;
	input [0:1] word;
	input comp;
	input write;
	input rst;
	input [0:4] tag_in;
	input [0:15] data_in;
	input valid_in;

	output reg hit;
	output reg dirty_out;
	output reg [0:4] tag_out;
	output reg [0:15] data_out;
	output reg valid_out;
	output reg ack;

	reg set_en [0:N];
	reg [0:1] set_word [0:N];
	reg set_cmp [0:N];
	reg set_wr [0:N];
	reg [0:4] set_tag_in [0:N];
	reg [0:15] set_in [0:N];
	reg set_valid_in [0:N];
	reg set_rst [0:N];

	wire set_hit [0:N];
	wire set_dirty_out [0:N];
	wire [0:4] set_tag_out [0:N];
	wire [0:15] set_out [0:N];
	wire set_valid_out [0:N];
	wire set_ack [0:N];

	generate
	genvar i;
	for (i = 0; i < N; i = i + 1) begin
		set set_ins(set_en[i], set_word[i], set_cmp[i], set_wr[i], set_rst[i],
			set_tag_in[i], set_in[i], set_valid_in[i], set_hit[i], set_dirty_out[i],
			set_tag_out[i], set_out[i], set_valid_out[i], set_ack[i]);
	end
	endgenerate

	always @ (enable) begin
