`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2018 15:27:44
// Design Name: 
// Module Name: Display
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


module Display(
	input logic clk, reset, reset_2,
	input logic [31:0] number,
	input logic [7:0] AN_ON,
	output logic [6:0] sevenSeg,
	output logic [7:0] AN
    );
    
    logic [7:0] AN_next, AN_trans;
    logic [31:0] number_next;
    logic [3:0] number_display;
    logic clk_out;
    logic [31:0] number_move;
    
    
///////////// Divisor de Reloj //

localparam C_MAX = 'd62499;

logic [26:0] counter = 'd0;

always_ff @(posedge clk)
    begin
    if (reset == 1'b1)
        begin
        counter <= 'd0;
        clk_out <= 0;
        end
    else
        if (counter == C_MAX)
            begin
            counter <= 'd0;
            clk_out <= ~clk_out;
            end
        else
            begin
            counter <= counter + 'd1;
            clk_out <= clk_out;
            end
        end
        
//A partir de ahora, se trabajara con clk_out como reloj//
///////////// Selector de anodo //

assign AN = AN_trans | AN_ON;

always_ff @(posedge clk_out) 
	AN_trans <= AN_next;
	
always_comb
	if(reset_2)
		AN_next = 8'b1111_1110; 
	else
		AN_next = {AN_trans[6:0],AN_trans[7]};

///////////// Selector de numero en display //

assign number_display = number_move [3:0];

always_ff @(posedge clk_out)
	number_move <= number_next;	
	
always_comb
	if(reset_2)
		number_next = number;
	else
		number_next = {number_move[3:0],number_move[31:4]};
		
///////////// Pasar el numero a Display //
	
always_comb begin
	case (number_display)
    4'd0:	sevenSeg = 7'b1000000;	
    4'd1:	sevenSeg = 7'b1111001;
    4'd2:	sevenSeg = 7'b0100100;
    4'd3:	sevenSeg = 7'b0110000;
    4'd4:	sevenSeg = 7'b0011001;
    4'd5:	sevenSeg = 7'b0010010;
    4'd6:	sevenSeg = 7'b0000010;
    4'd7:	sevenSeg = 7'b1111000;
    4'd8:	sevenSeg = 7'b0000000;
    4'd9:	sevenSeg = 7'b0010000;
    4'd10:	sevenSeg = 7'b0001000;
    4'd11:	sevenSeg = 7'b0000011;
    4'd12:	sevenSeg = 7'b1000110;
    4'd13:	sevenSeg = 7'b0100001;
    4'd14:	sevenSeg = 7'b0000110;
    4'd15:	sevenSeg = 7'b0001110;
    default: sevenSeg = 7'b1111111;
    endcase
    end
	
endmodule
