`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2023 06:39:26 PM
// Design Name: 
// Module Name: debouncer_delayed_top
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


module debouncer_delayed_top
    #(parameter Timer_bits=18)(
    input clk,
    input reset_n,
    input [Timer_bits-1:0] Final_value,
    input noisy,
    output debounced
    );
    wire reset_timer,done_timer;
    Timer #(.N(Timer_bits)) timer1
        (   .clk(clk),
            .Final_value(Final_value),
            .reset_n(reset_timer),
            .done(done_timer) );
    debouncer_delayed_button ddeb
        (   .clk(clk),
            .noisy(noisy),
            .reset_n(reset_n),
            .timer_done(done_timer),
            .reset_timer(reset_timer),
            .debounced(debounced) );
endmodule
