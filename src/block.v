/*
 * In The Name Of God
 * ========================================
 * [] File Name : block.v
 *
 * [] Creation Date : 04-03-2015
 *
 * [] Last Modified : Tue, Mar 31, 2015  7:56:39 PM
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/
module block(enable, write, rst, data_in, data_out, ack);
	
	input enable;
	input write;
	input rst;
	input [0:15] data_in;

	output reg [0:15] data_out = 16'h0000;
	output reg ack = 1'b0;

	reg [0:15] data = 16'h0000;

	always @ (enable) begin
		ack = 1'b0;
		if (enable) begin
			if (write)
				data = data_in;
			if (rst)
				data = 16'h0000;
			data_out <= data;
			ack <= 1'b1;
		end
	end
endmodule
