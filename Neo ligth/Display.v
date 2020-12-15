module Display(clk,an,dato,sseg);

input clk;
input [31:0] dato;
output reg [7:0] an;
output [6:0] sseg;

reg [3:0] num;
wire clk1kHz;
reg [2:0] selector;



initial begin
	num=4'b1111;
	selector=3'b0;
	
end


bcd2sseg bcdtosseg(num,sseg);
Div_fre div(clk,clk1kHz);



always@(posedge clk1kHz)begin

	case(selector)
		3'b000:begin num=dato[3:0]; 	an=8'b11111110; end	
		3'b001:begin num=dato[7:4]; 	an=8'b11111101; end
		3'b010:begin num=dato[11:8]; 	an=8'b11111011; end
		3'b011:begin num=dato[15:12]; an=8'b11110111; end
		3'b100:begin num=dato[19:16]; an=8'b11101111; end
		3'b101:begin num=dato[23:20]; an=8'b11011111; end
		3'b110:begin num=dato[27:24]; an=8'b11111111; end
		3'b111:begin num=dato[31:28]; an=8'b11111111; end
	
	
	
	endcase
	selector=selector+1;
	

end






endmodule