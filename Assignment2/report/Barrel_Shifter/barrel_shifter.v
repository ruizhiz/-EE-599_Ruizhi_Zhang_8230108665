module barrel_shefter #(parameter M = 4, parameter N = 2**M) (input [8*N-1:0] a, input [M-1:0] shift, input en_in, input clk, input reset, output [N*8-1:0] out, output en_out);
	genvar i;
	integer j, k;
	reg [M-1:0] en;
	wire [8*N-1:0] out_reg[M-1:0];
	reg [(M-1)*M/2 -1: 0]  shift_reg;
	stage #(N, 1) u0 (a, clk, shift[0], reset, out_reg[0]);
	generate 
	for(i = 1; i < M; i = i + 1) begin
		stage #(N, 2**i) u1 (out_reg[i-1], clk, shift_reg[(i+1)*i/2-1], reset, out_reg[i]);
	end
	endgenerate
	assign out = out_reg[M-1];
	assign en_out = en[M-1];
	always@(posedge clk) begin
		if(reset) begin
			en <= 0;
			shift_reg <= 0;
		end
		else begin
			for( j = 1; j < M; j = j+1) begin
				shift_reg[(j-1)*j/2] <= shift[j];
			end
			for(j = 2; j < M; j = j + 1) begin
				for(k = 1; k < j; k = k + 1) begin
					shift_reg[(j-1)*j/2 + k] <= shift_reg[(j-1)*j/2 +k - 1];
				end
			end
			en[0] <= en_in;
			for(j = 1; j < M; j= j+1) begin
				en[j] <= en[j-1];
			end
			
		end
	end
endmodule