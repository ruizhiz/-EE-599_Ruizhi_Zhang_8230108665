module tb;
	reg clk;
	parameter M = 4;
	parameter N = 2**M;
	reg [8*N-1:0]a_in;
	reg [M-1:0] shift;
	reg en_in_top;
	reg reset;
	wire [8*N-1:0] out;
	wire en_out_top;
	integer i;
	barrel_shifter #(M) top_1  (a_in, shift, en_in_top, clk, reset, out, en_out_top);
	
	initial begin
		clk <= 1;
		forever begin
			#5; 
			clk <= ~clk;
		end
	end
	initial begin
		reset <= 1;
		en_in_top <= 1;
		repeat (2) @(posedge clk);
		reset <= 0;
		shift <= $urandom%(2**M - 1);
		en_in_top <= 1;
		repeat (5) begin
			for(i = 0; i < N; i = i + 1) begin
				a_in[8*i+:8] <= $urandom%(2**8 - 1);			
			end
			@(posedge clk);
		end
		@(posedge clk);
		en_in_top <= 0;
		repeat (40) @(posedge clk);
		$finish;
	end
endmodule