module Uart_rx(clk,rx,init,dato);

input clk;
input rx;
input init;
output reg [7:0] dato=8'b0;
 

 
parameter ESPERA=1'b0, RECIBIR=1'b1;
reg status;
reg iniciar;
reg [8:0] contador;
reg tick;
reg [4:0] ct;
reg bit_start; 
reg [3:0] numero_bits;
reg [7:0] dato_leido;
reg done;

initial begin
	status=ESPERA;
	done=1'b0;
	iniciar=1'b0;
	contador=9'b0;
	ct=5'b0;
	tick=1'b0;
	bit_start=1'b1;
	numero_bits=4'b0;
	dato_leido=8'b0;
	
end	

always@(posedge clk)begin

	case (status)
		ESPERA: begin
			iniciar=0;
			if((!rx && !done))begin
				status=RECIBIR;
			end
		end
		RECIBIR: begin
			iniciar=1;
			if(done && rx)begin
				status=ESPERA;
			end
		end
	
	endcase

end


always@(posedge clk)begin //divisor de frecuencia tick
	
	if(contador<163)begin
		contador=contador+1;
	end
	else begin
		contador=9'b0;
		tick=!tick;
	end
end

always@(posedge tick)begin
	if(!init)begin
		dato=0;
	end
	
	if(iniciar && init)begin
		ct=ct+1;
		if((ct==8) && bit_start)begin
			bit_start=1'b0;
			ct=0;
		end
		if((ct==16) && (!bit_start) && numero_bits<9)begin
			dato_leido= {rx,dato_leido[7:1]};
			numero_bits=numero_bits+1;
			ct=0;
		end
		if(numero_bits==8 && ct==8 && rx )begin
			bit_start=1'b1;
			ct=1'b0;
			done=1'b1;
			numero_bits=4'b0;
			dato=dato_leido;
			dato_leido=8'b0;
			
		end
	
	end
	else begin
		done=0;
	end
	


end




endmodule 