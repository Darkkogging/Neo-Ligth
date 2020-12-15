module Neo_Ligth(clk,rx,piro,eco,pwm_L,pwm_M,ubicacion,direccion,an,sseg,done,Activada,trigger,Numero_p);
input clk;
input rx;
input piro;
input eco;


output pwm_L;
output pwm_M;
output ubicacion;
output [1:0] direccion;
output  [7:0] an;
output   [6:0] sseg;
output reg done=1'b0;
output Activada;
output trigger;

wire sensores;
output reg [4:0] Numero_p;
reg init_a;
reg  init_Time=1'b1;
reg [27:0] counter;
reg clk_s;
reg Sonando;
wire init_c;
wire [1:0] accion;
wire [1:0]accion_c;
wire [1:0] accion_a;
wire [15:0] dutty;
wire [15:0]dutty_c;
wire [15:0] dutty_a;
wire [23:0] hora;
reg done_a;
wire [7:0]an_a;
wire [7:0]an_t;
wire [6:0] sseg_a;
wire [6:0] sseg_t;

assign an= (done_a==1) ?an_a:an_t;
assign sseg= (done_a==1) ?sseg_a:sseg_t;
assign init_c= (Sonando==1)? 0:1;
assign dutty=(Sonando==1)?dutty_a:dutty_c;
assign accion=(Sonando==1)?accion_a:accion_c;
assign sensores=(Numero_p<1)?1:0;


Time(clk,init_Time,rx,done,an_t,sseg_t,hora);
Control (clk,rx,init_c,accion_c,dutty_c,ubicacion);
Cortina (clk,accion,direccion,pwm_M);
Luz (clk,dutty,pwm_L);
Alarma(clk,rx,hora,sensores,Activada,Sonando,accion_a,dutty_a,done_a,an_a,sseg_a,init_a);
Contador_aforo(clk,piro,eco,trigger,Numero_p);


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
	if(done)begin
		init_Time=0;
	end
	
	
end




endmodule