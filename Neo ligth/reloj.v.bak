module Reloj(clk,init,hora_in,hora_out);

input clk;
input init;
input [23:0] hora_in;
output reg [23:0] hora_out;

reg [25:0] counter;
reg [3:0] us;
reg [3:0] ds;
reg [3:0] um;
reg [3:0] dm;
reg [3:0] uh;
reg [3:0] dh;
reg status;
reg configurando;
reg clk_s;
parameter CONFIGURAR=1'b0,CONTEO=1'b1;

initial begin
counter=26'b0;
us=4'b0;
ds=4'b0;
um=4'b0;
dm=4'b0;
uh=4'b0;
dh=4'b0;
status=CONFIGURAR;
configurando=1'b0;
clk_s=1'b0;
end


always@(posedge clk)begin //maquina de estados
	case(status)
		CONFIGURAR:begin
			configurando=1'b1;
			if(!init)begin
				status=CONTEO;
			end
		
		end
		CONTEO:begin
			configurando=1'b0;
			if(init)begin
				status=CONFIGURAR;
			end
		
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


always@(posedge clk_s)begin //estado CONTEO
	if(!configurando)begin
		us=us+1;
		if(us==10)begin
			us=0;
			ds=ds+1;
		end
		if(ds==6)begin
			ds=0;
			um=um+1;
		end
		if(um==10)begin
			um=0;
			dm=dm+1;
		end
		if(dm==6)begin
			dm=0;
			uh=uh+1;
		end
		if(uh==10)begin
			uh=0;
			dh=dh+1;
		end
		if(dh==2 && uh==4)begin
			uh=0;
			dh=0;
		end
		hora_out= {dh[3:0],uh[3:0],dm[3:0],um[3:0],ds[3:0],us[3:0]};
			
	end
	else begin
		hora_out=24'b111111111111111111111111;
		us=hora_in[3:0];
		ds=hora_in[7:4];
		um=hora_in[11:8];
		dm=hora_in[15:12];
		uh=hora_in[19:16];
		dh=hora_in[23:20];
	end



end

endmodule
