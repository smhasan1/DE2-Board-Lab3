module part3(CLOCK_50, LEDR);
	input CLOCK_50;
	output[17:0] LEDR;
	reg right, clk;
	reg data = 1;
	reg load = 1;
	reg[25:0] counter;

	
	always@(posedge CLOCK_50)
	begin
		counter = counter + 1;
		if(counter == 25000000)
		begin	
			clk = ~clk;
			counter = 0;
		end
	end
	
	always@(posedge clk)
	begin
		if(data == 1)
			data <= 0;
		else 
			load <= 0;
		
		if(LEDR[16] == 1)
			right <= 1;
		else if(LEDR[1] == 1)
			right <= 0;
	end
	

	rotating_reg R1(1, right, ~load, clk, LEDR);
	
endmodule


module rotating_reg(data, rotateRight, parallelLoad, clock, Q);
	input[17:0] data;
	input rotateRight, clock, parallelLoad;
	output[17:0] Q;

	sub_circuit i0(Q[1], Q[17], rotateRight, data[0], parallelLoad, clock, Q[0]);
	sub_circuit i1(Q[2], Q[0], rotateRight, data[1], parallelLoad, clock, Q[1]);
	sub_circuit i2(Q[3], Q[1], rotateRight, data[2], parallelLoad, clock, Q[2]);
	sub_circuit i3(Q[4], Q[2], rotateRight, data[3], parallelLoad, clock, Q[3]);
	sub_circuit i4(Q[5], Q[3], rotateRight, data[4], parallelLoad, clock, Q[4]);
	sub_circuit i5(Q[6], Q[4], rotateRight, data[5], parallelLoad, clock, Q[5]);
	sub_circuit i6(Q[7], Q[5], rotateRight, data[6], parallelLoad, clock, Q[6]);
	sub_circuit i7(Q[8], Q[6], rotateRight, data[7], parallelLoad, clock, Q[7]);
	sub_circuit i8(Q[9], Q[7], rotateRight, data[8], parallelLoad, clock, Q[8]);
	sub_circuit i9(Q[10], Q[8], rotateRight, data[9], parallelLoad, clock, Q[9]);
	sub_circuit i10(Q[11], Q[9], rotateRight, data[10], parallelLoad, clock, Q[10]);
	sub_circuit i11(Q[12], Q[10], rotateRight, data[11], parallelLoad, clock, Q[11]);
	sub_circuit i12(Q[13], Q[11], rotateRight, data[12], parallelLoad, clock, Q[12]);
	sub_circuit i13(Q[14], Q[12], rotateRight, data[13], parallelLoad, clock, Q[13]);
	sub_circuit i14(Q[15], Q[13], rotateRight, data[14], parallelLoad, clock, Q[14]);
	sub_circuit i15(Q[16], Q[14], rotateRight, data[15], parallelLoad, clock, Q[15]);
	sub_circuit i16(Q[17], Q[15], rotateRight, data[16], parallelLoad, clock, Q[16]);
	sub_circuit i17(Q[0], Q[16], rotateRight, data[17], parallelLoad, clock, Q[17]);

endmodule


module sub_circuit(left, right, LoadLeft, D, loadn, clock, Q);
	input right, left, LoadLeft, D, loadn, clock;
	output Q;
	wire z1, z2, z3;
	
	mux_1bit_2to1 mux1(right, left, LoadLeft, z1);
	mux_1bit_2to1 mux2(D, z1, loadn, z2);
	D_ff ff(z2, clock, Q);
endmodule


module mux_1bit_2to1(X,Y,s,M);
	input X,Y;
	input s;
	output M;

	assign M = (~s & X) | (s & Y);
endmodule


module D_ff(D, clk, Q);
	input D, clk;
	output Q;
	reg f;
	
	always@(posedge clk)
		f <= D;
		
	assign Q = f;
endmodule 