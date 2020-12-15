module Obtener_Ha(clk,dato,init,hora,DONE);


input clk;
input [7:0] dato;
input init;
output reg DONE=0;
output reg [47:0] hora=48'b001100000011000000110000001100000011000000110000;

reg done;
reg [47:0] dato_leido;
reg status; 
reg recibir;
reg [4:0] done_counter;
reg [27:0] counter;
reg clk1kHz;
parameter ESPERANDO=1'b0, RECIBIR=1'b1;

initial begin

done=0;
dato_leido=0;
status=ESPERANDO;
recibir=0;
done_counter=0;

end



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

always@(posedge clk)begin
	if(!init)begin
		status=ESPERANDO;
	end
	case(status)
		ESPERANDO:begin
			recibir=0;
			if(dato==8'd90 && !DONE)status=RECIBIR;
		end
		RECIBIR:begin 
			recibir=1;
			if(done)status=ESPERANDO;
		end
		default:status=ESPERANDO;
	
	endcase

end


always@(posedge clk1kHz)begin
	if(!init)begin
		dato_leido=48'b0;
		done_counter=5'b0;
		DONE=1'b0;
		done=0;
	end
	if(recibir && init)begin
		if(dato !=8'b0 && dato != 8'd90 && done_counter<6)begin
			dato_leido={dato,dato_leido[47:8]};
			done_counter=done_counter+1;
			done=1;
		end
		if(done_counter==6 && dato==8'd90)begin
			hora=dato_leido;
			DONE=1;
		end
		
	end
	else done=0;

end

 endmodule