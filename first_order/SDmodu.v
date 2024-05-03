`timescale 1ns / 10ps

module SDmodu
#(
	parameter N=16
)
(
	input clk,
	input areset,
	input signed [N-1:0] din,
	output pdm
);	
	reg signed [N+1:0] din_ext;
	reg signed [N+1:0] cnt;
	wire clk_25;
	clkpll u_clkpll(
		.clk_in(clk),
		.clk_50(),
		.clk_25(clk_25),
		.locked()
	);
	
	always @(posedge clk_25, negedge areset) begin
		if(!areset) din_ext <= {(N+2){1'b0}};
		else din_ext <= {din[N-1], din[N-1], din};
	end
	
	always @(posedge clk_25, negedge areset) begin
		if(!areset) cnt <= {(N+2){1'b0}};
		else begin
			if(cnt[N+1]) cnt <= cnt + din_ext + {2'b00, 1'b1, {(N-1){1'b0}}};
			//cnt<0: cnt + din + 2^15
			else cnt <= cnt + din_ext + {2'b11, 1'b1, {(N-1){1'b0}}};
			//cnt>=0: cnt + din - 2^15
		end
	end
	assign pdm = ~cnt[N+1];
endmodule
