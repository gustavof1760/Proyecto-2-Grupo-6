`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:26:50
// Design Name: 
// Module Name: CONTROL_DATA
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


module CONTROL_DATA(
	input wire dat_esc_init,
	input wire dat_esc_zero,
	input wire dat_tim_en,
	input wire dat_tim_mask,
	input wire dat_59,
	
	input wire dir_st2,
	input wire dir_com_cyt,
	input wire dir_com_c,
	input wire dir_com_t,
	input wire dir_tim_en,
	input wire dir_tim_mask,
	input wire dir_seg,
	input wire dir_min,
	input wire dir_hora,
	input wire dir_dia,
	input wire dir_mes,
	input wire dir_anio,
	input wire dir_seg_tim,
	input wire dir_min_tim,
	input wire dir_hora_tim,
	
	output reg [7:0] dato_salida
   );
	
	always @* begin
		if (dat_esc_init) begin
			dato_salida = 8'h10;
		end else if (dat_esc_zero) begin
			dato_salida = 8'h00;
		end else if (dir_st2) begin
			dato_salida = 8'h02;
		end else if (dir_com_cyt) begin
			dato_salida = 8'hf0;
		end else if (dir_seg) begin
			dato_salida = 8'h21;
		end else if (dir_min) begin
			dato_salida = 8'h22;
		end else if (dir_hora) begin
			dato_salida = 8'h23;
		end else if (dir_dia) begin
			dato_salida = 8'h24;
		end else if (dir_mes) begin
			dato_salida = 8'h25;
		end else if (dir_anio) begin
			dato_salida = 8'h26;
		end else if (dir_seg_tim) begin
			dato_salida = 8'h41;
		end else if (dir_min_tim) begin
			dato_salida = 8'h42;
		end else if (dir_hora_tim) begin
			dato_salida = 8'h43;
		end else if (dir_com_c) begin
			dato_salida = 8'hf1;
		end else if (dir_com_t) begin
			dato_salida = 8'hf2;
		end else if (dir_tim_en) begin
			dato_salida = 8'h00;
		end else if (dir_tim_mask) begin
			dato_salida = 8'h01;
		end else if (dat_tim_en) begin
			dato_salida = 8'h08;
		end else if (dat_tim_mask) begin
			dato_salida = 8'h04;
		end else if (dat_59) begin
			dato_salida = 8'h59;
		end else begin
			dato_salida = 8'hff;
		end
		
	end
endmodule