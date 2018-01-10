module part2(SW, KEY, HEX0, HEX1, HEX2, HEX3);
input[11:0] SW;
input[0:0] KEY;
output[6:0] HEX0, HEX1, HEX2, HEX3;
reg[7:0] f;
wire[7:0] B;
always@(*)
begin
case(SW[10:8])
3'b000: f = ~SW[7:0] | B[7:0];
3'b001: f = ~SW[7:0] | ~B[7:0];
3'b010: f = ~SW[7:0];
3'b011: f = SW[7:0] & B[7:0];
3'b100: f = SW[7:0] + B[7:0];
3'b101: f = ~SW[7:0] & ~B[7:0];
3'b110: f = SW[7] + SW[6] + SW[5] + SW[4] + SW[3] + SW[2] + SW[1] + SW[0];
3'b111: f = SW[7] + SW[6] + SW[5] + SW[4] + SW[3] + SW[2] + SW[1] + SW[0] + B[7] + B[6] + B[5] + B[4] + B[3] + B[2] + B[1] + B[0];
endcase
end
flip_flop F1(f,~KEY[0],~SW[11],B);
hexto7segment H0(B[3:0],HEX0);
hexto7segment H1(B[7:4],HEX1);
hexto7segment H2(SW[3:0],HEX2);
hexto7segment H3(SW[7:4],HEX3);
endmodule


module flip_flop(D,clk,reset,Q);
input[7:0] D;
input clk,reset;
output[7:0] Q;
reg[7:0] f;

always @(posedge clk, posedge reset)
begin
if (reset)
begin
 f <= 8'b00000000;
end
else
begin
  f<= D;
end
end
assign Q = f;
endmodule 


module hexto7segment(x,h);
input[3:0] x;
output reg [6:0] h;

always @*
case (x)
4'b0000 : h = 7'b1000000;
4'b0001 : h = 7'b1111001;
4'b0010 : h = 7'b0100100; 
4'b0011 : h = 7'b0110000;
4'b0100 : h = 7'b0011001;
4'b0101 : h = 7'b0010010;  
4'b0110 : h = 7'b0000010;
4'b0111 : h = 7'b1111000;
4'b1000 : h = 7'b0000000;
4'b1001 : h = 7'b0010000;
4'b1010 : h = 7'b0001000; 
4'b1011 : h = 7'b0000011;
4'b1100 : h = 7'b1000110;
4'b1101 : h = 7'b0100001;
4'b1110 : h = 7'b0000110;
4'b1111 : h = 7'b0001110;
endcase

endmodule 
