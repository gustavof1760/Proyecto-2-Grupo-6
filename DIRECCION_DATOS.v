`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:36:34
// Design Name: 
// Module Name: DIRECCION_DATOS
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


module DIRECCION_DATOS(
	input wire clk,
	input wire reset,
	input wire [7:0] entrada,
	input wire en_seg, en_min, en_hora, en_dia, en_mes, en_anio, en_seg_tim, en_min_tim, en_hora_tim,
	
	output wire [7:0] sal_seg, sal_min, sal_hora, sal_dia, sal_mes, sal_anio, sal_seg_tim, sal_min_tim, sal_hora_tim
    );
	
	REGISTRO reg_seg(
		.clk(clk),
		.reset(reset),
		.enable(en_seg),
		.data_in(entrada),
		.data_out(sal_seg)
	);
	
	REGISTRO reg_min(
		.clk(clk),
		.reset(reset),
		.enable(en_min),
		.data_in(entrada),
		.data_out(sal_min)
	);
	
	REGISTRO reg_hora(
		.clk(clk),
		.reset(reset),
		.enable(en_hora),
		.data_in(entrada),
		.data_out(sal_hora)
	);
	
	REGISTRO reg_dia(
		.clk(clk),
		.reset(reset),
		.enable(en_dia),
		.data_in(entrada),
		.data_out(sal_dia)
	);
	
	REGISTRO reg_mes(
		.clk(clk),
		.reset(reset),
		.enable(en_mes),
		.data_in(entrada),
		.data_out(sal_mes)
	);
	
	REGISTRO reg_anio(
		.clk(clk),
		.reset(reset),
		.enable(en_anio),
		.data_in(entrada),
		.data_out(sal_anio)
	);
	
	REGISTRO reg_seg_tim(
		.clk(clk),
		.reset(reset),
		.enable(en_seg_tim),
		.data_in(entrada),
		.data_out(sal_seg_tim)
	);
	
	REGISTRO reg_min_tim(
		.clk(clk),
		.reset(reset),
		.enable(en_min_tim),
		.data_in(entrada),
		.data_out(sal_min_tim)
	);
	
	REGISTRO reg_hora_tim(
		.clk(clk),
		.reset(reset),
		.enable(en_hora_tim),
		.data_in(entrada),
		.data_out(sal_hora_tim)
	);

endmodule