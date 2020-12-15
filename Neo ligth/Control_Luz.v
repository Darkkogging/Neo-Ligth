module Control_Luz(clk,init,dato,dutty);

input clk;
input init;
input [7:0] dato;
output reg [15:0]dutty=16'b0;

always@(posedge clk)begin
	if(init)begin
		case(dato)
			8'd97:begin dutty=16'd0; end //a
			8'd98:begin dutty=16'd2000; end //b
			8'd99:begin dutty=16'd4000; end //c
			8'd100:begin dutty=16'd6000; end //d
			8'd101:begin dutty=16'd8000; end //e
			8'd102:begin dutty=16'd10000; end //f
			8'd103:begin dutty=16'd12000; end //g
			8'd104:begin dutty=16'd14000; end //h
			8'd105:begin dutty=16'd16000; end //i
			8'd106:begin dutty=16'd18000; end //j
			8'd107:begin dutty=16'd20000; end //k
			8'd108:begin dutty=16'd22000; end //l
			8'd109:begin dutty=16'd24000; end //m
			8'd110:begin dutty=16'd26000; end //n
			8'd111:begin dutty=16'd28000; end //o
			8'd112:begin dutty=16'd30000; end //p
			8'd113:begin dutty=16'd32000; end //q
			8'd114:begin dutty=16'd34000; end //r
			8'd115:begin dutty=16'd36000; end //s
			8'd116:begin dutty=16'd38000; end //t
			8'd117:begin dutty=16'd40000; end //u
			8'd118:begin dutty=16'd42000; end //v
			8'd119:begin dutty=16'd44000; end //w
			8'd120:begin dutty=16'd46000; end //x
			8'd121:begin dutty=16'd50000; end //y
		endcase
	end
end


endmodule
