module pipeb(z,rs1,rs2,rd,f,addr,clk1,clk2);
parameter n=16;
parameter m=3;
parameter adr=8;
parameter fun=3;
output [n-1:0]z;
input clk1,clk2;
input [adr-1:0]addr;
input [fun-1:0]f;
input [m-1:0]rs1,rs2,rd;
reg [n-1:0]regb[0:15];
reg [n-1:0]mem[0:255];
reg [n-1:0]a,b,l23_z,l34_z,l12_rd,l23_rd;
reg [fun-1:0]l12_f;
reg [adr-1:0]l12_addr,l23_addr,l34_addr;
assign z=l34_z;
always@(posedge clk1)
begin 
	a<=#2 regb[rs1];
	b<=#2 regb[rs2];
	l12_rd<=#2 rd;
	l12_f<=#2 f;
	l12_addr<=#2 addr;
end

always@(posedge clk2)
begin
case(l12_f)
	000:l23_z<=#2 a+b;
	001:l23_z<=#2 a-b;
	010:l23_z<=#2 a*b;
	011:l23_z<=#2 a&b;
	100:l23_z<=#2 a|b;
	101:l23_z<=#2 a^b;
	110:l23_z<=#2 ~a;
	111:l23_z<=#2 ~b;
	default:l23_z<=#2 16'dx;
endcase
	l23_rd<=#2 l12_rd;
	l23_addr<=#2 l12_addr;
end

always@(posedge clk1)
begin 
	regb[l23_rd]<=#2 l23_z;
	l34_z<=#2 l23_z;
	l34_addr<=#2 l23_addr;
end

always@(posedge clk2)
begin 
	mem[l34_addr]<=#2 l34_z;

end

endmodule


