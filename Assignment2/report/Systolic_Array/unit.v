module unit (input [7:0] in_a, input [7:0] in_b, input clk, input reset, output [7:0] out_a, output [7:0] out_b, output [7:0] out_c);
	reg [7:0] a;
	reg	[7:0] b;
	reg [7:0] c;
	wire [7:0] multi_out;
	wire [7:0] adder_out;
	multi m1 (in_a, in_b, multi_out);
	add a1 (c, multi_out, adder_out);
	assign out_a = a;
	assign out_b = b;
	assign out_c = c;
	always @(posedge clk) begin
		if(reset) begin
			a <= 0;
			b<= 0;
			c <= 0;
		end
		else begin 
			a <= in_a;
			b <= in_b;
			c <= adder_out;
		end
	end
endmodule