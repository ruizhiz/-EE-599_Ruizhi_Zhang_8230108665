module tb;
	parameter N = 16;
	reg clk, reset;
	reg [8*N - 1:0] in_a; 
	reg [8*N - 1:0] in_b;
	reg en_in;
	wire [8*N - 1 : 0] out;
	wire en_out;
	integer i, j;
	top #(N) top_1 (clk, reset, in_a, in_b, en_in, out, en_out);
	
	initial begin
		clk = 1;
		forever begin 
			#5;
			clk = ~clk;
		end
	end
	
	initial begin
		reset <= 1;
		in_a <= 0;
		in_b <= 0;
		repeat (2) @(posedge clk);
		reset <= 0;
		en_in <= 0;
		for(i = 1; i < N; i = i + 1) begin
			for( j = 0; j < i; j = j + 1) begin
				in_b[8*j+:8] <= $urandom%(10);
				in_a[8*j+:8] <= $urandom%(10);
			end
			@(posedge clk);
		end
		for(i = 1; i < N; i = i + 1) begin
			for( j = i; j < N; j = j + 1) begin
				in_b[8*j+:8] <= $urandom%(10);
				in_a[8*j+:8] <= $urandom%(10);
			end
			for( j = 0; j < i; j = j + 1) begin
				in_b[8*j+:8] <= 0;
				in_a[8*j+:8] <= 0;
			end
			@(posedge clk);
		end
		in_a <= 0;
		in_b <= 0;
		en_in <= 1;
		@(posedge clk);
		en_in <= 0;
		/* in_a[7 : 0] <= $urandom%(20);
		in_b[7 : 0] <= $urandom%(20);
		@(posedge clk);
		for( i = 0; i < 2; i = i + 1) begin
			in_b[8*i + : 8] <= $urandom%(20);
			in_a[8*i + : 8] <= $urandom%(20);
		end
		@(posedge clk);
		for( i = 0; i < 3; i = i + 1) begin
			in_b[8*i + : 8] <= $urandom%(20);
			in_a[8*i + : 8] <= $urandom%(20);
		end
		@(posedge clk);
		in_a[7 : 0] <= 0;
		in_b[7 : 0] <= 0;
		for( i = 1; i < 3; i = i + 1) begin
			in_b[8*i + : 8] <= $urandom%(20);
			in_a[8*i + : 8] <= $urandom%(20);
		end
		@(posedge clk);
		for( i = 2; i < 3; i = i + 1) begin
			in_b[8*i + : 8] <= $urandom%(20);
			in_a[8*i + : 8] <= $urandom%(20);
		end
		for( i = 0; i < 2; i = i + 1) begin
			in_b[8*i + : 8] <= 0;
			in_a[8*i + : 8] <= 0;
		end
		en_in <= 1;
		@(posedge clk);
		for( i = 0; i < 3; i = i + 1) begin
			in_b[8*i + : 8] <= 0;
			in_a[8*i + : 8] <= 0;
		end */
		
		repeat (70) @(posedge clk);
		$finish;
	end
endmodule
	