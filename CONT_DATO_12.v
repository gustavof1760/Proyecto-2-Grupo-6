`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:20:19
// Design Name: 
// Module Name: CONT_DATO_12
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


module CONT_DATO_12(
	input wire clk,
	input wire reset,
	
	input wire aum,
	input wire dism,
	
	input wire en,
	
	output wire [6:0] dat_sal
	
	);
	
	reg [3:0] dat;
	
	always @(posedge clk, posedge reset) begin
			if (reset) begin
				dat <= 4'b0000;
			end else if (~en) begin
				dat <= dat + 4'b0000;
			end else if (aum) begin
				if (dat == 4'b1100) begin // 12.
					dat <= 4'b0000; 
				end else begin
					dat <= dat + 4'b0001;
				end
			end else if (dism) begin
				if (dat == 4'b0000) begin
					dat <= 4'b1100;
				end else begin
					dat <= dat - 4'b0001;
				end
			end else begin
				dat <= dat + 4'b0000;
			end
	end

	assign dat_sal = {3'b000,dat};
	
endmodule

