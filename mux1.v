`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:48:29
// Design Name: 
// Module Name: mux1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux1(
	input wire ch0_mux1,
	input wire ch1_mux1,
	input wire [7:0] ch0, ch1,
	output reg [7:0] y1
   );
	
	reg sel;
	
	always @* begin
		if(~ch0_mux1) begin //select
			if (ch1_mux1) begin
				sel = 1;
			end else begin
				sel = 0;
			end
		end else begin
			sel = 0;
		end
   end
	
	always @* begin
			if (sel)begin
				y1 = ch1;
			end
			else begin
				y1 = ch0;
			end
	end
		
endmodule
