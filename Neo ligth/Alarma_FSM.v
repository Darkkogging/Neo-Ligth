module Alarma_FSM(clk,Hora_actual,Hora_alarma,sensores,Activada,Sonando,accion,dutty);

input clk;
input [23:0] Hora_actual;
input [23:0] Hora_alarma;
input sensores;
output reg Activada;
output reg Sonando;
output reg [1:0] accion;
output reg [15:0] dutty;

reg [1:0] status;
reg act;
reg des;
reg son;


reg [27:0] counter; 
reg clk_s;
reg [11:0] counter2;

parameter DESACTIVADA=2'b00,ACTIVADA=2'b01,SONANDO=2'b10;

always@(posedge clk)begin //maquina de estados 
	case(status)
		DESACTIVADA:begin 
			act=1'b0;
			des=1'b1;
			son=1'b0;
			if(Hora_alarma[3:0]==4'b0001) status=ACTIVADA;
			
		end
		ACTIVADA:begin 
			act=1'b1;
			des=1'b0;
			son=1'b0;
			if(Hora_alarma[3:0]==4'b0000) status=DESACTIVADA;
			if(Hora_actual==Hora_alarma) status=SONANDO;
		end
		SONANDO:begin 
			act=1'b0;
			des=1'b0;
			son=1'b1;
			if(sensores) status=ACTIVADA;
			
		end
	endcase
end

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

always@(posedge clk_s)begin //estado activada
	if(act)begin
		Activada=1'b1;
	end
	else begin
		Activada=1'b0;
	end
	
end


always@(posedge clk_s)begin //estado sonando
	if(son)begin
		Sonando=1'b1;
		counter2=counter2+1;
		accion=2'b00;
		case(counter2)
			12'd1:begin dutty=16'd2000; accion=2'b10 ;end
			12'd10:begin dutty=16'd6000; accion=2'b10 ;end
			12'd20:begin dutty=16'd12000; accion=2'b10 ;end
			12'd30:begin dutty=16'd18000; accion=2'b10 ;end
			12'd40:begin dutty=16'd24000; accion=2'b10 ;end
			12'd50:begin dutty=16'd36000; accion=2'b10 ;end
			12'd60:begin dutty=16'd40000; accion=2'b10 ;end
			12'd70:begin dutty=16'd50000; accion=2'b10 ;end
		endcase
	end
	
	else begin
		Sonando=1'b0;
		counter2=0;
		dutty=2'b00;
		accion=2'b00;
	end
	

end
endmodule
