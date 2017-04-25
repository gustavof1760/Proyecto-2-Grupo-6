`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:23:05
// Design Name: 
// Module Name: CONT_DATO_59
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


module CONT_DATO_59(
	input wire clk,
	input wire reset,
	
	input wire aum,
	input wire dism,
	
	input wire en,
	
	output wire [6:0] dat_sal
   
	);
	
	reg [5:0] dat;
	
	always @(posedge clk, posedge reset) begin
			if (reset) begin
				dat <= 6'b000000;
			end else if (~en) begin
				dat <= dat + 6'b000000;
			end else if (aum) begin
				if (dat == 6'b111011) begin //59.
					dat <= 6'b000000; 
				end else begin
					dat <= dat + 6'b000001;
				end
			end else if (dism) begin
				if (dat == 6'b000000) begin
					dat <= 6'b111011;
				end else begin
					dat <= dat - 6'b000001;
				end
			end else begin
				dat <= dat + 6'b000000;
			end
	end
	
	assign dat_sal = {1'b0,dat};

endmodule