module Ascii2BCD(clk,Ascii,init,inicio,done,BCD);

input clk;
input [7:0] Ascii;
input inicio;
input init;
output reg done=0;
output reg [3:0] BCD;

always @(posedge clk)begin
	if(!init)begin
		done=0;
	end
	
	if(inicio && init)begin
		case(Ascii)
		8'd48:begin BCD=4'd0; done=1; end
		8'd49:begin BCD=4'd1; done=1; end
		8'd50:begin BCD=4'd2; done=1; end
		8'd51:begin BCD=4'd3; done=1; end
		8'd52:begin BCD=4'd4; done=1; end
		8'd53:begin BCD=4'd5; done=1; end
		8'd54:begin BCD=4'd6; done=1; end
		8'd55:begin BCD=4'd7; done=1; end
		8'd56:begin BCD=4'd8; done=1; end
		8'd57:begin BCD=4'd9; done=1; end
		8'd0:begin BCD=4'd10; done=1; end
		default:begin BCD=4'b1111;done=1;end
		
		endcase
	end
	
end 

endmodule