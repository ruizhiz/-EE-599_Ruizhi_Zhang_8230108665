module stage #(parameter N = 16, parameter shift_bit = 1) ( input [8*N-1:0] a, input clk, input en, input reset, output [8*N-1:0] c);
	reg [8*N-1:0] c_reg;
	wire [7:0] out_wire [N-1:0];
	genvar j;
	integer i;
	generate 
	for( j = 0; j < N; j = j + 1) begin
		shift u0 (a[8*j +:8], a[8*((j+N-shift_bit)%N)+:8], en,  out_wire[j]);
	end
	endgenerate 
	assign c = c_reg;
	always @(posedge clk) begin
		if(reset) begin
			c_reg <= 0;
		end
		else begin
			for(i = 0; i < N; i = i + 1) begin
				c_reg[8*i+:8] <= out_wire[i];
			end
		end
	end
endmodule