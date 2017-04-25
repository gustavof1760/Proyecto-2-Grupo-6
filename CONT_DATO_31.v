`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:22:22
// Design Name: 
// Module Name: CONT_DATO_31
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


module CONT_DATO_31(
	input wire clk,
	input wire reset,
	
	input wire aum,
	input wire dism,
	
	input wire en,
	
	output wire [6:0] dat_sal
   
	);
	
	reg [4:0] dat;
	
	always @(posedge clk, posedge reset) begin
			if (reset) begin
				dat <= 5'b00000;
			end else if (~en) begin
				dat <= dat + 5'b00000;
			end else if (aum) begin
				if (dat == 5'b11111) begin //31.
					dat <= 5'b00000; 
				end else begin
					dat <= dat + 5'b00001;
				end
			end else if (dism) begin
				if (dat == 5'b00000) begin
					dat <= 5'b11111;
				end else begin
					dat <= dat - 5'b00001;
				end
			end else begin
				dat <= dat + 5'b00000;
			end
	end
	
	assign dat_sal = {2'b00,dat};
	
endmodule
