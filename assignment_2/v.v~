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
		if(cng==0)
		 begin
		   pro=1'b1;
		   r_cng=0;
		 end
		else if(cng>0)
		 begin
		   pro=1'b1;
		   r_cng=cng;
		 end
		else if(cng<0)
		 begin
		  pro=1'b0;
		  r_cng=cng;
		 end
	   nst=1'b0;
	  end
  default: nst=1'b0;
 endcase
end

endmodule
		
