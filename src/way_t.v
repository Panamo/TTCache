/*
 * In The Name Of God
 * ========================================
 * [] File Name : way_t.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Tue, Mar 31, 2015 10:56:44 PM
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
`timescale 1 ns/100 ps

module way_t;
	reg [0:15] data_in = 16'h0f0f;
	reg [0:4] tag;
	reg enable = 1'b0;
	reg write = 1'b0;
	reg [0:1] word;
	reg cmp;
	reg valid_in;
	reg rst;

	wire [0:15] data_out;
	wire [0:4] tag_out;
	wire hit;
	wire dirty;
	wire valid;
	wire ack;

	initial begin
		$dumpfile("way.vcd");
		$dumpvars(0, way_t);
		enable <= 0;
		rst <= 0;
		word <= 2'b11;
		valid_in <= 1'b1;
		data_in <= 16'h0f0f;
		tag <= 5'b11101;
		#5
		enable <= 1;
		write <= 1;
		cmp <= 0;
		#5
		enable <= 0;
		#5
		enable <= 1;
		write <= 0;
		cmp <= 1;
		#5
		enable <= 0;
		write <= 0;
		cmp <= 0;
		#5
		enable <= 1;
		rst <= 1;
		wait (ack) begin
		end
		#5
		rst <= 0;
		enable <= 0;
		#5
		enable <= 1;
		write <= 0;
		cmp <= 1;
		#10
		$stop;
	end

	way wy(enable, word, cmp, write, rst, tag, data_in,
		valid_in, hit, dirty, tag_out, data_out, valid, ack);
endmodule
