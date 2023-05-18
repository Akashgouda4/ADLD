module t_venm();
wire pro,transc;
wire [4:0] r_cng;
wire[4:0] tot;
reg f,t;
reg clk,rst;
reg [1:0] product;

venm dut(transc,tot,pro,r_cng,clk,rst,f,t,product);

always #5 clk= ~clk;

initial
 begin
	clk=1'b1;
	rst=1'b1;
	  f=1'b0;
	  t=1'b0;
	  product=2'b00;
      #10 rst=1'b0;

      #10 product=2'b00;
	  t=1'b1;

      #20 product=2'b10;
	  t=1'b1;
   	  f=1'b1;

      #30 product=2'b11;
	  t=1'b1;
   	  f=1'b1;
      #20 f=1'b0;
	  t=1'b0;
      #10 t=1'b1;
	  f=1'b1;
	
	
	
 end

initial
 begin
  $monitor($time,"Pro_in=%2d,Total=%2d,Product=%2d,Rem_change=%2d,Transaction=%2d",product,tot,pro,r_cng,transc);
  #120 $finish;
 end

endmodule

module venm(transc,tot,pro,r_cng,clk,rst,f,t,product);

parameter ONE=2'b00, TWO=2'b01, THREE=2'b10;

output reg pro,transc;
output reg [4:0] r_cng;
output reg[4:0] tot;
input f,t;
input clk,rst;
input [1:0] product;

reg n_f,n_t;
reg [1:0] st,nst;
reg [1:0] prd;
reg[4:0] cst,cng;


always@(posedge clk or posedge rst)
begin
if(rst)
 begin
  transc<=1'b1;
  pro<=1'b0;
  r_cng<=3'd0;
  tot<=5'd0;
  prd<=2'd0;
  cst<=5'd0;
  st<=ONE;
 end
else
 st<=nst;
end

always @(*)
begin
 case(st)
   ONE: begin
	       cng=5'd0;
	       tot=5'd0;
	       transc=1'b0;
	       pro=1'b0;
	       r_cng=3'd0; 
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
		n_f=f;
		n_t=t;
		if(n_f)
		  begin
		   tot=tot+5;
		  end
		if(n_t)
		  begin
		    tot=tot+10;
		  end

		if(tot< cst)
		  begin
		   nst=TWO;
	          end
		else if(tot==cst)
		  begin
		    cng=5'd0;   
		    nst=THREE;
		    end
		else if(tot>cst)
		  begin
		    cng=tot-cst;
		   nst=THREE;
	          end
	end

   THREE: begin
	    pro=1'b1;
	    r_cng=cng;
	    transc=1'b1;
	    nst=ONE;
	  end
  default: begin nst=ONE; end
	 
 endcase
end

endmodule
	


 	
