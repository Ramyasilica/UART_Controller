`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2025 08:27:06 PM
// Design Name: 
// Module Name: uart_tb
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
module uart_tb;

    reg clk = 0;
    reg rst = 0;
    reg tx_start = 0;
    reg [7:0] tx_data = 8'hA5;

    wire tx;
    wire tx_busy;
    wire [7:0] rx_data;
    wire rx_done;

    uart uut(
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );

    // 10ns Clock
    always #5 clk = ~clk;

    initial begin
        rst = 1;
        #20;
        rst = 0;

        // transmit A5 at 40ns
        #20;
        tx_start = 1;
        #10;
        tx_start = 0;

        // simulation ends before 500 ns
        #500;
        $finish;
    end
endmodule

  

