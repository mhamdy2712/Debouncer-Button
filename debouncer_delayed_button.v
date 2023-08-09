`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/04/2023 06:00:53 PM
// Design Name: 
// Module Name: debouncer_delayed_button
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


module debouncer_delayed_button(
    input noisy,
    input reset_n,
    output reset_timer,
    output debounced,
    input clk,
    input timer_done
    );
    parameter s0=0,s1=1,s2=2,s3=3;
    reg [1:0] curr_state,next_state;
    always @(posedge clk,negedge reset_n)
    begin
        if(~reset_n)
            curr_state <= s0;
        else
            curr_state <= next_state;
    end
    always @(*)
    begin
        case(curr_state)
            s0: begin
                    if(~noisy)
                        next_state = s0;
                    else
                        next_state = s1;
                end
            s1: begin
                    if(~noisy)
                        next_state = s0;
                    else if(noisy&timer_done)
                        next_state = s2;
                    else 
                        next_state = s1;
                end
            s2: begin
                    if(noisy)
                        next_state = s2;
                    else
                        next_state = s3;
                end
            s3: begin
                    if(noisy)
                        next_state = s2;
                    else if(~noisy&timer_done)
                        next_state = s0;
                    else
                        next_state = s3;
                end
        endcase
    end
    assign reset_timer = ~(curr_state==s0||curr_state==s2);
    assign debounced = curr_state==s0 ? 0 : curr_state==s2 ? 1 : debounced;
endmodule
