module Ascii2BCD_reloj(clk,Ascii,BCD,init,inicio,done);

input clk;
input [47:0] Ascii;
input inicio;
input init;
output reg done=0;
output  [23:0] BCD;

wire iniciar1;
wire iniciar2;
wire iniciar3;
wire iniciar4;
wire iniciar5;
wire iniciar6;

Ascii2BCD us(clk,Ascii[47:40],init,inicio,iniciar1,BCD[3:0]);
Ascii2BCD ds(clk,Ascii[39:32],init,inicio,iniciar2,BCD[7:4]);
Ascii2BCD um(clk,Ascii[31:24],init,inicio,iniciar3,BCD[11:8]);
Ascii2BCD dm(clk,Ascii[23:16],init,inicio,iniciar4,BCD[15:12]);
Ascii2BCD uh(clk,Ascii[15:8] ,init,inicio,iniciar5,BCD[19:16]);
Ascii2BCD dh(clk,Ascii[7:0]  ,init,inicio,iniciar6,BCD[23:20]);

always@(posedge clk)begin
	if(!init)begin
		done=0;
	end
	
	if(iniciar1 && iniciar2 && iniciar3 && iniciar4 && iniciar5 && iniciar6 )begin
		done=1;
	
	end
	
end


endmodule