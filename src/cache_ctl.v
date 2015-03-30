/*
 * In The Name Of God
 * ========================================
 * [] File Name : cache_ctl.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Mon 30 Mar 2015 06:37:53 PM IRDT
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/

`timescale 1 ns/100 ps
module cache_ctl (enable, clk, index, word, comp,
	write, tag_in, data_in, valid_in,
	rst, hit, dirty, tag_out,
	data_out, valid);

	input clk;
	input enable;
	input [0:3] index;
	input [0:1] word;
	input comp;
	input write;
	input [0:4] tag_in;
	input [0:15] data_in;
	input valid_in;
	input rst;

	output reg hit;
	output reg dirty;
	output reg [0:4] tag_out;
	output reg [0:15] data_out;
	output reg valid;
		
	reg cache_en;
	reg cache_rst;
	reg [0:3] cache_index;
	reg [0:1] cache_word;
	reg cache_cmp;
	reg cache_wr;
	reg [0:4] cache_tag_in;
	reg [0:15] cache_in;
	reg cache_valid_in;

	wire cache_hit;
	wire cache_dirty_out;
	wire [0:4] cache_tag_out;
	wire [0:15] cache_out;
	wire cache_valid_out;
	wire cache_ack;

	cache cache_ins(cache_en, cache_index, cache_word, cache_cmp, cache_wr, cache_tag_in,
		cache_in, cache_valid_in, cache_rst, cache_hit, cache_dirty_out,
		cache_tag_out, cache_out, cache_valid_out, cache_ack);
	
	always @ (posedge clk) begin
		if (enable) begin
			cache_rst = rst;
			cache_word = word;
			cache_index = index;
			cache_cmp = comp;
			cache_wr = write;
			cache_tag_in = tag_in;
			cache_in = data_in;
			cache_valid_in = valid_in;
			cache_en = 1'b1;
			
			wait (cache_ack) begin
				hit = cache_hit;
				dirty = cache_dirty_out;
				tag_out = cache_tag_out;
				valid = cache_valid_out;
				data_out = cache_out;
			end
		end else begin
			cache_en = 1'b0;
		end
	end
	always @ (negedge clk) begin
		cache_en = 1'b0;
	end
endmodule
