module Time(clk,init,rx,done,an,sseg,hora);

input clk;
input init;
input rx;
output done;
output [7:0] an;
output [6:0]sseg;
output  [23:0] hora;

wire [23:0] hora_out;
wire[47:0] Ascii;
wire [23:0] hora_in;
wire [7:0 ]dato;
wire DONE;

Uart_rx(clk,rx,init,dato);
Obtener_H ob(clk,dato,init,Ascii,DONE);
Ascii2BCD_reloj re(clk,Ascii,hora_in,init,DONE,done);
Reloj se(clk,init,hora_in,hora_out);
Display(clk,an,hora_out,sseg);
assign hora=hora_out;


endmodule