`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 02:05:15
// Design Name: 
// Module Name: DIRECCION_DATOS_TB
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


module DIRECCION_DATOS_TB;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] entrada;
	reg en_seg;
	reg en_min;
	reg en_hora;
	reg en_dia;
	reg en_mes;
	reg en_anio;
	reg en_seg_tim;
	reg en_min_tim;
	reg en_hora_tim;

	// Outputs
	wire [7:0] sal_seg;
	wire [7:0] sal_min;
	wire [7:0] sal_hora;
	wire [7:0] sal_dia;
	wire [7:0] sal_mes;
	wire [7:0] sal_anio;
	wire [7:0] sal_seg_tim;
	wire [7:0] sal_min_tim;
	wire [7:0] sal_hora_tim;

	// Instantiate the Unit Under Test (UUT)
	DIRECCION_DATOS uut (
		.clk(clk), 
		.reset(reset), 
		.entrada(entrada), 
		.en_seg(en_seg), 
		.en_min(en_min), 
		.en_hora(en_hora), 
		.en_dia(en_dia), 
		.en_mes(en_mes), 
		.en_anio(en_anio), 
		.en_seg_tim(en_seg_tim), 
		.en_min_tim(en_min_tim), 
		.en_hora_tim(en_hora_tim), 
		.sal_seg(sal_seg), 
		.sal_min(sal_min), 
		.sal_hora(sal_hora), 
		.sal_dia(sal_dia), 
		.sal_mes(sal_mes), 
		.sal_anio(sal_anio), 
		.sal_seg_tim(sal_seg_tim), 
		.sal_min_tim(sal_min_tim), 
		.sal_hora_tim(sal_hora_tim)
	);
	
	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		entrada = 8'b01110111;
		en_seg = 0;
		en_min = 0;
		en_hora = 0;
		en_dia = 0;
		en_mes = 0;
		en_anio = 0;
		en_seg_tim = 0;
		en_min_tim = 0;
		en_hora_tim = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		#100;
		
		en_seg = 1;
		#100;
		en_seg = 0;
		#25;
		entrada = 8'b11111111;
		#50;
		entrada = 8'b01110111;
		#25;
		
		en_min = 1;
		#100;
		en_min = 0;
		#25;
		entrada = 8'b11111111;
		#50;
		entrada = 8'b01110111;
		#25;
		
		en_hora = 1;
		#100;
		en_hora = 0;
		#25;
		entrada = 8'b11111111;
		#50;
		entrada = 8'b01110111;
		#25;
		
		en_dia = 1;
		#100;
		en_dia = 0;
		#25;
		entrada = 8'b11111111;
		#50;
		entrada = 8'b01110111;
		#25;
		
		en_mes = 1;
		#100;
		en_mes = 0;
		#25;
		entrada = 8'b11111111;
		#50;
		entrada = 8'b01110111;
		#25;
		
		en_anio = 1;
		#100;
		en_anio = 0;
		#25;
		entrada = 8'b11111111;
		#50;
		entrada = 8'b01110111;
		#25;
		
		en_seg_tim = 1;
		#100;
		en_seg_tim = 0;
		#25;
		entrada = 8'b11111111;
		#50;
		entrada = 8'b01110111;
		#25;
		
		en_min_tim = 1;
		#100;
		en_min_tim = 0;
		#25;
		entrada = 8'b11111111;
		#50;
		entrada = 8'b01110111;
		#25;
		
		en_hora_tim = 1;
		#100;
		en_hora_tim = 0;
		#25;
		entrada = 8'b11111111;
		#50;
		entrada = 8'b01110111;
		#25;
		
		$stop;

	end
      
endmodule

