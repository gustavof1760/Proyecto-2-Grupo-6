`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 02:03:35
// Design Name: 
// Module Name: FSM_ESC_RTC_TB
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


module FSM_ESC_RTC_TB;

	// Inputs
	reg clk;
	reg reset;
	reg do_it_esc;
	reg estado_hora;
	reg estado_fecha;
	reg estado_timer;
	reg stop_t;

	// Outputs
	wire a_d;
	wire cs;
	wire rd;
	wire wr;
	wire ch0_mux1;
	wire ch1_mux1;
	wire dir_com_c;
	wire dir_com_t;
	wire dir_tim_en;
	wire dir_tim_mask;
	wire dir_seg;
	wire dir_min;
	wire dir_hora;
	wire dir_dia;
	wire dir_mes;
	wire dir_anio;
	wire dir_seg_tim;
	wire dir_min_tim;
	wire dir_hora_tim;
	wire dat_esc_seg;
	wire dat_esc_min;
	wire dat_esc_hora;
	wire dat_esc_dia;
	wire dat_esc_mes;
	wire dat_esc_anio;
	wire dat_esc_seg_tim;
	wire dat_esc_min_tim;
	wire dat_esc_hora_tim;
	wire dat_tim_en;
	wire dat_tim_mask;
	wire buffer_activo;

	// Instantiate the Unit Under Test (UUT)
	FSM_ESC_RTC uut (
		.clk(clk), 
		.reset(reset), 
		.do_it_esc(do_it_esc), 
		.estado_hora(estado_hora), 
		.estado_fecha(estado_fecha), 
		.estado_timer(estado_timer), 
		.stop_t(stop_t), 
		.a_d(a_d), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.ch0_mux1(ch0_mux1), 
		.ch1_mux1(ch1_mux1), 
		.dir_com_c(dir_com_c), 
		.dir_com_t(dir_com_t), 
		.dir_tim_en(dir_tim_en), 
		.dir_tim_mask(dir_tim_mask), 
		.dir_seg(dir_seg), 
		.dir_min(dir_min), 
		.dir_hora(dir_hora), 
		.dir_dia(dir_dia), 
		.dir_mes(dir_mes), 
		.dir_anio(dir_anio), 
		.dir_seg_tim(dir_seg_tim), 
		.dir_min_tim(dir_min_tim), 
		.dir_hora_tim(dir_hora_tim), 
		.dat_esc_seg(dat_esc_seg), 
		.dat_esc_min(dat_esc_min), 
		.dat_esc_hora(dat_esc_hora), 
		.dat_esc_dia(dat_esc_dia), 
		.dat_esc_mes(dat_esc_mes), 
		.dat_esc_anio(dat_esc_anio), 
		.dat_esc_seg_tim(dat_esc_seg_tim), 
		.dat_esc_min_tim(dat_esc_min_tim), 
		.dat_esc_hora_tim(dat_esc_hora_tim), 
		.dat_tim_en(dat_tim_en), 
		.dat_tim_mask(dat_tim_mask), 
		.buffer_activo(buffer_activo)
	);
	
	always #5 clk = !clk;
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		do_it_esc = 1;
		estado_hora = 1;
		estado_fecha = 0;
		estado_timer = 0;
		stop_t = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset = 0;
		#2590;
		
		reset = 1;
		estado_hora = 0;
		estado_fecha = 1;
		#100;
		reset = 0;
		#2590;
		
		reset = 1;
		estado_fecha = 0;
		estado_timer = 1;
		#100;
		reset = 0;
		#2590;
		
		reset = 1;
		estado_timer = 0;
		stop_t = 1;
		#100;
		reset = 0;
		#2590;
		
		$stop;
	end
      
endmodule