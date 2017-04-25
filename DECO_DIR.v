`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.04.2017 01:35:23
// Design Name: 
// Module Name: DECO_DIR
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


module DECO_DIR(
	input wire [1:0] dir_bin,
	input wire en_cont_hora, en_cont_fecha, en_cont_timer,
	input wire cursor,
	output wire en_seg, en_min, en_hora, en_dia, en_mes, en_anio, en_seg_t, en_min_t, en_hora_t
    );
	
	reg dir0, dir1, dir2;
	
	always @* begin
		case(dir_bin)
			2'b00: begin
				dir0 = 1;
				dir1 = 0;
				dir2 = 0;
			end
			2'b01: begin
				dir0 = 0;
				dir1 = 1;
				dir2 = 0;
			end
			2'b10: begin
				dir0 = 0;
				dir1 = 0;
				dir2 = 1;
			end
			default: begin
				dir0 = 0;
				dir1 = 0;
				dir2 = 0;
			end
		endcase
	end
	
	assign en_seg = dir2 & en_cont_hora & cursor;
	assign en_min = dir1 & en_cont_hora & cursor; 
	assign en_hora = dir0 & en_cont_hora & cursor;
	assign en_dia = dir0 & en_cont_fecha & cursor;
	assign en_mes = dir1 & en_cont_fecha & cursor;
	assign en_anio = dir2 & en_cont_fecha & cursor;
	assign en_seg_t = dir2 & en_cont_timer & cursor;
	assign en_min_t = dir1 & en_cont_timer & cursor;
	assign en_hora_t = dir0 & en_cont_timer & cursor;

endmodule