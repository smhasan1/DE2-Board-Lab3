module part1(SW, KEY, LEDR);

	input [9:0]SW;
	input [0:0]KEY;
	output [7:0]LEDR;
	
	wire RotateRight;
	wire [7:0]DATA_IN;
	wire ParallelLoadn;
	wire clock;
	wire [7:0]Q;
	
	assign DATA_IN[7:0] = SW[7:0];
	assign RotateRight = SW[8];
	assign ParallelLoadn = SW[9];
	assign clock = KEY[0];
	assign LEDR = Q;
		
	sub_circuit i0(Q[1], Q[7], RotateRight, DATA_IN[0], ParallelLoadn, clock, Q[0]);
	sub_circuit i1(Q[2], Q[0], RotateRight, DATA_IN[1], ParallelLoadn, clock, Q[1]);
	sub_circuit i2(Q[3], Q[1], RotateRight, DATA_IN[2], ParallelLoadn, clock, Q[2]);
	sub_circuit i3(Q[4], Q[2], RotateRight, DATA_IN[3], ParallelLoadn, clock, Q[3]);
	sub_circuit i4(Q[5], Q[3], RotateRight, DATA_IN[4], ParallelLoadn, clock, Q[4]);
	sub_circuit i5(Q[6], Q[4], RotateRight, DATA_IN[5], ParallelLoadn, clock, Q[5]);
	sub_circuit i6(Q[7], Q[5], RotateRight, DATA_IN[6], ParallelLoadn, clock, Q[6]);
	sub_circuit i7(Q[0], Q[6], RotateRight, DATA_IN[7], ParallelLoadn, clock, Q[7]);
	
endmodule


module sub_circuit(left, right, LoadLeft, D, loadn, clock, Q);

	input right, left, LoadLeft, D, loadn, clock;
	output Q;
	
	wire z1, z2, z3;
	
	mux_1bit_2to1 mux1(right, left, LoadLeft, z1);
	mux_1bit_2to1 mux2(D, z1, loadn, z2);
	
	D_ff ff(z2, clock, Q);

endmodule

// a 1-bit wide 2-to-1 MUX
module mux_1bit_2to1(X,Y,s,M);

   input X,Y;
   input s;
   
   output M;

   assign M = (~s & X) | (s & Y);

endmodule

module D_ff(D, clk, Q);

	input D, clk;
	output Q;
	
	reg Q;
	
	always@(posedge clk)
		Q <= D;

endmodule