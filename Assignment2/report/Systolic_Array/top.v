module top #(parameter N = 32) (input clk, input reset, input [8*N-1:0] in_a, input [8*N-1:0] in_b, input en_in, output [8*N-1:0] out_data, output en_out);
	
	genvar i, j;
	integer k;
	wire [7:0] b_connect [(N+1)*N - 1:0];
	wire [7:0] a_connect [(N+1)*N - 1:0];
	wire [8*N*N - 1: 0] out;
	reg [3*N - 2:0] en;
	reg en_out_reg;	
	reg [N-1:0] count;
	assign en_out = en_out_reg;
	assign out_data = out[8*N*count+:8*N];

	generate 
	for(i = 0; i < N; i = i + 1) begin
		assign a_connect[i] = in_a[i*8+:8];
		assign b_connect[i] = in_b[i*8+:8];
	end
	endgenerate
	generate 
	for(i = 0; i < N; i = i + 1) begin
		for(j = 0; j < N; j = j + 1) begin
			unit unit0 (a_connect[j*N + i], b_connect[i*N + j], clk, reset, a_connect[(j+1)*N +i], b_connect[(i+1)*N + j], out[8*(i*N + j)+:8]);
		end
	end
	endgenerate
	always @(posedge clk) begin
		if(reset) begin
			en <= 0;
			count <= 0;
			en_out_reg<= 0;
		end
		else begin
			en[0] <= en_in;
			for(k = 1; k <= 3*N-2; k = k + 1) begin
				en[k] <= en[k-1];
			end
			if(en[3*N-2] == 1) begin
				count <= 0;
				en_out_reg <= 1;
			end
			if(en_out_reg == 1 && count < N-1 ) begin
				count <= count + 1;
			end
			if(en_out_reg == 1 && count == N-1) begin
				en_out_reg <= 0;
			end
			
			
			
			
		end
		
		
		
	end
	
endmodule
			