`include "MulandAddTree.v"


module M_multi #(parameter m = 5, parameter n = 2**m)
	(input [7:0] A_in, input [7 : 0] B_in, input en_in, input clk, input reset, output [7:0] out, output en_out);
//	reg [7:0] data_out;
	reg [n*n*8 - 1:0] A;
	reg [n*n*8 -1 : 0] B;
	reg [m + 2:0]wr_out;
	reg flag;
	assign en_out = wr_out[m + 2];
//	assign out = data_out;
//	wire [7:0] out;
	MulandAddTree #(m, n) u_MA
	(clk, reset, A, B, wr_out[0], out);
	reg [2*m:0] count;
	integer i;
	always @(posedge clk) begin
		if(reset) begin
			A <= 0;
			B <= 0;
			flag <= 0;
			wr_out <= 0;
			count = 0;
		end
		else begin
			wr_out[0] <= 0;
			for( i = 0; i < m + 2; i = i + 1) begin
				wr_out[i+1] <= wr_out[i];
			end
			if(en_in == 1 && count != n*n) begin
				A[count*8 + : 8] <= A_in;
				B[count* 8 +: 8] <= B_in;
				count = count + 1;
			end
			else if(count == n*n) begin 
				flag <= 1;
			end
			if(flag == 1 && count > 0) begin
				wr_out[0] <= 1;
				count = count -1;
			end
		end
	end
endmodule