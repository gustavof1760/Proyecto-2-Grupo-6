`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 02:00:08
// Design Name: 
// Module Name: FSM_LEER_RTC_TB
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


module FSM_LEER_RTC_TB;

	// Inputs
	reg clk;
	reg reset;
	reg do_it_leer;

	// Outputs
	wire a_d;
	wire cs;
	wire rd;
	wire wr;
	wire ch0_mux1;
	wire ch1_mux2;
	wire dat_lect_seg;
	wire dat_lect_min;
	wire dat_lect_hora;
	wire dat_lect_dia;
	wire dat_lect_mes;
	wire dat_lect_anio;
	wire dat_lect_seg_tim;
	wire dat_lect_min_tim;
	wire dat_lect_hora_tim;
	wire dir_com_cyt;
	wire dir_seg;
	wire dir_min;
	wire dir_hora;
	wire dir_dia;
	wire dir_mes;
	wire dir_anio;
	wire dir_seg_tim;
	wire dir_min_tim;
	wire dir_hora_tim;
	wire buffer_activo;

	// Instantiate the Unit Under Test (UUT)
	FSM_LEER_RTC uut (
		.clk(clk), 
		.reset(reset), 
		.do_it_leer(do_it_leer), 
		.a_d(a_d), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.ch0_mux1(ch0_mux1), 
		.ch1_mux2(ch1_mux2), 
		.dat_lect_seg(dat_lect_seg), 
		.dat_lect_min(dat_lect_min), 
		.dat_lect_hora(dat_lect_hora), 
		.dat_lect_dia(dat_lect_dia), 
		.dat_lect_mes(dat_lect_mes), 
		.dat_lect_anio(dat_lect_anio), 
		.dat_lect_seg_tim(dat_lect_seg_tim), 
		.dat_lect_min_tim(dat_lect_min_tim), 
		.dat_lect_hora_tim(dat_lect_hora_tim), 
		.dir_com_cyt(dir_com_cyt), 
		.dir_seg(dir_seg), 
		.dir_min(dir_min), 
		.dir_hora(dir_hora), 
		.dir_dia(dir_dia), 
		.dir_mes(dir_mes), 
		.dir_anio(dir_anio), 
		.dir_seg_tim(dir_seg_tim), 
		.dir_min_tim(dir_min_tim), 
		.dir_hora_tim(dir_hora_tim), 
		.buffer_activo(buffer_activo)
	);
	
	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		do_it_leer = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		#4310;
		$stop;

	end
      
endmodule