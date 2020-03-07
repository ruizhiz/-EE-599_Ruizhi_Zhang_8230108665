`timescale 1ns/1ps
`include "M_multi_1.v"
module top;
	parameter m = 2;
	parameter n = 2**m;
	reg clk;
	reg [7:0] A;
	reg [7:0] B;
	reg en_in;
	wire en_out;
	wire [n*n - 1:0] out;
	reg reset;
	M_multi #(m) u1 (A, B, en_in, clk, reset, out, en_out);
	
	initial begin
		clk = 0;
		forever begin
			#5 clk = ~clk;
		end
	end
	
	initial begin 
		reset = 1;
		en_in <= 0;
		repeat (2) @(posedge clk);
		reset = 0;
		repeat (2**(2*m)) begin
			@(posedge clk);
			en_in <= 1;
			A <= $urandom%10;
			B <= $urandom%10;
		end
		@(posedge clk);
		en_in <= 0;
		#5000;
		$finish;
	end
endmodule