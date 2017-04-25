`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2017 02:35:24
// Design Name: 
// Module Name: MUX_RGB
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


module MUX_RGB(
    input video_on,
	input [11:0] rgb_text,
	output reg [11:0] RGB
	);
	
	always @*
	begin
	if (video_on)
		RGB=rgb_text;
	else
		RGB=12'h000;
	end
endmodule
