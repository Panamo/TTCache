/*
 * In The Name Of God
 * ========================================
 * [] File Name : cachek_t.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Wed 01 Apr 2015 09:17:42 AM IRDT
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
`timescale 1 ns/100 ps

module cachek_t;
	reg [0:15] data_in;
	reg [0:4] tag;
	reg enable;
	reg write;
	reg [0:1] word;
	reg cmp;
	reg [0:3] index;
	reg valid_in;
	reg rst;

	wire [0:15] data_out;
	wire [0:4] tag_out;
	wire hit;
	wire dirty;
	wire valid;
	wire ack;

	initial begin
		$dumpfile("cachek.vcd");
		$dumpvars(0, cachek_t);
		enable = 0;
		rst = 0;
		word = 2'b11;
		valid_in = 1'b1;
		data_in = 16'b0000_1111_0000_1111;
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
		#5
		enable = 1;
		rst = 1;
		wait (ack) begin
		end
		#5
		rst = 0;
		enable = 0;
		#5
		enable = 1;
		write = 0;
		cmp = 1;
		#10
		$stop;
	end

	cachek chk(enable, index, word, cmp, write, tag, data_in,
		valid_in, rst, hit, dirty, tag_out, data_out, valid, ack);
endmodule
