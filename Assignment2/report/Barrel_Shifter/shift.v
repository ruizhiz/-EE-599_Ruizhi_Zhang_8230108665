module shift(input[7:0] a, input [7:0] b, input select, output [7:0] c);
	assign c = select? b : a;
endmodule