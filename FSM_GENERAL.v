`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:40:52
// Design Name: 
// Module Name: FSM_GENERAL
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


module FSM_GENERAL(
	input wire clk, reset,
	
	input wire S2, S1, S0,
	input wire s_stop_t,
	
	output wire a_d_g, cs_g, rd_g, wr_g, //////
	
	output wire ch0_mux1_g,
	output wire ch1_mux1_g,
	
	output wire buffer_activo_g, //////
	
	output reg ch0_mux2_g,
	output wire ch1_mux2_g,
	
	output wire dat_esc_init_g,
	output wire dat_esc_zero_g,
	output wire dat_59_g,
	
	output wire dir_st2_g,
	output wire dir_com_cyt_g,
	output wire dir_com_c_g,
	output wire dir_com_t_g,
	output wire dir_tim_mask_g,
	output wire dir_tim_en_g,
	
	output wire dir_seg_g, ////
	output wire dir_min_g, ////
	output wire dir_hora_g, ////
	output wire dir_dia_g, ////
	output wire dir_mes_g, ////
	output wire dir_anio_g, ////
	output wire dir_seg_tim_g, ////
	output wire dir_min_tim_g, ////
	output wire dir_hora_tim_g, ////
	
	output wire dat_lect_seg_g,
	output wire dat_lect_min_g,
	output wire dat_lect_hora_g,
	output wire dat_lect_dia_g,
	output wire dat_lect_mes_g,
	output wire dat_lect_anio_g,
	output wire dat_lect_seg_tim_g,
	output wire dat_lect_min_tim_g,
	output wire dat_lect_hora_tim_g,
	
	output wire dat_esc_seg_g,
	output wire dat_esc_min_g,
	output wire dat_esc_hora_g,
	output wire dat_esc_dia_g,
	output wire dat_esc_mes_g,
	output wire dat_esc_anio_g,
	output wire dat_esc_seg_tim_g,
	output wire dat_esc_min_tim_g,
	output wire dat_esc_hora_tim_g,
	
	output wire dat_tim_mask_g,
	output wire dat_tim_en_g,
	
	output reg en_contadores_hora_g,
	output reg en_contadores_fecha_g,
	output reg en_contadores_timer_g,
	
	output reg most_cur_g
	
	);
	
	reg do_it_inic;
	wire a_d_i, cs_i, rd_i, wr_i, ch0_mux1_i, buffer_activo_i;
	wire dat_esc_init_i,dat_esc_zero_i, dir_st2_i, dir_com_cyt_i, dir_seg_i, dir_min_i, dir_hora_i,
		dir_dia_i, dir_mes_i, dir_anio_i, dir_seg_tim_i, dir_min_tim_i, dir_hora_tim_i, dir_tim_en_i, dat_59_i;
	
	FSM_INIC_RTC Inicializacion(
		.clk(clk),
		.reset(reset),
		.do_it_inic(do_it_inic),
		.a_d(a_d_i),
		.cs(cs_i),
		.rd(rd_i),
		.wr(wr_i),
		.ch0_mux1(ch0_mux1_i),
		.buffer_activo(buffer_activo_i),
		.dat_esc_init(dat_esc_init_i),
		.dat_esc_zero(dat_esc_zero_i),
		.dat_59(dat_59_i),
		.dir_st2(dir_st2_i),
		.dir_com_cyt(dir_com_cyt_i),
		.dir_seg(dir_seg_i),
		.dir_min(dir_min_i),
		.dir_hora(dir_hora_i),
		.dir_dia(dir_dia_i),
		.dir_mes(dir_mes_i),
		.dir_anio(dir_anio_i),
		.dir_seg_tim(dir_seg_tim_i),
		.dir_min_tim(dir_min_tim_i),
		.dir_hora_tim(dir_hora_tim_i),
		.dir_tim_en(dir_tim_en_i)
	);
	
	reg do_it_leer;
	wire a_d_l, cs_l, rd_l, wr_l, ch0_mux1_l, ch1_mux2_l, buffer_activo_l;
	
	wire dat_lect_seg_l, dat_lect_min_l, dat_lect_hora_l, dat_lect_dia_l, dat_lect_mes_l,
		dat_lect_anio_l, dat_lect_seg_tim_l, dat_lect_min_tim_l, dat_lect_hora_tim_l;
		
	wire dir_com_cyt_l, dir_seg_l, dir_min_l, dir_hora_l,
		dir_dia_l, dir_mes_l, dir_anio_l, dir_seg_tim_l, dir_min_tim_l, dir_hora_tim_l;
		
	FSM_LEER_RTC Lectura(
		.clk(clk),
		.reset(reset),
		.do_it_leer(do_it_leer),
		.a_d(a_d_l),
		.cs(cs_l),
		.rd(rd_l),
		.wr(wr_l),
		.ch0_mux1(ch0_mux1_l),
		.ch1_mux2(ch1_mux2_l),
		.buffer_activo(buffer_activo_l),
		.dir_com_cyt(dir_com_cyt_l),
		.dir_seg(dir_seg_l),
		.dir_min(dir_min_l),
		.dir_hora(dir_hora_l),
		.dir_dia(dir_dia_l),
		.dir_mes(dir_mes_l),
		.dir_anio(dir_anio_l),
		.dir_seg_tim(dir_seg_tim_l),
		.dir_min_tim(dir_min_tim_l),
		.dir_hora_tim(dir_hora_tim_l),
		.dat_lect_seg(dat_lect_seg_l),
		.dat_lect_min(dat_lect_min_l),
		.dat_lect_hora(dat_lect_hora_l),
		.dat_lect_dia(dat_lect_dia_l),
		.dat_lect_mes(dat_lect_mes_l),
		.dat_lect_anio(dat_lect_anio_l),
		.dat_lect_seg_tim(dat_lect_seg_tim_l),
		.dat_lect_min_tim(dat_lect_min_tim_l),
		.dat_lect_hora_tim(dat_lect_hora_tim_l)
	);
	
	reg do_it_esc_g;
	wire a_d_e, cs_e, rd_e, wr_e, ch0_mux1_e, ch1_mux1_e, buffer_activo_e;
	
	wire dir_com_c_e, dir_com_t_e, dir_seg_e, dir_min_e, dir_hora_e, dir_dia_e, dir_mes_e,
		dir_anio_e, dir_seg_tim_e, dir_min_tim_e, dir_hora_tim_e;
	
	wire dir_tim_en_e, dir_tim_mask_e;
		
	wire dat_esc_seg_e, dat_esc_min_e, dat_esc_hora_e, dat_esc_dia_e, dat_esc_mes_e,
		dat_esc_anio_e, dat_esc_seg_tim_e, dat_esc_min_tim_e, dat_esc_hora_tim_e;
	
	wire dat_tim_en_e, dat_tim_mask_e;
	
	reg est_hora, est_fecha, est_timer;
	
	reg stop_t_g;
	
	FSM_ESC_RTC Escritura(
		.clk(clk),
		.reset(reset),
		.do_it_esc(do_it_esc_g),
		.estado_hora(est_hora),
		.estado_fecha(est_fecha),
		.estado_timer(est_timer),
		.stop_t(stop_t_g),
		.a_d(a_d_e),
		.cs(cs_e),
		.rd(rd_e),
		.wr(wr_e),
		.ch0_mux1(ch0_mux1_e),
		.ch1_mux1(ch1_mux1_e),
		.buffer_activo(buffer_activo_e),
		.dir_com_c(dir_com_c_e),
		.dir_com_t(dir_com_t_e),
		.dir_tim_en(dir_tim_en_e),
		.dir_tim_mask(dir_tim_mask_e),
		.dir_seg(dir_seg_e),
		.dir_min(dir_min_e),
		.dir_hora(dir_hora_e),
		.dir_dia(dir_dia_e),
		.dir_mes(dir_mes_e),
		.dir_anio(dir_anio_e),
		.dir_seg_tim(dir_seg_tim_e),
		.dir_min_tim(dir_min_tim_e),
		.dir_hora_tim(dir_hora_tim_e),
		.dat_esc_seg(dat_esc_seg_e),
		.dat_esc_min(dat_esc_min_e),
		.dat_esc_hora(dat_esc_hora_e),
		.dat_esc_dia(dat_esc_dia_e),
		.dat_esc_mes(dat_esc_mes_e),
		.dat_esc_anio(dat_esc_anio_e),
		.dat_esc_seg_tim(dat_esc_seg_tim_e),
		.dat_esc_min_tim(dat_esc_min_tim_e),
		.dat_esc_hora_tim(dat_esc_hora_tim_e),
		.dat_tim_mask(dat_tim_mask_e),
		.dat_tim_en(dat_tim_en_e)
	);
	
	/* Estados. */
	localparam est0 = 3'b000, est1 = 3'b001, est2 = 3'b010, est3 = 3'b011, est4 = 3'b100, est5 = 3'b101, est6 = 3'b110, est7 = 3'b111;
	
	reg [2:0] est_sig;
	reg [2:0] est_act;
	reg [2:0] est_pas;
	
	reg [9:0] contador;
	
	reg [8:0] contador1;
	reg [20:0] contador2;
	reg [8:0] contador6;
	
	/* Lógica Secuencial */
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			contador <= 10'b0000000000;
		end else begin
			contador <= contador + 10'b0000000001;
		end
	end
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			contador1 <= 9'b000000000;
		end else if (est_act == est1) begin
			contador1 <= contador1 + 9'b000000001;
		end else begin
			contador1 <= 9'b000000000;
		end
	end
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			contador2 <= 21'b000000000000000000000;
		end else if (est_act == est2) begin
			contador2 <= contador2 + 21'b000000000000000000001;
		end else begin
			contador2 <= 21'b000000000000000000000;
		end
	end
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			contador6 <= 9'b000000000;
		end else if (est_act == est6) begin
			contador6 <= contador6 + 9'b000000001;
		end else begin
			contador6 <= 9'b000000000;
		end
	end
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			est_act <= est0;
		end else begin
			est_act <= est_sig;
		end
	end
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			est_pas <= est0;
		end else if (est_act == est_sig) begin
			est_pas <= est_pas;
		end else begin
			est_pas <= est_act;
		end
	end
	
	/* Lógica Combinacional */
	
	always @* begin
		est_sig = est0;
		case(est_act)
			est0: begin
				if (contador == 560) begin // Lo que tarda la inicialización.
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			est1: begin
				if (contador1 == 431) begin // Lo que tarda una lectura completa.
					est_sig = est2;
				end else begin
					est_sig = est1;
				end
			end
			est2: begin
				if (S0) begin
					est_sig = est4;
				end else if (S1) begin
					est_sig = est3;
				end else if (S2) begin
					est_sig = est5;
				end else if (s_stop_t) begin
					est_sig = est7;
				end else if(contador2 == 1599569) begin // Se espera aprox 16ms  para esperar un pantallazo de la VGA.
					est_sig = est1;
				end else begin
					est_sig = est2;
				end
			end
			est3: begin
				if (~S1) begin
					est_sig = est6;
				end else begin
					est_sig = est3;
				end
			end
			est4: begin
				if (~S0) begin
					est_sig = est6;
				end else begin
					est_sig = est4;
				end
			end
			est5: begin
				if (~S2) begin
					est_sig = est6;
				end else begin
					est_sig = est5;
				end
			end
			est6: begin
				if (contador6 == 259) begin
					est_sig = est1;
				end else begin
					est_sig = est6;
				end
			end
			est7: begin
				if (~s_stop_t) begin
					est_sig = est6;
				end else begin
					est_sig = est7;
				end
			end
			default: begin
				est_sig = est0;
			end
		endcase
	end
	
	/* Salidas */
	
	always @* begin
		if (est_act == est0) begin
			do_it_inic = 1;
			do_it_leer = 0;
			en_contadores_hora_g = 0;
			en_contadores_fecha_g = 0;
			en_contadores_timer_g = 0;
			do_it_esc_g = 0;
			ch0_mux2_g = 0;
			est_hora = 0;
			est_fecha = 0;
			est_timer = 0;
				stop_t_g = 0;
			most_cur_g = 1;
		end
		else if (est_act == est1) begin
			do_it_inic = 0;
			do_it_leer = 1;
			en_contadores_hora_g = 0;
			en_contadores_fecha_g = 0;
			en_contadores_timer_g = 0;
			do_it_esc_g = 0;
			ch0_mux2_g = 0;
			est_hora = 0;
			est_fecha = 0;
			est_timer = 0;
				stop_t_g = 0;
			most_cur_g = 1;
		end else if (est_act == est2) begin
			do_it_inic = 0;
			do_it_leer = 0;
			en_contadores_hora_g = 0;
			en_contadores_fecha_g = 0;
			en_contadores_timer_g = 0;
			do_it_esc_g = 0;
			ch0_mux2_g = 0;
			est_hora = 0;
			est_fecha = 0;
			est_timer = 0;
				stop_t_g = 0;
			most_cur_g = 1;
		end else if (est_act == est3) begin
			do_it_inic = 0;
			do_it_leer = 0;
			en_contadores_hora_g = 1;
			en_contadores_fecha_g = 0;
			en_contadores_timer_g = 0;
			do_it_esc_g = 0;
			ch0_mux2_g = 1;
			est_hora = 0;
			est_fecha = 0;
			est_timer = 0;
				stop_t_g = 0;
			most_cur_g = 1;
		end else if (est_act == est4) begin
			do_it_inic = 0;
			do_it_leer = 0;
			en_contadores_hora_g = 0;
			en_contadores_fecha_g = 1;
			en_contadores_timer_g = 0;
			do_it_esc_g = 0;
			ch0_mux2_g = 1;
			est_hora = 0;
			est_fecha = 0;
			est_timer = 0;
				stop_t_g = 0;
			most_cur_g = 1;
		end else if (est_act == est5) begin
			do_it_inic = 0;
			do_it_leer = 0;
			en_contadores_hora_g = 0;
			en_contadores_fecha_g = 0;
			en_contadores_timer_g = 1;
			do_it_esc_g = 0;
			ch0_mux2_g = 1;
			est_hora = 0;
			est_fecha = 0;
			est_timer = 0;
				stop_t_g = 0;
			most_cur_g = 1;
		end else if (est_act == est6) begin
			do_it_inic = 0;
			do_it_leer = 0;
			en_contadores_hora_g = 0;
			en_contadores_fecha_g = 0;
			en_contadores_timer_g = 0;
			do_it_esc_g = 1;
			ch0_mux2_g = 0;
			most_cur_g = 1;
			if (est_pas == est3) begin
				est_hora = 1;
				est_fecha = 0;
				est_timer = 0;
					stop_t_g = 0;
			end else if (est_pas == est4) begin
				est_hora = 0;
				est_fecha = 1;
				est_timer = 0;
					stop_t_g = 0;
			end else if (est_pas == est5) begin
				est_hora = 0;
				est_fecha = 0;
				est_timer = 1;
					stop_t_g = 0;
			end else if (est_pas == est7) begin
				est_hora = 0;
				est_fecha = 0;
				est_timer = 0;
					stop_t_g = 1;
			end else begin
				est_hora = 0;
				est_fecha = 0;
				est_timer = 0;
					stop_t_g = 0;
			end
		end else if (est_act == est7) begin
			do_it_inic = 0;
			do_it_leer = 0;
			en_contadores_hora_g = 0;
			en_contadores_fecha_g = 0;
			en_contadores_timer_g = 1;
			do_it_esc_g = 0;
			ch0_mux2_g = 0;
			est_hora = 0;
			est_fecha = 0;
			est_timer = 0;
				stop_t_g = 0;
			most_cur_g = 0;
		end else begin
			do_it_inic = 0;
			do_it_leer = 0;
			en_contadores_hora_g = 0;
			en_contadores_fecha_g = 0;
			en_contadores_timer_g = 0;
			do_it_esc_g = 0;
			ch0_mux2_g = 0;
			est_hora = 0;
			est_fecha = 0;
			est_timer = 0;
				stop_t_g = 0;
			most_cur_g = 1;
		end
	end
	
	
	assign ch1_mux2_g = ch1_mux2_l;
	assign ch1_mux1_g = ch1_mux1_e;
	
	assign dat_esc_init_g = dat_esc_init_i;
	assign dat_esc_zero_g = dat_esc_zero_i;
	
	assign dir_st2_g = dir_st2_i;
	assign dir_com_c_g = dir_com_c_e;
	assign dir_com_t_g = dir_com_t_e;
	assign dir_tim_mask_g = dir_tim_mask_e;
	
	assign dat_lect_seg_g = dat_lect_seg_l;
	assign dat_lect_min_g = dat_lect_min_l;
	assign dat_lect_hora_g = dat_lect_hora_l;
	assign dat_lect_dia_g = dat_lect_dia_l;
	assign dat_lect_mes_g = dat_lect_mes_l;
	assign dat_lect_anio_g = dat_lect_anio_l;
	assign dat_lect_seg_tim_g = dat_lect_seg_tim_l;
	assign dat_lect_min_tim_g = dat_lect_min_tim_l;
	assign dat_lect_hora_tim_g = dat_lect_hora_tim_l;
	
	assign dat_esc_seg_g = dat_esc_seg_e;
	assign dat_esc_min_g = dat_esc_min_e;
	assign dat_esc_hora_g = dat_esc_hora_e;
	assign dat_esc_dia_g = dat_esc_dia_e;
	assign dat_esc_mes_g = dat_esc_mes_e;
	assign dat_esc_anio_g = dat_esc_anio_e;
	assign dat_esc_seg_tim_g = dat_esc_seg_tim_e;
	assign dat_esc_min_tim_g = dat_esc_min_tim_e;
	assign dat_esc_hora_tim_g = dat_esc_hora_tim_e;
	
	assign dat_tim_en_g = dat_tim_en_e;
	assign dat_tim_mask_g = dat_tim_mask_e;
	
	
	assign a_d_g = (est_act == 0) ? a_d_i : ((est_act == 1) ? a_d_l : a_d_e);
	assign cs_g = (est_act == 0) ? cs_i: ((est_act == 1) ? cs_l : cs_e);
	assign rd_g = (est_act == 0) ? rd_i : ((est_act == 1) ? rd_l : rd_e);
	assign wr_g = (est_act == 0) ? wr_i : ((est_act == 1) ? wr_l : wr_e);
	assign ch0_mux1_g = (est_act == 0) ? ch0_mux1_i : ((est_act == 1) ? ch0_mux1_l : ch0_mux1_e);
	assign buffer_activo_g = (est_act == 0) ? buffer_activo_i : ((est_act == 1) ? buffer_activo_l : buffer_activo_e);
	assign dir_com_cyt_g = (est_act == 0) ? dir_com_cyt_i : dir_com_cyt_l;
	assign dir_seg_g = (est_act == 0) ? dir_seg_i : ((est_act == 1) ? dir_seg_l : dir_seg_e);
	assign dir_min_g = (est_act == 0) ? dir_min_i : ((est_act == 1) ? dir_min_l : dir_min_e);
	assign dir_hora_g = (est_act == 0) ? dir_hora_i : ((est_act == 1) ? dir_hora_l : dir_hora_e);
	assign dir_dia_g = (est_act == 0) ? dir_dia_i : ((est_act == 1) ? dir_dia_l : dir_dia_e);
	assign dir_mes_g = (est_act == 0) ? dir_mes_i : ((est_act == 1) ? dir_mes_l : dir_mes_e);
	assign dir_anio_g = (est_act == 0) ? dir_anio_i : ((est_act == 1) ? dir_anio_l : dir_anio_e);
	assign dir_seg_tim_g = (est_act == 0) ? dir_seg_tim_i : ((est_act == 1) ? dir_seg_tim_l : dir_seg_tim_e);
	assign dir_min_tim_g = (est_act == 0) ? dir_min_tim_i : ((est_act == 1) ? dir_min_tim_l : dir_min_tim_e);
	assign dir_hora_tim_g = (est_act == 0) ? dir_hora_tim_i : ((est_act == 1) ? dir_hora_tim_l : dir_hora_tim_e);
	assign dir_tim_en_g = (est_act == 0) ? dir_tim_en_i : dir_tim_en_e;
	assign dat_59_g = dat_59_i;
	
endmodule