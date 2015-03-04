/*
 * In The Name Of God
 * ========================================
 * [] File Name : block_t.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Wed 04 Mar 2015 08:00:43 AM IRST
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
`timescale 1 ns/100 ps

module block_t;
	reg [0:15] data_in;
	reg enable;
	reg write;

	wire [0:15] data_out;

	initial begin
		$dumpfile("block.vcd");
		$dumpvars(0, block_t);
		enable = 0;
		write = 0;
		#5 enable = 1;
		data_in = 16'b0000_1111_0000_1111;
		write = 1;
		#1 write = 0;
		#10 $stop;
	end
	block blk(enable, write, data_in, data_out);
endmodule
