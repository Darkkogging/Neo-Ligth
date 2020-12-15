module Luz(clk,duty,pwm);

input clk;
input [15:0] duty;	// variable controladora del ancho de pulso rango 0-50_000
output reg pwm;


reg [15:0] counter;  // contador usado para PWM rango 0-50_000

initial begin 
		
	counter=	16'b0;
	
end



always @(posedge clk)begin // PWM 1kHz 
	counter=counter+1;
	if(counter<50_000)begin
		if(counter<duty)begin
			pwm=0;		
		end
		else begin
			pwm=1;
		
		end
		
	end
	else begin
		counter=0;
	end


end








endmodule






