`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:25:01
// Design Name: 
// Module Name: CONT_DATOS
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


module CONT_DATOS(
	input wire clk,
	input wire reset,
	
	input wire arriba,
	input wire abajo,
	
	input wire en_seg,
	input wire en_min,
	input wire en_hora,
	input wire en_dia,
	input wire en_mes,
	input wire en_anio,
	input wire en_seg_t,
	input wire en_min_t,
	input wire en_hora_t,
	
	output wire [7:0] dato_prog_seg,
	output wire [7:0] dato_prog_min,
	output wire [7:0] dato_prog_hora,
	output wire [7:0] dato_prog_dia,
	output wire [7:0] dato_prog_mes,
	output wire [7:0] dato_prog_anio,
	output wire [7:0] dato_prog_seg_t,
	output wire [7:0] dato_prog_min_t,
	output wire [7:0] dato_prog_hora_t
	
    );
	
	wire [6:0] cont_dato_seg;
	wire [6:0] cont_dato_min;
	wire [6:0] cont_dato_hora;
	wire [6:0] cont_dato_dia;
	wire [6:0] cont_dato_mes;
	wire [6:0] cont_dato_anio;
	wire [6:0] cont_dato_seg_t;
	wire [6:0] cont_dato_min_t;
	wire [6:0] cont_dato_hora_t;
	
	CONT_DATO_59 seg(
		.clk(clk),
		.reset(reset),
		.aum(arriba),
		.dism(abajo),
		.en(en_seg),
		.dat_sal(cont_dato_seg)
	);
	
	CONT_DATO_59 min(
		.clk(clk),
		.reset(reset),
		.aum(arriba),
		.dism(abajo),
		.en(en_min),
		.dat_sal(cont_dato_min)
	);
	
	CONT_DATO_23 hora(
		.clk(clk),
		.reset(reset),
		.aum(arriba),
		.dism(abajo),
		.en(en_hora),
		.dat_sal(cont_dato_hora)
	);
	
	CONT_DATO_31 dia(
		.clk(clk),
		.reset(reset),
		.aum(arriba),
		.dism(abajo),
		.en(en_dia),
		.dat_sal(cont_dato_dia)
	);
	
	CONT_DATO_12 mes(
		.clk(clk),
		.reset(reset),
		.aum(arriba),
		.dism(abajo),
		.en(en_mes),
		.dat_sal(cont_dato_mes)
	);
	
	CONT_DATO_99 anio(
		.clk(clk),
		.reset(reset),
		.aum(arriba),
		.dism(abajo),
		.en(en_anio),
		.dat_sal(cont_dato_anio)
	);
	
	CONT_DATO_59 seg_t(
		.clk(clk),
		.reset(reset),
		.aum(arriba),
		.dism(abajo),
		.en(en_seg_t),
		.dat_sal(cont_dato_seg_t)
	);
	
	CONT_DATO_59 min_t(
		.clk(clk),
		.reset(reset),
		.aum(arriba),
		.dism(abajo),
		.en(en_min_t),
		.dat_sal(cont_dato_min_t)
	);
	
	CONT_DATO_23 hora_t(
		.clk(clk),
		.reset(reset),
		.aum(arriba),
		.dism(abajo),
		.en(en_hora_t),
		.dat_sal(cont_dato_hora_t)
	);
	
	// BCD
	
	CONV_BCD bcd_seg(
		.dato_bin(cont_dato_seg),
		.dato_bcd(dato_prog_seg)
	);
	
	CONV_BCD bcd_min(
		.dato_bin(cont_dato_min),
		.dato_bcd(dato_prog_min)
	);
	
	CONV_BCD bcd_hora(
		.dato_bin(cont_dato_hora),
		.dato_bcd(dato_prog_hora)
	);
	
	CONV_BCD bcd_dia(
		.dato_bin(cont_dato_dia),
		.dato_bcd(dato_prog_dia)
	);
	
	CONV_BCD bcd_mes(
		.dato_bin(cont_dato_mes),
		.dato_bcd(dato_prog_mes)
	);
	
	CONV_BCD bcd_anio(
		.dato_bin(cont_dato_anio),
		.dato_bcd(dato_prog_anio)
	);
	
	CONV_BCD bcd_seg_t(
		.dato_bin(cont_dato_seg_t),
		.dato_bcd(dato_prog_seg_t)
	);
	
	CONV_BCD bcd_min_t(
		.dato_bin(cont_dato_min_t),
		.dato_bcd(dato_prog_min_t)
	);
	
	CONV_BCD bcd_hora_t(
		.dato_bin(cont_dato_hora_t),
		.dato_bcd(dato_prog_hora_t)
	);
	
endmodule