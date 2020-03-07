`include "multiply.v"
`include "adder.v"

module MulandAddTree #(parameter m = 2, parameter n = 2**m)
	(input clk, input reset, input [n*n*8 - 1:0] A, input [n*n*8 - 1:0] B, input en, output [7:0] out);
	
	wire [7:0] M_result [n-1:0];
	wire [7:0] A_result [n-2:0];
//	reg [7:0] multi [n-1:0];
//	reg [7:0] add [n-2:0];
	genvar i;
	integer j;
	reg [2*m:0] count;
	wire [n*8-1:0] A_in;
	wire [n*8-1:0] B_in;
	assign A_in = A[count[2*m-1: m]*n*8 +: n*8];
	assign B_in = B[count[m-1:0]*n*8 + : n*8];
	generate 
		for(i = 0; i < n; i = i + 1) begin
			multiply u0 (A_in[i*8 +: 8], B_in[i*8 + : 8], clk, reset, M_result[i]);
		end
	endgenerate
	generate
		for(i = 0; i < n - 1; i = i + 2) begin
			adder a0 (M_result[i], M_result[i+1], clk, reset, A_result[i/2]);
		end	
		for(i = 0; i < n - 2; i = i + 2) begin
			adder b0 (A_result[i], A_result[i+1], clk, reset, A_result[n/2 + i/2]);
	//		adder b0 (add[i], add[i+1], clk, reset, A_result[n/2 + i/2]);
		end
	endgenerate
	
//	assign out = add[n-2];
	assign out = A_result[n-2];
	
	always @(posedge clk) begin
		if(reset) begin
//			A_in <= 0;
//			B_in <= 0;
			count <= 0;
//			for(j = 0; j < n; j = j+1) begin
//				multi[j] <= 0;
//			end
	//		for(j = 0; j < n - 1; j = j + 1) begin
	//			add[j] <= 0;
	//		end
		end
		else begin 
		
			if(en == 1) begin
				count <= count + 1;
//				A_in <= A[count[2*m-1: m]*n*8 +: n*8];
//				B_in <= B[count[m-1:0]*n*8 + : n*8];
			end 
			else begin
	//			A_in <= 0;
//				B_in <= 0;
			end
//			for(j = 0; j < n; j = j+1) begin
//				multi[j] <= M_result[j];
//			end
//			for(j = 0; j < n - 1; j = j + 1) begin
//				add[j] <= A_result[j];
//			end
		
		end
	end
	
	
endmodule