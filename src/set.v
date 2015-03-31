/*
 * In The Name Of God
 * ========================================
 * [] File Name : set.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Tue 31 Mar 2015 01:27:59 PM IRDT
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
module set (enable, word, comp,
	write, rst, tag_in, data_in, valid_in,
	hit, dirty_out, tag_out,
	data_out, valid_out, ack);
	
	/* set number of block in a set */
	parameter N = 4;

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

	reg [0:4] tag;
	reg valid = 1'b0;
	reg dirty = 1'b0;

	reg [0:15] word_in [0:N];
	reg word_en [0:N];
	reg word_wr [0:N];
	wire [0:15] word_out [0:N];
	wire word_ack [0:N];

	generate
	genvar i;
	for (i = 0; i < N; i = i + 1) begin
		block blk_ins(word_en[i], word_wr[i], 1'b0, word_in[i], word_out[i], word_ack[i]);
	end
	endgenerate

	always @ (enable) begin
		ack = 1'b0;
		if (enable) begin
			/* Reset */
			if (rst) begin
				valid = 1'b0;
				ack = 1'b1;
			end
			/* Compare Read */
			if (comp && !write) begin
				if (tag == tag_in) begin
					/* HIT */
					hit = 1'b1;
					valid_out = valid;
					dirty_out = dirty;
					word_en[word] = 1'b1;

					/* waiting for block ack */
					wait (word_ack[word]) begin
						data_out = word_out[word];
					end

					ack = 1'b1;
				end else begin
					/* MISS */
					hit = 1'b0;
					valid_out = valid;
					dirty_out = dirty;
					ack = 1'b1;
				end
			end
			/* Compare Write */
			if (comp && write)  begin
				if (tag == tag_in && valid) begin
					/* HIT -- Valid */
					dirty = 1'b1;
					dirty_out = 1'b0;
					hit = 1'b1;
					word_en[word] = 1'b1;
					word_wr[word] = 1'b1;
					word_in[word] = data_in;

					/* waiting for block ack */
					wait (word_ack[word]) begin
					end
					
					ack = 1'b1;
				end else begin
					/* MISS -- Valid */
					valid_out = valid;
					dirty_out = dirty;
					ack = 1'b1;
				end
			end
			/* Access Read */
			if (!comp && !write) begin
				dirty_out = dirty;
				valid_out = valid;
				tag_out = tag;
				word_en[word] = 1'b1;

				/* waiting for block ack */
				wait (word_ack[word]) begin
					data_out = word_out[word];
				end

				ack = 1'b1;
			end
			/* Access Write */
			if (!comp && write) begin
				tag = tag_in;
				valid = valid_in;
				dirty = 1'b0;
				word_wr[word] = 1'b1;
				word_en[word] = 1'b1;
				word_in[word] = data_in;

				/* waiting for block ack */
				wait (word_ack[word]) begin
				end
				
				ack = 1'b1;
			end
		end else begin
			word_en[word] = 1'b0;
			word_wr[word] = 1'b0;
			hit = 1'b0;
		end
	end	
endmodule
