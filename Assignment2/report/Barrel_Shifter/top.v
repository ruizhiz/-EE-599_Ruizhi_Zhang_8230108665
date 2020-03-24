module top #(parameter M = 4, parameter N = 2**M) ( input [7:0] a, input [M-1:0] shift, input en_in, input clk, input reset, output [7:0] out_top, output en_out_top);
	reg[8*N-1:0] a_reg;
	reg [M : 0] count;
	reg enable_in;
	reg [7:0] out_reg;
	reg flag;
	wire [N*8-1:0] out;
	reg enable_out;
	assign en_out_top = enable_out;
	assign out_top = out_reg;
	barrel_shefter #(M, N) u1 (a_reg, shift, enable_in, clk, reset, out, en_out);
	
	always @(posedge clk) begin
		if(reset) begin
			a_reg <= 0;
			count <= 0;
			enable_in <= 0;
			out_reg <= 0;
			flag <= 0;
			enable_out <= 0;
		end
		else begin
			enable_in <= 0;
			enable_out <= 0;
			if(en_in == 1 && count < N) begin
				a_reg[8*count +:8] <= a;
				count <= count + 1;
			end
			else if(count == N && flag == 0) begin
				enable_in <= 1;
				flag <= 1;
			end
			if(en_out == 1) begin
				flag <= 1;
				out_reg <= out[7:0];
				enable_out <= 1;
				count <= 1;
			end
			if(flag == 1 && count < N) begin
				out_reg <= out[8*count+:8];
				count <= count + 1;
				enable_out <= 1;
			end
		end
	end
endmodule