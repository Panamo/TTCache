/*
 * In The Name Of God
 * ========================================
 * [] File Name : cachek.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Wed, Apr  1, 2015  9:22:47 AM
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
module cachek (enable, index, word, comp,
	write, tag_in, data_in, valid_in,
	rst, hit, dirty, tag_out,
	data_out, valid, ack);

	parameter N = 15;
	reg [0:3] counter;

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
	output reg ack;
		
	reg way_en [0:N];
	reg [0:1] way_word [0:N];
	reg way_cmp [0:N];
	reg way_wr [0:N];
	reg [0:4] way_tag_in [0:N];
	reg [0:15] way_in [0:N];
	reg way_valid_in [0:N];
	reg way_rst [0:N];

	wire way_hit [0:N];
	wire way_dirty_out [0:N];
	wire [0:4] way_tag_out [0:N];
	wire [0:15] way_out [0:N];
	wire way_valid_out [0:N];
	wire way_ack [0:N];

	generate
	genvar i;
	for (i = 0; i < N; i = i + 1) begin
		way way_ins(way_en[i], way_word[i], way_cmp[i], way_wr[i], way_rst[i],
			way_tag_in[i], way_in[i], way_valid_in[i], way_hit[i], way_dirty_out[i],
			way_tag_out[i], way_out[i], way_valid_out[i], way_ack[i]);
	end
	endgenerate
	
	always @ (enable) begin
		ack = 1'b0;
		if (enable) begin
			if (rst) begin
				for (counter = 0; counter < N; counter = counter + 1) begin
					way_en[counter] = 1'b1;
					way_rst[counter] = 1'b1;
					wait (way_ack[counter]) begin
						way_en[counter] = 1'b0;
						way_rst[counter] = 1'b0;
					end
				end
				ack = 1'b1;
			end else begin
				way_word[index] = word;
				way_cmp[index] = comp;
				way_wr[index] = write;
				way_tag_in[index] = tag_in;
				way_in[index] = data_in;
				way_valid_in[index] = valid_in;
				way_en[index] = 1'b1;
			
				wait (way_ack[index]) begin
					hit = way_hit[index];
					dirty = way_dirty_out[index];
					tag_out = way_tag_out[index];
					valid = way_valid_out[index];
					data_out = way_out[index];
				end

				ack = 1'b1;
			end
		end else begin
			way_en[index] = 1'b0;
		end
	end
endmodule
