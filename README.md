# APB Protocol Verification using UVM

## Project Description
I built this project to learn the **Universal Verification Methodology (UVM)** and apply it to a real-world protocol. The project focuses on verifying an **APB Slave Memory** module. 

Instead of manually checking waveforms, I developed a complete self-checking testbench that generates constrained-random traffic and uses a scoreboard to verify the data integrity of the RTL.

## Key Features
- **UVM 1.2 Architecture:** Modular structure with Agent, Driver, Monitor, and Scoreboard.
- **Constrained Randomization:** Generates random addresses (0-63) and data to stress-test the memory.
- **Protocol Compliance:** Strictly follows the AMBA APB handshake (IDLE -> SETUP -> ACCESS).
- **Automated Checking:** The scoreboard uses an associative array to store "Expected" data and compares it with "Actual" data from the RTL.

## Tech Stack
- **Languages:** SystemVerilog, UVM 1.2
- **Tools:** EDA Playground, Aldec Riviera-PRO Simulator
- **Protocol:** ARM AMBA APB

## Testbench Structure
- `rtl/`: The APB Slave memory logic.
- `dv/agent/`: Contains the **Driver** (toggling pins), **Monitor** (sampling data), and **Sequencer**.
- `dv/env/`: Contains the **Scoreboard** (verification logic) and the **Environment**.
- `dv/top/`: The physical **Interface** and the top-level testbench module.
- `dv/tests/`: The test case that starts the UVM sequences.

## Verification Results

### 1. Handshake Waveform
The waveform below shows the APB protocol in action.the `psel` signal goes high for the Setup phase, followed by `penable` for the Access phase, confirming the driver is working correctly.

![APB Waveform](apb_uvm_waveform.png)

### 2. Simulation Log
![APB Simulation](apb_uvm_simulation_log.png)

