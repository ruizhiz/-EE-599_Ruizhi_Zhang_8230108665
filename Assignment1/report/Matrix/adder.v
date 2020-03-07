module adder(input [7:0] A, input [7:0] B, input clk, input reset, output [7:0] out);
	reg [7:0] result;
	assign out = result;
	always @(posedge clk) begin
		if(reset) begin
			result <= 0;
		end
		else begin
			result <= A + B;
		end
	end
endmodule