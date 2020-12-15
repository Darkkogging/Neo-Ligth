module Alarma(clk,rx,Hora_actual,sensores,Activada,Sonando,accion,dutty,done,an,sseg,init);

input clk;
input rx;
input [23:0] Hora_actual;
input sensores;
output Activada;
output Sonando;
output [1:0] accion;
output [15:0]dutty;
output done;
output [7:0] an;
output [6:0]sseg;
output reg init=1'b1;

wire[47:0] Ascii;
wire [7:0]dato;
wire DONE;
wire [23:0] Hora_alarma;

reg [27:0] counter; 
reg [6:0] counter2;
reg clk_s;

Uart_rx(clk,rx,init,dato);
Obtener_Ha ob(clk,dato,init,Ascii,DONE);
Ascii2BCD_reloj re(clk,Ascii,Hora_alarma,init,DONE,done);
Alarma_FSM(clk,Hora_actual,Hora_alarma,sensores,Activada,Sonando,accion,dutty);
Display_a(clk,an,Hora_alarma,sseg);


always@(posedge clk)begin //clk con periodo de 1 segundo
	counter=counter+1;
	if(counter<50_000_000)begin
		if(counter<25_000_000)begin
			clk_s=1'b1;
		end
		else begin 
			clk_s=1'b0;
		end
	end
	else begin
		counter=0;
	end

end

always@(posedge clk_s)begin
	counter2=counter2+1;
	
	if(done)begin
		init=0;
	end
	if(!done && !init)begin
		init=1;
	end
	if(counter2==20)begin
		init=0;
		counter2=0;
	end
end

endmodule



