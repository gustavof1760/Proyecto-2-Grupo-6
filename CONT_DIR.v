`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:26:09
// Design Name: 
// Module Name: CONT_DIR
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


module CONT_DIR(
	input wire clk,
	input wire reset,
	
	input wire der,
	input wire izq,
	
	input wire en,
	
	output reg [1:0] dir
   
	);
	 
	always @(posedge clk, posedge reset) begin
			if (reset) begin
				dir <= 2'b00;
			end else if (~en) begin
				dir <= 2'b00;
			end else if (der) begin
				if (dir == 2'b10) begin
					dir <= 2'b00; 
				end else begin
					dir <= dir + 2'b01;
				end
			end else if (izq) begin
				if (dir == 2'b00) begin
					dir <= 2'b10;
				end else begin
					dir <= dir - 2'b01;
				end
			end else begin
				dir <= dir + 2'b00;
			end
	end
	
endmodule