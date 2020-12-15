module Control(clk,rx,init,accion,dutty,ubicacion);

input clk;
input rx;
input init;
output [1:0] accion;
output [15:0] dutty; 
output ubicacion;
wire [7:0] dato;

Uart_rx dat_con(clk,rx,init,dato);
Control_Motor M(clk,dato,init,accion,ubicacion);
Control_Luz L(clk,init,dato,dutty);


endmodule