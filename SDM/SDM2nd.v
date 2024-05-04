`timescale 1ns / 1ps

module SDM2nd
#(
	parameter N=16
)
(
	input clk,
	input areset,
	input signed [N-1:0] din,
	output pdm
);	
	reg signed [N+7:0] din_ext;
	reg signed [N+7:0] cnt0;
	reg signed [N+7:0] cnt1; //1st and 2nd stage
	wire clk_25;
	clkpll u_clkpll(
		.clk_in(clk),
		.clk_50(),
		.clk_25(clk_25),
		.locked()
	);
	
	always @(posedge clk_25, negedge areset) begin
		if(!areset) din_ext <= {(N+8){1'b0}};
		else din_ext <= {{8{din[N-1]}}, din};
	end
	
	always @(posedge clk_25, negedge areset) begin
		if(!areset) begin
			cnt0 <= {(N+8){1'b0}};
			cnt1 <= {(N+8){1'b0}};
		end
		else begin
			if(cnt1[N+7]) begin //cnt1<0
				cnt0 <= cnt0 + din_ext + {{8{1'b0}}, 1'b1, {(N-1){1'b0}}};
				//cnt0 + din + 2^15
				cnt1 <= cnt1 + cnt0 + {{7{1'b0}}, 1'b1, {N{1'b0}}};
				//cnt1 + cnt0 + 2^16
			end
			
			else begin //cnt1>=0
				cnt0 <= cnt0 + din_ext + {{8{1'b1}}, 1'b1, {(N-1){1'b0}}};
				//cnt0 + din - 2^15
				cnt1 <= cnt1 + cnt0 + {{7{1'b1}}, 1'b1, {N{1'b0}}};
				//cnt1 + cnt0 - 2^16
			end
		end
	end
	assign pdm = ~cnt1[N+7];
endmodule
