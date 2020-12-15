module bcd2sseg(BCD,Sseg);

input  [3:0] BCD;
output reg [6:0] Sseg;


always @(*)begin

	case(BCD)
	
	4'b0000: Sseg=7'b1000000; //0
	4'b0001: Sseg=7'b1111001; //1
	4'b0010: Sseg=7'b0100100; //2
	4'b0011: Sseg=7'b0110000; //3
	4'b0100: Sseg=7'b0011001; //4
	4'b0101: Sseg=7'b0010010; //5
	4'b0110: Sseg=7'b0000010; //6
	4'b0111: Sseg=7'b1111000; //7
	4'b1000: Sseg=7'b0000000; //8
	4'b1001: Sseg=7'b0011000; //9
	4'b1010: Sseg=7'b0001000; //A
	4'b1011: Sseg=7'b1000111; //L
	
	default: Sseg=7'b0111111;
	
	endcase

end


endmodule
