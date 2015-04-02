/*
 * In The Name Of God
 * ========================================
 * [] File Name : cache_ctl_t.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Thu, Apr  2, 2015 10:12:18 AM
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
`timescale 1 ns/100 ps

module cache_ctl_t;
	reg [0:15] data_in;
	reg [0:4] tag;
	reg enable;
	reg clk;
	reg write;
	reg [0:1] word;
	reg cmp;
	reg rst;
	reg valid_in;
	reg [0:3] index;

	wire [0:15] data_out;
	wire [0:4] tag_out;
	wire hit;
	wire dirty;
	wire valid;

	initial begin
		$dumpfile("cache_ctl.vcd");
		$dumpvars(0, cache_ctl_t);
		enable = 0;
		word = 2'b11;
		data_in = 16'b0000_1111_0000_1111;
		valid_in = 1'b1;
		tag = 5'b11101;
		index = 4'b0000;
		#5
		enable = 1;
		write = 1;
		cmp = 0;
		#5
		enable = 0;
		#5
		enable = 1;
		write = 0;
		cmp = 1;
		#5
		enable = 0;
		write = 0;
		cmp = 0;
		rst = 1;
		#5
		enable = 1;
		#5
		enable = 0;
		rst = 0;
		write = 0;
		cmp = 0;
		#5
		enable = 1;
		#5
		enable = 0;
		$stop;
	end
	
	initial begin
		clk = 0;
		forever begin
			#5
			clk = ~clk;
		end
	end

	cache_ctl chc(clk, enable, index, word, cmp, write, tag, data_in, valid_in, rst, hit, dirty, tag_out, data_out, valid);
endmodule
