/*
 * In The Name Of God
 * ========================================
 * [] File Name : fibonacci_lfsr.v
 *
 * [] Creation Date : 31-03-2015
 *
 * [] Last Modified : Tue, Mar 31, 2015 11:55:05 AM
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
	input enable;
    	input rst;
	output reg [4:0] data;

   	parameter BITS = 5;
	
	reg [4:0] data_next;

	always @* begin
      		data_next = data;
      		repeat(BITS) begin
         		data_next = {(data_next[4]^data_next[1]), data_next[4:1]};
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
