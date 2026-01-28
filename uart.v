`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/01/2025 08:25:53 PM
// Design Name: 
// Module Name: uart
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
    module uart (
    input  wire       clk,
    input  wire       rst,
    input  wire       tx_start,
    input  wire [7:0] tx_data,
    output reg        tx,
    output reg        tx_busy,
    output reg [7:0]  rx_data,
    output reg        rx_done
);

    // Very fast baud for <500 ns simulation
    localparam BAUD_DIV = 4;

    // ----- TX -----
    reg [3:0] tx_cnt = 0;
    reg [3:0] tx_idx = 0;
    reg [9:0] tx_shift = 10'b1111111111;

    // ----- RX -----
    reg [3:0] rx_cnt = 0;
    reg [3:0] rx_idx = 0;
    reg [9:0] rx_shift = 0;
    reg       rx_busy = 0;

    initial begin
        rx_data = 8'h00;   // avoid XX at sim start
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx        <= 1'b1;
            tx_busy   <= 0;
            tx_cnt    <= 0;
            tx_idx    <= 0;
            rx_busy   <= 0;
            rx_cnt    <= 0;
            rx_idx    <= 0;
            rx_done   <= 0;
            rx_data   <= 8'h00;
        end else begin
            rx_done <= 0;

            // ---------------- TX START ----------------
            if (tx_start && !tx_busy) begin
                tx_busy  <= 1;
                tx_shift <= {1'b1, tx_data, 1'b0}; // stop + data + start
                tx_idx   <= 0;
                tx_cnt   <= 0;
            end

            // ---------------- TX SHIFT ----------------
            if (tx_busy) begin
                if (tx_cnt == BAUD_DIV-1) begin
                    tx_cnt <= 0;
                    tx     <= tx_shift[tx_idx];
                    tx_idx <= tx_idx + 1;

                    if (tx_idx == 9)
                        tx_busy <= 0;
                end else begin
                    tx_cnt <= tx_cnt + 1;
                end
            end

            // ---------------- RX START DETECT ----------------
            if (!rx_busy && tx == 0) begin
                rx_busy <= 1;
                rx_cnt  <= BAUD_DIV/2;  // mid-bit sampling
                rx_idx  <= 0;
            end

            // ---------------- RX SHIFT ----------------
            else if (rx_busy) begin
                if (rx_cnt == BAUD_DIV-1) begin
                    rx_cnt <= 0;

                    rx_shift[rx_idx] <= tx;
                    rx_idx <= rx_idx + 1;

                    if (rx_idx == 9) begin
                        rx_busy <= 0;
                        rx_data <= rx_shift[8:1]; // only data bits
                        rx_done <= 1;
                    end
                end else begin
                    rx_cnt <= rx_cnt + 1;
                end
            end

        end
    end
endmodule

  