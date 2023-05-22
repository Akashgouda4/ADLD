module t_vu();

wire pro;
wire [4:0] r_cng;
reg [4:0] money;
reg clk,rst,done;
reg [1:0] product;

vu dut(pro,r_cng,clk,rst,done,money,product);

always #5 clk= ~clk;

initial
 begin
	clk=1'b1;
	rst=1'b1;
	done=1'b0;
      #10 rst=1'b0;
	
	
	
    #10 
	product=2'b00;
	money=5'b00101;
	done=1'b1;
	
    #20 
	done=1'b0;
	product=2'b10;
	money=5'b00101;
    #10 money=5'b01010;
	done=1'b1;
	
	
    #20 product=2'b11;
	money=5'b00101;
	#10 money=5'b01010;
	#10 money=5'b01010;
	
	
 end

initial
 begin
  $monitor($time,"Product=%2d,Rem_change=%2d",pro,r_cng);
  #200 $finish;
 end

endmodule

module vu(pro,r_cng,clk,rst,done,money,product);
parameter ONE=2'b00, TWO=2'b01, THREE=2'b10;

output reg pro;
output reg [4:0] r_cng;
input [4:0] money;
input clk,rst,done;
input [1:0] product;

reg [1:0] st,nst;
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
  st<=ONE;
 end
else
 st<=nst;
end

always @(*)
begin
 case(st)
   ONE: begin
	       prd=product;
	       case(prd)
		2'b00: cst= 5'b00101;
		2'b01: cst= 5'b01010;
		2'b10: cst= 5'b01111;
		2'b11: cst= 5'b10100;
		default: cst=5'b00000;
	        endcase
	 nst=TWO;
	end

   TWO: begin
	   while(mny>=cst)
	       begin
		i_mny= money;
 	        mny=mny+i_mny;
	       end
	/*  if(mny>=cst)
	     begin nst=THREE; end
	  else
	    begin nst=TWO; end
	*/
	nst=THREE;
	end

   THREE: begin
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
	 	nst=ONE;
	  end
  default: begin nst=ONE; end
	 
 endcase
end

endmodule
	


 	
