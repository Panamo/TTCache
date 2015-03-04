/*
 * In The Name Of God
 * ========================================
 * [] File Name : set.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Wed 04 Mar 2015 10:58:23 AM IRST
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
module set (enable, word, comp,
	write, tag_in, data_in, valid_in,
	rst, hit, dirty, tag_out,
	data_out, valid);
	
	/* set number of block in a set */
	parameter N = 4;

	input enable;
	input rst;
	input [0:1] word;
	input comp;
	input write;
	input [0:4] tag_in;
	input [0:15] data_in;
	input valid_in;

	output reg hit;
	output reg dirty;
	output reg [0:4] tag_out;
	output reg [0:15] data_out;
	output reg valid;

	reg [0:4] tag;

	reg [0:15] word_in [0:N];
	reg word_en [0:N];
	reg word_wr [0:N];
	wire [0:15] word_out [0:N];

	generate
	genvar i;
	for (i = 0; i < N; i = i + 1) begin
		block ins(word_en[i], word_wr[i], word_in[i], word_out[i]);

	end
	endgenerate

	always @ (enable) begin
		if (enable) begin
			if (comp && !write) begin
				if (tag == tag_in) begin
					/* HIT */
					hit = 1'b1;
					data_out = word_out[word];
					word_en[word] = 1'b1;
				end
			end
			if (!comp && write) begin
				tag = tag_in;
				word_in[word] = data_in;
				word_wr[word] = 1;
				word_en[word] = 1;
			end
		end else begin
			word_en[word] = 1'b0;
			word_wr[word] = 1'b0;
			hit = 1'b0;
		end
	end

	
endmodule
