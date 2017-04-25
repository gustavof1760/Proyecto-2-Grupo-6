`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:18:00
// Design Name: 
// Module Name: ANTIREBOTE
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


module ANTIREBOTE(
    input wire entrada,
    input wire clk,
	input wire reset,
	output wire salida
    );

	//El antirebote consiste en pasar la señal por 5 Flip Flops con el fin de evitar que filtren valores indeseados
	
	reg ff01;
	reg ff02;
	reg ff03;
	reg ff04;
	reg ff05;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			ff01 <= 1'b0;
			ff02 <= 1'b0;
			ff03 <= 1'b0;
			ff04 <= 1'b0;
			ff05 <= 1'b0;
		end else begin
			ff01 <= entrada;
			ff02 <= ff01;
			ff03 <= ff02;
			ff04 <= ff03;
			ff05 <= ff04;
		end
	end

	assign salida = ff01 && ff02 && ff03 && ff04 && ff05 && ~entrada;
	// de esta manera se asegura que 
	// el dato se encuentre en todos los flip flops
	// y ya se haya soltado el botón.

endmodule

