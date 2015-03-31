/*
 * In The Name Of God
 * ========================================
 * [] File Name : fibonacci_lfsr.v
 *
 * [] Creation Date : 31-03-2015
 *
 * [] Last Modified : Tue 31 Mar 2015 05:26:46 PM IRDT
 *
 * [] Created By : Parham Alvani (parham.alvani@gmail.com)
 * =======================================
*/

/*
 * based on:
 * http://stackoverflow.com/questions/
 * 14497877/how-to-implement-a-pseudo-hardware-random-number-generator
*/
module fibonacci_lfsr (enable, rst, data);
   	parameter BITS = 5;

	input enable;
    	input rst;
	output reg [BITS - 1:0] datai = 5'h1f;

	reg [BITS - 1:0] data_next;

	always @* begin
      		data_next = data;
      		repeat(BITS) begin
         		data_next = {(data_next[BITS - 1]^data_next[1]), data_next[BITS - 1:1]};
      		end
   	end

   	always @(enable) begin
		if (enable) begin
      			if (rst) begin
         			data <= 5'h1f;
      			end else begin
         			data <= data_next;
      			end
		end
   	end
endmodule
