module t_v();

wire pro;
wire [4:0] r_cng;
reg [4:0] money;
reg clk,rst,dne;
reg [1:0] product;

v dut(pro,r_cng,clk,rst,dne,money,product);

always #5 clk= ~clk;

initial
 begin
	clk=1'b1;
	rst=1'b1;
      #10 rst=1'b0;
	  dne=1'b0;
	
    #10 money=5'b00101;
	product=2'b00;
	dne=1'b1;
	
    #20 money=5'b00101;
	product=2'b10;
	dne=1'b0;
    #10 money=5'b01010;
	dne=1'b1;
	
    #20 money=5'b00101;
	product=2'b11;
	dne=1'b0;
    #10 money=5'b01010;
	dne=1'b0;
    #10 money=5'b01010;
	dne=1'b1;
 end

initial
 begin
  $monitor($time,"Product=%2d,Rem_change=%2d",pro,r_cng);
  #200 $finish;
 end

endmodule

module v(pro,r_cng,clk,rst,dne,money,product);
output reg pro;
output reg [4:0] r_cng;
input [4:0] money;
input clk,rst,dne;
input [1:0] product;

reg st,nst;
reg [1:0] prd;
reg[4:0] mny,i_mny,cst,cng;


always@(posedge clk or posedge rst)
begin
if(rst)
 begin
  pro<=1'b0;
  r_cng<=5'd0;
  mny<=5'd0;
  i_mny<=5'd0;
  prd<=2'd0;
  cst<=5'd0;
  cng<=5'd0;
  st<=1'b0;
 end

else

 begin
  st<=nst;
 end

end

always @(*)
begin
 case(st)
   1'b0: begin
	   i_mny= money;
 	   mny=mny+i_mny;
	   prd=product;
	   nst=(dne)?(1'b1):(1'b0);
	   //st=(dne)?(1'b1):(1'b0);
	  end
   1'b1: begin
	   case(prd)
		2'b00: cst= 5'b00101;
		2'b01: cst= 5'b01010;
		2'b10: cst= 5'b01111;
		2'b11: cst= 5'b10100;
		default: cst=5'b00000;
	   endcase
 		cng=cst-mny;
		if(cng== 5'd0)
		 begin
		   pro=1'b1;
		   r_cng=0;
		 end
		else if(cng> 5'd0)
		 begin
		   pro=1'b1;
		   r_cng=cng;
		 end
		else if(cng< 5'd0)
		 begin
		  pro=1'b0;
		  r_cng=cng;
		 end
	   nst=1'b0;
	  // st=1'b0;
	  end
  default: begin nst=1'b0;
	   //st=1'b0;
	   end
 endcase
end

endmodule
	


 	
