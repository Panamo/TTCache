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
		#5 data_in = 16'b0000_1111_0000_1111;
		#5 write = 1;
		#6 write = 0;
		#100 $stop;
	end
	block blk(enable, write, data_in, data_out);
endmodule
