`timescale 1ns / 10ps

module top_tb;
	parameter N=16;
	parameter sampnum = 7500;
	parameter halfT = 0.5; //oscillator runs at 50MHz actually
	parameter samphalfT = 2*halfT; //sampling freq = 25MHz
	
	reg clk;
	reg areset;
	reg [N-1:0] din;
	wire pdm;
	SDmodu uut(
		.clk(clk), 
		.areset(areset), 
		.din(din),
		.pdm(pdm)
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
		#(samphalfT*3);
		for(i=0; i<sampnum; i=i+1) begin
			din <= dcache[i];
			#(samphalfT*2);
		end
		din <= {N{1'b0}};
		#(samphalfT*20) $stop;
	end
	
	integer fl;
	initial begin
		fl = $fopen("pdmout.csv", "w");
		forever #(samphalfT*2) $fwrite(fl, "%b\n", pdm);
	end
      
endmodule

