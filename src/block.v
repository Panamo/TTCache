module block(enable, write, data_in, data_out);
	
	input enable;
	input write;
	input [0:15] data_in;

	output reg [0:15] data_out;

	reg [0:15] data;

	always @ (enable, write) begin
		if (enable) begin
			if (write)
				data = data_in;
			data_out = data;
		end
	end
endmodule
