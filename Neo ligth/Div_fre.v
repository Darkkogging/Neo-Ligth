module Div_fre(clk,clk1kHz);

input clk;
output reg clk1kHz;
reg [15:0] counter;
always@(posedge clk)begin
	if(counter<50_000)begin
		counter=counter+1;
		if(counter<25_000) begin
			clk1kHz=1;
		end
		else begin
			clk1kHz=0;
		end
	end
	else begin
		counter=0;
	end

end
endmodule 