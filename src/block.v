/*
 * In The Name Of God
 * ========================================
 * [] File Name : block.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Tue 31 Mar 2015 08:03:47 AM IRDT
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
module block(enable, write, ret, data_in, data_out, ack);
	
	input enable;
	input write;
	input rst;
	input [0:15] data_in;

	output reg [0:15] data_out;
	output reg ack;

	reg [0:15] data;

	always @ (enable) begin
		ack = 1'b0;
		if (enable) begin
			if (write)
				data = data_in;
			if (rst)
				data = 4'h0000;
			data_out = data;
			ack = 1'b1;
		end
	end
endmodule
