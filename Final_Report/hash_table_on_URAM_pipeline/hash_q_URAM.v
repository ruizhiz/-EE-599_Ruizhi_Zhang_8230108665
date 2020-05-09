module hash_q_URAM #(parameter KEY_WIDTH = 32, parameter INDEX_WIDTH = 12) (output [INDEX_WIDTH*KEY_WIDTH - 1:0] hash_q_out);

	wire [20-1:0] hash [63:0];
	
//-------------initial hash_q-------------//
	assign  hash[0]  = 20'b00001010010000100011;
	assign	hash[1]  = 20'b00101111101110000100;
	assign	hash[2]  = 20'b10111000010101101100;
	assign	hash[3]  = 20'b00110101101010101110;
	assign	hash[4]  = 20'b01010100101110010000;
	assign	hash[5]  = 20'b10010010010111110001;
	assign	hash[6]  = 20'b10111100010110111011;
	assign	hash[7]  = 20'b10111010010111101011;
	assign	hash[8]  = 20'b11101100111010100110;
	assign	hash[9]  = 20'b10110110110100111100;
	assign	hash[10] = 20'b10100001110100001100;
	assign	hash[11] = 20'b11001111100010011001;
	assign	hash[12] = 20'b01001001000001011110;
	assign	hash[13] = 20'b00000011010100011100;
	assign	hash[14] = 20'b01000001100110110111;
	assign	hash[15] = 20'b01010001110011011110;
	assign	hash[16] = 20'b01101100110100010010;
	assign  hash[17] = 20'b11010011010111001000;
	assign	hash[18] = 20'b00010000111010111011;
	assign	hash[19] = 20'b10100010111010100110;
	assign	hash[20] = 20'b00000111110100000011;
	assign	hash[21] = 20'b10010110101001111101;
	assign	hash[22] = 20'b01000010011000111000;
	assign	hash[23] = 20'b11001001011000011111;
	assign	hash[24] = 20'b10010111011011010100;
	assign	hash[25] = 20'b11110010111111111100;
	assign	hash[26] = 20'b11100101101111110101;
	assign	hash[27] = 20'b10010001011000111011;
	assign	hash[28] = 20'b10000100111000001101;
	assign	hash[29] = 20'b11100010011100001010;
	assign	hash[30] = 20'b00000111001111011011;
	assign	hash[31] = 20'b10101011101100110010;
	
	assign  hash[32] = 20'b01001000000110011010;
	assign	hash[33] = 20'b11010100001011101110;
	assign	hash[34] = 20'b11010000000001111000;
	assign	hash[35] = 20'b11001101100011111101;
	assign	hash[36] = 20'b10000100101001001001;
	assign	hash[37] = 20'b11001100101111110110;
	assign	hash[38] = 20'b10100111100101111101;
	assign	hash[39] = 20'b11010010010111011100;
	assign	hash[40] = 20'b00101011010101001111;
	assign	hash[41] = 20'b10000101000111110010;
	assign	hash[42] = 20'b01010001001001000000;
	assign	hash[43] = 20'b11011001100011010000;
	assign	hash[44] = 20'b10011010111011000100;
	assign	hash[45] = 20'b10001100001010110111;
	assign	hash[46] = 20'b00001100100000111011;
	assign	hash[47] = 20'b01101000010000100010;
	assign	hash[48] = 20'b10111101100000100010;
	assign 	hash[49] = 20'b01100100010010011101;
	assign	hash[50] = 20'b10111000010110001011;
	assign	hash[51] = 20'b10000111111111011010;
	assign	hash[52] = 20'b00101100001011001010;
	assign	hash[53] = 20'b10100110010100000010;
	assign	hash[54] = 20'b11101110011101110010;
	assign	hash[55] = 20'b11100111010001001001;
	assign	hash[56] = 20'b01001011001010000000;
	assign	hash[57] = 20'b00011111101011000101;
	assign	hash[58] = 20'b00100110010011010101;
	assign	hash[59] = 20'b11111010010010000000;
	assign	hash[60] = 20'b01101100101111101010;
	assign	hash[61] = 20'b11110010010011001100;
	assign	hash[62] = 20'b11010100110010111111;
	assign	hash[63] = 20'b00011001110011010110;


//-------------assign output-------------//
	genvar i;
	
	generate 
	for( i = 0; i < KEY_WIDTH; i = i + 1) begin
		assign hash_q_out[INDEX_WIDTH*i+:INDEX_WIDTH] = hash[i][INDEX_WIDTH-1:0];
	end
	endgenerate
endmodule