`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:56:05
// Design Name: 
// Module Name: SWITCHES
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


module SWITCHES(
	input wire [2:0] S,
	output reg [2:0] prog
   );
 
	always @* begin
		case(S)
			3'b001 : begin //Activo Sw0
		     	 prog = 3'b001; //Programar fecha
			end
			3'b010 : begin //Activo Sw1
				prog = 3'b010; //Programar hora
			end
			3'b100 : begin //Activo Sw2
				prog = 3'b100; //Programar timer
			end
			default: begin
				prog = 3'b000;
			end
		endcase
	end

endmodule 