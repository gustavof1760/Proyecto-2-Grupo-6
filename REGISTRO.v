`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:52:15
// Design Name: 
// Module Name: REGISTRO
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


module REGISTRO(
	input wire clk,
	input wire reset,
	input wire enable,
	input wire [7:0] data_in,
	output reg [7:0] data_out
   );
	
	always @(posedge clk, posedge reset) begin
      if (reset) begin
         data_out <= 8'b00000000;
      end else if (enable) begin
         data_out <= data_in;
      end else begin
			data_out <= data_out + 8'b00000000;
		end
	end
endmodule