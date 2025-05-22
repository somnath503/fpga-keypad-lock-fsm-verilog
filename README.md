# FPGA Keypad Lock System using FSM (Verilog)

This project implements a **Keypad Lock System** on FPGA using a **Finite State Machine (FSM)** designed in **Verilog** and simulated using **Xilinx Vivado**. The system mimics a digital password lock that takes keypad input, checks it against a preset password, and unlocks accordingly.

---

## 🔐 Project Overview

- **Technology Used:** Verilog HDL  
- **Toolchain:** Vivado ML Standard Edition  
- **Target Board:** Xilinx 7 Series (or simulator only)  
- **Concepts Covered:** FSM design, Verilog modules, simulation, testbenching  

---

## 📘 How It Works

1. **FSM States**: `IDLE → INPUT → CHECK → UNLOCKED`
2. **Inputs**:
   - 4-bit Keypad (`key_in`)
   - `key_valid` signal
   - `clk`, `reset`
3. **Outputs**:
   - `unlocked` (1-bit LED output)
4. **Password**: Sequence of 4 keys (`4'd0`, `4'd1`, `4'd2`, `4'd3`)

---

## ▶️ Simulation

- Simulation done using Vivado’s built-in simulator.
- Keypad input is fed via `testbench.v`.
- Unlocks only when all 4 digits match the correct sequence.

## 🚀 Future Enhancements

- Limit login attempts (security feature)
- Add timeout/reset feature
- Changeable password mode
- LED or buzzer feedback
- Interface 7-segment display
  
