`timescale 1ns / 10ps
module pwmer
#(
    parameter N=8
)
(
    input clk,
    input areset,
	input signed [N-1:0] din,
    output pwmout
);
	reg [N-1:0] cnt;
	wire signed [N-1:0] cnt_sign;
	always @(posedge clk, negedge areset) begin
		if(!areset) cnt <= {N{1'b0}};
		else cnt <= cnt + 1'b1;
	end
	assign cnt_sign = cnt - {1'b1, {(N-1){1'b0}}};
	assign pwmout = (din > cnt_sign);
endmodule