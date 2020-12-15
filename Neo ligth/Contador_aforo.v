module Contador_aforo(clk,piro,eco,trigger,Numero_p);
input clk;
input piro;
input eco;
output trigger;
output reg [4:0] Numero_p=1;

reg  interferencia;
reg [27:0] counter;
reg clk_s;
reg [2:0] status;
reg us;
reg pir;
reg res;
reg add;
reg [2:0] counter_s;
reg [2:0] counter_s1;

parameter ESPERANDO=3'b000,ULTRA_SONICO=3'b001,PIR=3'b010,RES=3'b011,ADD=3'b100;

Sensor_ultrasonico(clk,trigger,eco, interferencia);

initial begin
counter=28'b0;
clk_s=1'b0;
status=ESPERANDO;
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

always@(posedge clk)begin //maquina de estados
	case(status)
		ESPERANDO:begin
			us=1'b0;
			pir=1'b0;
			res=1'b0;
			add=1'b0;
			if(interferencia)status=ULTRA_SONICO;
			if(piro)status=PIR;
		end
		ULTRA_SONICO:begin
			us=1'b1;
			pir=1'b0;
			res=1'b0;
			add=1'b0;
			if(piro)status=RES;
			if(counter_s==3)status=ESPERANDO;
			
		end
		PIR:begin
			us=1'b0;
			pir=1'b1;
			res=1'b0;
			add=1'b0;
			if(interferencia)status=ADD;
			if(counter_s==4)status=ESPERANDO;
		end
		ADD:begin
			us=1'b0;
			pir=1'b0;
			res=1'b0;
			add=1'b1;
			if(counter_s1==3)status=ESPERANDO;
		end
		RES:begin
			us=1'b0;
			pir=1'b0;
			res=1'b1;
			add=1'b0;
			if(counter_s1==3)status=ESPERANDO;
		end
	endcase

end

always@(posedge clk_s)begin
	
	if(us || pir)begin
	 counter_s=counter_s+1;
	 
	end
	else begin
		counter_s=0;
	end

end


always@(posedge clk_s)begin
	
	if(add || res)begin
	 counter_s1=counter_s1+1;
	 if(add && counter_s1==1)begin
		Numero_p=Numero_p+1;
	 end
	 if(res && counter_s1==1 )begin
		Numero_p=Numero_p-1;
	 end
	end
	else begin
		counter_s1=0;
	end
	
end

endmodule

