module t_pipe();
parameter n=8;
wire [n-1:0]f;
reg clk;
reg [n-1:0]a,b,c,d;
pipe dut(f,a,b,c,d,clk);
initial clk=1'b0;
always #5 clk=~clk;

initial 
begin
	#50 a=7'd5;
	   b=7'd7;
	   c=7'd12;
	   d=7'd2;

	#50 a=7'd5;
	   b=7'd4;
	   c=7'd15;
	   d=7'd5;

	#50 a=7'd1;
	   b=7'd2;
	   c=7'd4;
	   d=7'd3;
end

initial 
begin
	$monitor($time,"F=%d",f);
	#600 $finish;
end
endmodule


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

	l23_x3<= #4 l12_x1+l12_x2;
	l23_d<=l12_d;

	l34_f<= #6 l23_x3*l23_d;
	
end  

endmodule

