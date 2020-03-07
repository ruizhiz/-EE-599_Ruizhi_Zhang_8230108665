

module Odd_even #(parameter n = 128)
(input [7:0] in, input en_in, input clk, input reset, output [7:0] out, output en_out );
	reg [7:0] data[n-1:0];
	reg [2:0] flag;
	reg [7:0] count;
	reg [7:0] data_out;
	reg en_wr;
	integer i;
	genvar j;
	assign en_out = en_wr;
	assign out = data_out;
	always@(posedge clk) begin
		if(reset) begin 
			flag <= 0;
			count = 0;
			en_wr <= 0;
		end
		else begin
			en_wr <= 0;
			if(count == n && (flag == 1 || flag == 2)) begin
				flag = 3;
				count = 0;
			end
			if(flag == 0 && en_in && count != n) begin
				data[count] <= in;
				count = count + 1;
			end
			else if(flag == 0 && count == n) begin
				count = 0;
				flag <= 1;
			end
			else if(flag == 1)begin
				for(i = 0; i < n-1; i = i + 2) begin
					if(data[i] > data[i+1]) begin
						data[i] <= data[i+1];
						data[i+1] <= data[i];
					end
				end
				flag = 2;
				count = count + 1;
			end
			else if(flag == 2) begin
				for(i = 1; i < n -1; i = i + 2) begin
					if(data[i] > data[i+1]) begin
						data[i] <= data[i+1];
						data[i+1] <= data[i];
					end
				end
				flag = 1;
				count = count + 1;
			end
			if(flag == 3 && count != n) begin
				en_wr <= 1;
				data_out <= data[count];
				count = count + 1;
				
			end
		end
	end
endmodule
				
				