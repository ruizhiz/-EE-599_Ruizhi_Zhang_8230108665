`timescale 1ns/1ps
`include "Odd_even.v"
module top;
	parameter n = 128;
	reg clk;	
	reg reset;
	wire [7:0] out;
	reg [7:0] in ;
	reg en_in;
	wire en_out;
	Odd_even  #(n) u1(in, en_in, clk, reset, out, en_out);
	
	initial begin
		clk = 0;
		forever  begin
			#5 clk = ~clk;
		end
	end
	
	initial begin
		reset = 1;
		en_in <= 0;
		repeat (2) @(posedge clk);
		reset = 0;
		
		repeat (n) begin
			@(posedge clk);
			en_in <= 1;
			in <= $urandom%20;
		end
		@(posedge clk);
		en_in <= 0;
		#2000;
		$finish;
	end
endmodule
			
