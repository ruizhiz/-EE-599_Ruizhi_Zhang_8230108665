module top_top (input clk, input reset, input [7:0] a, input [7:0] b, input en_in, output [7:0] out, output en_out);
	parameter N = 32;
	reg [8*N-1:0] in_a; 
	reg [8*N-1:0] in_b;
	wire [8*N-1:0] out_data;
	reg [N-1:0] count;
	top #(N) top_1 (clk, reset, in_a, in_b, en_in, out_data, en_out);
	
	assign out = out_data[8*count+:8];
	always @(posedge clk) begin
		if(reset) begin
			in_a <= 0;
			in_b <= 0;
			count <= 0;
		end
		else begin
			count <= count + 1;
			in_a[8*count+:8] <= a;
			in_b[8*count+:8] <= b;
		end
	end
endmodule