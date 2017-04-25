`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:39:35
// Design Name: 
// Module Name: FSM_ESC_RTC
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


module FSM_ESC_RTC(
   input wire clk, reset,
	input wire do_it_esc,
	
	input wire estado_hora,
	input wire estado_fecha,
	input wire estado_timer,
	input wire stop_t,
	
	output wire a_d, cs, rd, wr, // Señales de ctrl RTC.
	
	output reg ch0_mux1,
	output reg ch1_mux1,
	
	output reg dir_com_c,
	output reg dir_com_t,
	output reg dir_tim_en,
	output reg dir_tim_mask,
	
	output reg dir_seg,
	output reg dir_min,
	output reg dir_hora,
	output reg dir_dia,
	output reg dir_mes,
	output reg dir_anio,
	output reg dir_seg_tim,
	output reg dir_min_tim,
	output reg dir_hora_tim,
	
	output reg dat_esc_seg,
	output reg dat_esc_min,
	output reg dat_esc_hora,
	output reg dat_esc_dia,
	output reg dat_esc_mes,
	output reg dat_esc_anio,
	output reg dat_esc_seg_tim,
	output reg dat_esc_min_tim,
	output reg dat_esc_hora_tim,
	
	output reg dat_tim_en,
	output reg dat_tim_mask,
	
	output reg buffer_activo
   );
	
	reg w_r;
	reg do_it;
	wire read_data;  // Bandera que indica que puede leer el dato.
	wire send_data; // Bandera que indica enviar el dato.
	wire send_add;	// Bandera que indica enviar dirección.
	
	FSM_W_R Inst0(
		.clk(clk),
		.reset(reset),
		.w_r(w_r),
		.do_it(do_it),
		.a_d(a_d),
		.cs(cs),
		.rd(rd),
		.wr(wr),
		.read_data(read_data),
		.send_data(send_data),
		.send_add(send_add)
	);
	
		
	/* Estados. */
	localparam est0 = 1'b0, est1 = 1'b1;
	
	reg est_sig;
	reg est_act;
	reg [8:0] contador;
	
	/* Lógica Secuencial */
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			contador <= 9'b000000000;
		end else if (est_act == est0) begin
			contador <= 9'b000000000;
		end else	begin
			contador <= contador + 9'b000000001;
		end
	end
	
	always @(posedge clk, posedge reset) begin
		if (reset) begin
			est_act <= est0;
		end else begin
			est_act <= est_sig;
		end
	end
	
	/* Lógica Combinacional */
	
	always @* begin
		est_sig = est0;
		case(est_act)
			est0: begin
				if (do_it_esc) begin
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			est1: begin
				if (do_it_esc) begin
					est_sig = est1;
				end else begin
					est_sig = est0;
				end
			end
			default: est_sig = est0;
		endcase
	end
	
	/* Salidas */
	
	always @* begin
		if (est_act == est0) begin
			w_r = 1;
			ch0_mux1 = 0;
			ch1_mux1 = 0;
			buffer_activo = 0;
			
			do_it = 0;
			
			dir_com_c = 0;
			dir_com_t = 0;
			dir_tim_en = 0;
			dir_tim_mask = 0;
			
			dir_seg = 0;
			dir_min = 0;
			dir_hora = 0;
			dir_dia = 0;
			dir_mes = 0;
			dir_anio = 0;
			dir_seg_tim = 0;
			dir_min_tim = 0;
			dir_hora_tim = 0;
			
			dat_esc_seg = 0;
			dat_esc_min = 0;
			dat_esc_hora = 0;
			dat_esc_dia = 0;
			dat_esc_mes = 0;
			dat_esc_anio = 0;
			dat_esc_seg_tim = 0;
			dat_esc_min_tim = 0;
			dat_esc_hora_tim = 0;
			
			dat_tim_en = 0;
			dat_tim_mask = 0;
			
		end else if (est_act == est1) begin
			w_r = 1;
			
			do_it = 1;
			
			if (send_add && (~send_data) && (~read_data)) begin
				ch0_mux1 = 1;
				ch1_mux1 = 0;
				buffer_activo = 1;
				
				dat_esc_seg = 0;
				dat_esc_min = 0;
				dat_esc_hora = 0;
				dat_esc_dia = 0;
				dat_esc_mes = 0;
				dat_esc_anio = 0;
				dat_esc_seg_tim = 0;
				dat_esc_min_tim = 0;
				dat_esc_hora_tim = 0;
				dat_tim_mask = 0;
				dat_tim_en = 0;
				if (contador > 215) begin
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					if (estado_hora) begin
						dir_com_c = 1;
						dir_tim_en = 0;
						dir_tim_mask = 0;
						dir_com_t = 0;
					end else if (estado_fecha) begin
						dir_com_c = 1;
						dir_tim_en = 0;
						dir_tim_mask = 0;
						dir_com_t = 0;
					end else if (estado_timer) begin
						dir_com_c = 0;
						dir_tim_en = 1;
						dir_tim_mask = 0;
						dir_com_t = 0;
					end else if (stop_t) begin
						dir_com_c = 0;
						dir_tim_en = 0;
						dir_tim_mask = 1;
						dir_com_t = 0;
					end else begin
						dir_com_c = 0;
						dir_tim_en = 0;
						dir_tim_mask = 0;
						dir_com_t = 0;
					end
				end else if (contador > 172) begin
					dir_seg = 0;
					dir_min = 0;
					dir_hora = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_tim_en = 0;
					if (estado_hora) begin
						dir_com_c = 1;
						dir_com_t = 0;
						dir_tim_mask = 0;
					end else if (estado_fecha) begin
						dir_com_c = 1;
						dir_com_t = 0;
						dir_tim_mask = 0;
					end else if (estado_timer) begin
						dir_com_c = 0;
						dir_com_t = 1;
						dir_tim_mask = 0;
					end else if (stop_t) begin
						dir_com_c = 0;
						dir_com_t = 0;
						dir_tim_mask = 1;
					end else begin
						dir_com_c = 0;
						dir_com_t = 0;
						dir_tim_mask = 0;
					end
				end else if (contador > 129) begin
					dir_seg = 0;
					dir_min = 0;
					dir_dia = 0;
					dir_mes = 0;
					dir_anio = 0;
					dir_seg_tim = 0;
					dir_min_tim = 0;
					dir_hora_tim = 0;
					dir_com_t = 0;
					dir_tim_en = 0;
					if (estado_hora) begin
						dir_com_c = 1;
						dir_tim_mask = 0;
						dir_hora = 0;
					end else if (estado_fecha) begin
						dir_com_c = 1;
						dir_tim_mask = 0;
						dir_hora = 0;
					end else if (estado_timer) begin
						dir_com_c = 0;
						dir_tim_mask = 1;
						dir_hora = 0;
					end else if (stop_t) begin
						dir_com_c = 0;
						dir_tim_mask = 1;
						dir_hora = 0;
					end else begin
						dir_com_c = 0;
						dir_tim_mask = 0;
						dir_hora = 0;
					end
				end else if (contador > 86) begin
					dir_com_c = 0;
					dir_com_t = 0;
					dir_tim_en = 0;
					if (estado_hora) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 1;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 0;
					end else if (estado_fecha) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 1;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 0;
					end else if (estado_timer) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 1;
						dir_tim_mask = 0;
					end else if (stop_t) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 1;
					end else begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 0;
					end
				end else if (contador > 43) begin
					dir_com_c = 0;
					dir_com_t = 0;
					dir_tim_en = 0;
					if (estado_hora) begin
						dir_seg = 0;
						dir_min = 1;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 0;
					end else if (estado_fecha) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 1;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 0;
					end else if (estado_timer) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 1;
						dir_hora_tim = 0;
						dir_tim_mask = 0;
					end else if (stop_t) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 1;
					end else begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 0;
					end
				end else begin
					dir_com_c = 0;
					dir_com_t = 0;
					if (estado_hora) begin
						dir_seg = 1;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 0;
						dir_tim_en = 0;
					end else if (estado_fecha) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 1;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 0;
						dir_tim_en = 0;
					end else if (estado_timer) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 1;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 0;
						dir_tim_en = 0;
					end else if (stop_t) begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 1;
						dir_tim_en = 0;
					end else begin
						dir_seg = 0;
						dir_min = 0;
						dir_hora = 0;
						dir_dia = 0;
						dir_mes = 0;
						dir_anio = 0;
						dir_seg_tim = 0;
						dir_min_tim = 0;
						dir_hora_tim = 0;
						dir_tim_mask = 0;
						dir_tim_en = 0;
					end
				end
			//end
			end else if (send_data && (~send_add) && (~read_data)) begin
				buffer_activo = 1;
				
				dir_seg = 0;
				dir_min = 0;
				dir_hora = 0;
				dir_dia = 0;
				dir_mes = 0;
				dir_anio = 0;
				if (contador > 215) begin
					ch0_mux1 = 1;
					ch1_mux1 = 0;
					
					dat_esc_seg = 0;
					dat_esc_min = 0;
					dat_esc_hora = 0;
					dat_esc_dia = 0;
					dat_esc_mes = 0;
					dat_esc_anio = 0;
					dat_esc_seg_tim = 0;
					dat_esc_min_tim = 0;
					dat_esc_hora_tim = 0;
					dat_tim_mask = 0;
					dir_hora_tim = 0;
					dir_min_tim = 0;
					dir_seg_tim = 0;
					dir_tim_en = 0;
					if (estado_hora) begin
						dir_com_c = 1;
						dat_tim_en = 0;
						dir_tim_mask = 0;
						dir_com_t = 0;
					end else if (estado_fecha) begin
						dir_com_c = 1;
						dat_tim_en = 0;
						dir_tim_mask = 0;
						dir_com_t = 0;
					end else if (estado_timer) begin
						dat_tim_en = 1;
						dir_com_c = 0;
						dir_tim_mask = 0;
						dir_com_t = 0;
					end else if (stop_t) begin
						dat_tim_en = 0;
						dir_com_c = 0;
						dir_tim_mask = 1;
						dir_com_t = 0;
					end else begin
						dat_tim_en = 0;
						dir_com_c = 0;
						dir_tim_mask = 0;
						dir_com_t = 0;
					end
				end else if (contador > 172) begin
					ch0_mux1 = 1;
					ch1_mux1 = 0;
					
					dat_esc_seg = 0;
					dat_esc_min = 0;
					dat_esc_hora = 0;
					dat_esc_dia = 0;
					dat_esc_mes = 0;
					dat_esc_anio = 0;
					dat_esc_seg_tim = 0;
					dat_esc_min_tim = 0;
					dat_esc_hora_tim = 0;
					dat_tim_mask = 0;
					dat_tim_en = 0;
					dir_hora_tim = 0;
					dir_min_tim = 0;
					dir_seg_tim = 0;
					dir_tim_en = 0;
					if (estado_hora) begin
						dir_com_t = 0;
						dir_com_c = 1;
						dir_tim_mask = 0;
					end else if (estado_fecha) begin
						dir_com_t = 0;
						dir_com_c = 1;
						dir_tim_mask = 0;
					end else if (estado_timer) begin
						dir_com_t = 1;
						dir_com_c = 0;
						dir_tim_mask = 0;
					end else if (stop_t) begin
						dir_com_t = 0;
						dir_com_c = 0;
						dir_tim_mask = 1;
					end else begin
						dir_com_t = 0;
						dir_com_c = 0;
						dir_tim_mask = 0;
					end
				end else if (contador > 129) begin
					ch0_mux1 = 1;
					ch1_mux1 = 0;
					
					dat_esc_seg = 0;
					dat_esc_min = 0;
					dat_esc_hora = 0;
					dat_esc_dia = 0;
					dat_esc_mes = 0;
					dat_esc_anio = 0;
					dat_esc_seg_tim = 0;
					dat_esc_min_tim = 0;
					dat_esc_hora_tim = 0;
					dir_com_t = 0;
					dat_tim_en = 0;
					dir_min_tim = 0;
					dir_seg_tim = 0;
					dir_tim_en = 0;
					if (estado_hora) begin
						dat_tim_mask = 0;
						dir_com_c = 1;
						dir_tim_mask = 0;
						dir_hora_tim = 0;
					end else if (estado_fecha) begin
						dat_tim_mask = 0;
						dir_com_c = 1;
						dir_tim_mask = 0;
						dir_hora_tim = 0;
					end else if (estado_timer) begin
						dat_tim_mask = 1;
						dir_com_c = 0;
						dir_tim_mask = 0;
						dir_hora_tim = 0;
					end else if (stop_t) begin
						dat_tim_mask = 0;
						dir_com_c = 0;
						dir_tim_mask = 1;
						dir_hora_tim = 0;
					end else begin
						dat_tim_mask = 0;
						dir_com_c = 0;
						dir_tim_mask = 0;
						dir_hora_tim = 0;
					end
				end else if (contador > 86) begin
					
					ch0_mux1 = 0;
					ch1_mux1 = 1;
					
					dir_com_c = 0;
					dir_com_t = 0;
					dat_tim_mask = 0;
					dat_tim_en = 0;
					dir_hora_tim = 0;
					dir_seg_tim = 0;
					dir_tim_en = 0;
					if (estado_hora) begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 1;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_min_tim = 0;
						dir_tim_mask = 0;
					end else if (estado_fecha) begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 1;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 0;
						dir_min_tim = 0;
					end else if (estado_timer) begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 1;
						dir_tim_mask = 0;
						dir_min_tim = 0;
					end else if (stop_t) begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 1;
						dir_min_tim = 0;
					end else begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 0;
						dir_min_tim = 0;
					end
				end else if (contador > 43) begin
					
					ch0_mux1 = 0;
					ch1_mux1 = 1;
					dir_com_c = 0;
					dir_com_t = 0;
					dat_tim_mask = 0;
					dat_tim_en = 0;
					dir_hora_tim = 0;
					dir_min_tim = 0;
					dir_tim_en = 0;
					if (estado_hora) begin
						dat_esc_seg = 0;
						dat_esc_min = 1;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 0;
						dir_seg_tim = 0;
					end else if (estado_fecha) begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 1;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 0;
						dir_seg_tim = 0;
					end else if (estado_timer) begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 1;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 0;
						dir_seg_tim = 0;
					end else if (stop_t) begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 1;
						dir_seg_tim = 0;
					end else begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 0;
						dir_seg_tim = 0;
					end
				end else begin
									
					ch0_mux1 = 0;
					ch1_mux1 = 1;
					dir_com_c = 0;
					dir_com_t = 0;
					dat_tim_mask = 0;
					dat_tim_en = 0;
					dir_hora_tim = 0;
					dir_min_tim = 0;
					dir_seg_tim = 0;
					if (estado_hora) begin
						dat_esc_seg = 1;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 0;
						dir_tim_en = 0;
					end else if (estado_fecha) begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 1;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 0;
						dir_tim_en = 0;
					end else if (estado_timer) begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 1;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 0;
						dir_tim_en = 0;
					end else if (stop_t) begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 1;
						dir_tim_en = 0;
					end else begin
						dat_esc_seg = 0;
						dat_esc_min = 0;
						dat_esc_hora = 0;
						dat_esc_dia = 0;
						dat_esc_mes = 0;
						dat_esc_anio = 0;
						dat_esc_seg_tim = 0;
						dat_esc_min_tim = 0;
						dat_esc_hora_tim = 0;
						dir_tim_mask = 0;
						dir_tim_en = 0;
					end
				end
			end else begin
				buffer_activo = 0;
				ch0_mux1 = 0;
				ch1_mux1 = 0;
				dir_com_c = 0;
				dir_com_t = 0;
				dir_tim_en = 0;
				dir_tim_mask = 0;
				
				dir_seg = 0;
				dir_min = 0;
				dir_hora = 0;
				dir_dia = 0;
				dir_mes = 0;
				dir_anio = 0;
				dir_seg_tim = 0;
				dir_min_tim = 0;
				dir_hora_tim = 0;
				
				dat_esc_seg = 0;
				dat_esc_min = 0;
				dat_esc_hora = 0;
				dat_esc_dia = 0;
				dat_esc_mes = 0;
				dat_esc_anio = 0;
				dat_esc_seg_tim = 0;
				dat_esc_min_tim = 0;
				dat_esc_hora_tim = 0;
				
				dat_tim_en = 0;
				dat_tim_mask = 0;
			end
		end else begin
			w_r = 1;
			ch0_mux1 = 0;
			ch1_mux1 = 0;
			buffer_activo = 0;
			
			do_it = 0;
			
			dir_com_c = 0;
			dir_com_t = 0;
			dir_tim_en = 0;
			dir_tim_mask = 0;
			
			dir_seg = 0;
			dir_min = 0;
			dir_hora = 0;
			dir_dia = 0;
			dir_mes = 0;
			dir_anio = 0;
			dir_seg_tim = 0;
			dir_min_tim = 0;
			dir_hora_tim = 0;
			
			dat_esc_seg = 0;
			dat_esc_min = 0;
			dat_esc_hora = 0;
			dat_esc_dia = 0;
			dat_esc_mes = 0;
			dat_esc_anio = 0;
			dat_esc_seg_tim = 0;
			dat_esc_min_tim = 0;
			dat_esc_hora_tim = 0;
			
			dat_tim_en = 0;
			dat_tim_mask = 0;
		end
	end
endmodule