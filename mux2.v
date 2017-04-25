`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:50:04
// Design Name: 
// Module Name: mux2
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


module mux2(
	input wire ch0_mux2,
	input wire ch1_mux2,
	input wire [7:0] ch0, ch1,
	output reg [7:0] y2
    );
	
	reg sel;
	
	always @* begin
		if(ch0_mux2) begin //select
			if (ch1_mux2) begin 
				sel = 1;
			end else begin
				sel = 0;
			end
		end else begin
			sel = 1;
		end
	end
		
	always @* begin
		if (sel)begin
			y2 = ch1;
		end else begin
			y2 = ch0;
		end
	end
		
endmodule
