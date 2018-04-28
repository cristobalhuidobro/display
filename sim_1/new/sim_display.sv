`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.04.2018 17:55:06
// Design Name: 
// Module Name: sim_display
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


module sim_display();

logic clk, reset, reset_2;
logic [31:0] number;
logic [7:0] AN_ON, AN;
logic [6:0] sevenSeg;

Display DUT(.clk(clk), .reset(reset), .reset_2(reset_2), .AN_ON(AN_ON), .AN(AN), .sevenSeg(sevenSeg), .number(number));

always #5 clk = ~clk;

initial begin
clk = 0;
AN_ON = 'b0011_1100;
number = 32'h24000042;
reset = 1;
reset_2 = 1;
#20
reset = 0;
#1800000
reset_2 = 0;
end

endmodule
