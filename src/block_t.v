/*
 * In The Name Of God
 * ========================================
 * [] File Name : block_t.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Tue 31 Mar 2015 08:04:53 AM IRDT
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
`timescale 1 ns/100 ps

module block_t;
	reg [0:15] data_in;
	reg enable;
	reg write;
	reg rst;

	wire [0:15] data_out;
	wire ack;

	initial begin
		$dumpfile("block.vcd");
		$dumpvars(0, block_t);
		enable = 0;
		write = 0;
		rst = 0;
		#5
		enable = 1;
		write = 1;
		data_in = 16'b0000_1111_0000_1111;
		#1
		enable = 0;
		write = 0;
		#2
		enable = 1;
		rst = 1;
		#10
		$stop;
	end
	block blk(enable, write, rst, data_in, data_out, ack);
endmodule
