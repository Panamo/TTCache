/*
 * In The Name Of God
 * ========================================
 * [] File Name : way.v
 *
 * [] Creation Date : 31-03-2015
 *
 * [] Last Modified : Tue, Mar 31, 2015  6:18:46 PM
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
`timescale 1 ns/100 ps

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

	reg [0:N - 1] counter;
	reg flag;

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
		set set_ins (set_en[i], set_word[i], set_cmp[i], set_wr[i], 1'b0,
			set_tag_in[i], set_in[i], set_valid_in[i], set_hit[i], set_dirty_out[i],
			set_tag_out[i], set_out[i], set_valid_out[i], set_ack[i]);
	end
	endgenerate

	reg rand_en;
	reg rand_rst = 1'b0;
	wire [4:0] rand;

	fibonacci_lfsr rnd (rand_en, rand_rst, rand);

	always @ (enable) begin
		ack = 1'b0;
		if (enable) begin
			/* Reset */
			/* Compare Read */
			if (comp && !write) begin
				for (counter = 0; counter < N; counter = counter + 1) begin
					set_tag_in[counter] = tag_in;
					set_wr[counter] = write;
					set_cmp[counter] = comp;
					set_word [counter] = word;
					set_en[counter] = 1'b1;
					
					/* waiting for set ack */
					wait (set_ack[counter]) begin
						if (set_hit[counter]) begin
							/* ONE HIT */
							hit = 1'b1;
							valid_out = set_valid_out[counter];
							dirty_out = set_dirty_out[counter];
							data_out = set_out[counter];
							set_en[counter] = 1'b0;
						end else begin
							set_en[counter] = 1'b0;
						end
					end
				end
				if (!hit) begin
					/* ALL MISS */
					hit = 1'b0;
				end
				ack = 1'b1;
			end
			/* Compare Write */
			if (comp && write) begin
				for (counter = 0; counter < N; counter = counter + 1) begin
					set_en[counter] = 1'b1;
					set_tag_in[counter] = tag_in;
					set_in[counter] = data_in;
	
					/* waiting for set ack */
					wait (set_ack[counter]) begin
						if (set_hit[counter]) begin
							/* HIT -- Valid */
							hit = 1'b1;
							set_en[counter] = 1'b0;
						end else begin
							set_en[counter] = 1'b0;
						end
					end
				end
				if (!hit) begin
					/* MISS -- Valid */
					hit = 1'b0;
				end
				ack = 1'b1;
			end
			/* Access Read */
			if (!comp && !write) begin
				ack = 1'b1;
			end
			/* Access Write */
			if (!comp && write) begin
				flag = 0;
				for (counter = 0; counter < N; counter = counter + 1) begin
					set_in[counter] = data_in;
					set_cmp[counter] = 1'b0;
					set_wr[counter] = 1'b0;
					set_en[counter] = 1'b1;

					/* waiting for set ack */
					wait (set_ack[counter]) begin
						if (!set_valid_out[counter] && !flag) begin
							#1
							flag = 1;
							set_en[counter] = 1'b0;
							wait (!set_ack[counter]) begin
							end
							/*
							 * just for better
							 * wave formats
							*/
							#1
							set_word[counter] = word;
							set_valid_in[counter] = valid_in;
							set_tag_in[counter] = tag_in;
							set_wr[counter] = 1'b1;
							set_cmp[counter] = 1'b0;
							set_en[counter] = 1'b1;
							wait (set_ack[counter]) begin
							end
							set_en[counter] = 1'b0;
						end
					end

				end
				if (!flag) begin
					rand_en = 1'b1;
					
					set_in[rand[4]] = data_in;
					set_word[rand[4]] = word;
					set_valid_in[rand[4]] = valid_in;
					set_tag_in[rand[4]] = tag_in;
					set_wr[rand[4]] = 1'b1;
					set_cmp[rand[4]] = 1'b0;
					set_en[rand[4]] = 1'b1;
					wait (set_ack[rand[4]]) begin
					end
					set_en[rand[4]] = 1'b0;
					rand_en = 1'b0;
				end
				ack = 1'b1;
			end
		end else begin
			hit = 1'b0;
		end
	end
endmodule
