module pipe(f,a,b,c,d,clk);
parameter n=8;
output [n-1:0]f;
input clk;
input [n-1:0]a,b,c,d;
reg [n-1:0] l12_x1,l12_x2,l12_d,l23_x3,l23_d,l34_f;
assign f=l34_f;
always@(posedge clk)
begin
	l12_x1<= #4 a+b;
	l12_x2<= #4 c-d;
	l12_d<=d;
/*end

always@(posedge clk)
begin */
	l23_x3<= #4 l12_x1+l12_x2;
	l23_d<=l12_d;
/*end 

always@(posedge clk)
begin */
	l34_f<= #6 l23_x3*l23_d;
	
end  

endmodule

