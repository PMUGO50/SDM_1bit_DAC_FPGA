`timescale 1ns / 10ps
module top_tb;
	parameter N=8;
	parameter halfT = 0.5;
	parameter fdiv = 50;
	parameter sampnum = 300;
	
	//inputs and outputs definition
    reg clk;
    reg areset;
	reg signed [N-1:0] din;
    wire pwmout;

    pwmer //instance module
	#(
		.N(N)
	)
	uut ( 
        .clk(clk),
        .areset(areset),
		.din(din),
		.pwmout(pwmout)
    );
	
    initial begin
		clk <= 1'b1;
		forever #(halfT) clk <= ~clk;
	end
	
	initial begin
		areset <= 1'b1;
		#(halfT) areset <= 1'b0;
		#(halfT) areset <= 1'b1;
	end
	
	reg [N-1:0] dcache [sampnum-1:0];
	integer i;
	initial begin
		$readmemh("tbwave.csv", dcache);
		#(halfT*3);
		for(i=0; i<sampnum; i=i+1) begin
			din <= dcache[i];
			#(halfT*2*fdiv);
		end
		din <= {N{1'b0}};
		#(halfT*20) $stop;
	end
	
	integer fl;
	initial begin
		fl = $fopen("pwmout.csv", "w");
		forever #(halfT*2) $fwrite(fl, "%b\n", pwmout);
	end
endmodule