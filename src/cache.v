/*
 * In The Name Of God
 * ========================================
 * [] File Name : cache.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Wed 04 Mar 2015 09:30:24 PM IRST
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
module cache (enable, index, word, comp,
	write, tag_in, data_in, valid_in,
	rst, hit, dirty, tag_out,
	data_out, valid);

	parameter N = 10;

	input enable;
	input [0:7] index;
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

	/*
	 *                      +-------------------+
         *                      |                   |
         *        enable >------|                   |
         *    index[7:0] >------|    cache          |
         *     word[1:0] >------|                   |
         *          comp >------|    256 lines      |-----> hit
         *         write >------|    by 4 words     |-----> dirty
         *   tag_in[4:0] >------|                   |-----> tag_out[4:0]
         * data_in[15:0] >------|                   |-----> data_out[15:0]
         *      valid_in >------|                   |-----> valid
         *                      |                   |
         *           clk >------|                   |
         *           rst >------|                   |
         *    createdump >------|                   |
         *                      +-------------------+
	*/
	
		
	reg set_en [0:N];
	reg set_rst [0:N];
	reg [0:1] set_word [0:N];
	reg set_cmp [0:N];
	reg set_wr [0:N];
	reg [0:4] set_tag_in [0:N];
	reg [0:15] set_in [0:N];
	reg set_valid_in [0:N];

	wire set_hit [0:N];
	wire set_dirty_out [0:N];
	wire [0:4] set_tag_out [0:N];
	wire [0:15] set_out [0:N];
	wire set_valid_out [0:N];

	generate
	genvar i;
	for (i = 0; i < N; i = i + 1) begin
		set set_ins(set_en[i], set_word[i], set_cmp[i], set_wr[i], set_tag_in[i],
			set_in[i], set_valid_in[i], rst, set_hit[i], set_dirty_out[i],
			set_tag_out[i], set_out[i], set_valid_out[i]);
	end
	endgenerate
	
	always @ (enable) begin
		if (enable) begin
			
		end else begin
		
		end
	end
endmodule
