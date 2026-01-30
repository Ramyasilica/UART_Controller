# UART_Controller

🌍 Welcome World

Welcome to my **first GitHub repository** 🎉
This project is a simple and complete implementation of the **UART (Universal Asynchronous Receiver Transmitter) protocol** using **Verilog HDL**, verified through simulation.

This repository is created to learn, implement, and understand **serial communication** at the RTL level using FPGA-style design.

📌 What is UART?
UART (**Universal Asynchronous Receiver Transmitter**) is a serial communication protocol used to transfer data between two devices without sharing a clock signal.

Instead of a clock, UART relies on:
* A predefined **baud rate**
* **Start and stop bits** to frame data

**Typical baud rates** include: 300, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200 bps.
These define the speed of data transfer between devices.

UART is commonly used in:
* Embedded systems
* Microcontrollers
* FPGA communication
* Debugging

## Project Overview

This repository contains:
* UART **Transmitter (TX)**
* UART **Receiver (RX)**
* Testbench for simulation verification

The design converts:
* **Parallel data → Serial data** (TX)
* **Serial data → Parallel data** (RX)

The transmitter output is connected to the receiver input to verify correct operation.

## 🚀 UART Transmitter (TX)

## TX Signals

* `tx_data[7:0]` – 8-bit input data
* `tx_start` – Starts transmission
* `tx` – Serial output line
* `tx_busy` – High while transmitting
* `clk` – System clock
* `rst` – Reset

## TX Working

1. `tx_start` triggers transmission
2. Start bit (`0`) is sent
3. 8 data bits are transmitted (LSB first)
4. Stop bit (`1`) is sent
5. `tx_busy` goes low after completion


## UART Receiver (RX)

## RX Signals

* `rx` – Serial input line
* `rx_data[7:0]` – Received data
* `rx_done` – Indicates reception complete
* `clk` – System clock
* `rst` – Reset

## RX Working

1. Receiver detects the start bit
2. Samples incoming bits at baud rate
3. Reconstructs 8-bit data
4. Asserts `rx_done` after successful reception


## UART Frame Diagram

Here’s a visual representation of a typical UART frame:

| Start | Data Bit 0 | Data Bit 1 | ... | Data Bit 7 | Stop |
|   0   |     D0     |     D1     | ... |     D7     |  1   |


* Start bit = 0
* Data bits = LSB first (D0 → D7)
* Stop bit = 1
* Optional parity bit is not implemented here

## 📊 Simulation Results

From the simulation waveform:

* `tx_data` is set to **0xA5**
* `tx_start` initiates transmission
* `tx_busy` stays high during data transfer
* `tx` shows correct UART frame
* Receiver captures the same value:

  * `rx_data = 0xA5`
  * `rx_done` asserts after reception

✅ This confirms correct **UART transmission and reception**


 🧾 Conclusion

This repository demonstrates a working UART protocol implementation using Verilog HDL. The successful simulation proves correct framing, timing, and data integrity, making this a solid starting point for serial communication projects.

## 🖼️ Output Waveform

![image alt](https://github.com/Ramyasilica/UART_Controller/blob/569c0deb0449b136a1d70d78d47c354860e16bb5/Uart_Controller.jpg)

## Thank you for visiting!

This is my **first repository**, and more projects will be added soon 🚀
Feel free to explore, learn, and suggest improvements.

