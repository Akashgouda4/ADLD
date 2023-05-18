module ram(do,di,ad,w,cs);
parameter word=8,addr =10,mems=1024;
output [word-1:0]do;
input [word-1:0]di;
input [addr-1:0]ad;
input w,cs;
reg [word-1:0]mem[0:mems-1];
assign do=mem[ad];
always@(w or cs)
if(w) mem[ad]=di;
endmodule

