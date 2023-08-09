`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2023 06:46:57 PM
// Design Name: 
// Module Name: debouncer_delyaed_tb
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


module debouncer_delyaed_tb(

    );
    reg reset_n;
    parameter clk_cycle=1000;
    reg [17:0] Final_value = 20;
    reg noisy=0;
    wire debounced;         
    reg clk;
    always begin
        Final_value = 20;
        clk=0;
        #(clk_cycle);
        clk=1;
        #(clk_cycle);
    end
    debouncer_delayed_top debouncer(
         .clk(clk),
         .reset_n(reset_n),
         .Final_value(Final_value),
         .noisy(noisy),
         .debounced(debounced)
        );
    initial begin
        Final_value = 20;   
        reset_n=0;
        #(clk_cycle);
        reset_n=1;
        #(12*clk_cycle);
        noisy=1;
        #(2*clk_cycle);
        noisy=0;
        #(2*clk_cycle);
        noisy=1;
        #(3*clk_cycle);
        noisy=0;
        #(2*clk_cycle);
        noisy=1;
        #(80*clk_cycle);
        noisy=1;
        #(3*clk_cycle);
        noisy=0;
        #(2*clk_cycle);
        noisy=1;
        #(3*clk_cycle);
        noisy=0;
        #(2*clk_cycle);
        noisy=1;
        #(3*clk_cycle);
        noisy=0;
        #(80*clk_cycle);
    end
endmodule
