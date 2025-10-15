# DDS – Introduction to Digital Chip Design

This repository contains my work for the **DDS (Digital Design Systems)** course, including RTL design, low-level logic implementations, and behavioral models using SystemVerilog.  
The goal of this project is to learn digital design from the fundamentals (gates, half adders, D flip-flops) up to parameterized counters and testbenches.

---

##Project Structure
```bash
DDS/
├── rtl/                      # All synthesizable designs
│   ├── basic_gates/          # AND, OR, XOR, MUX, etc.
│   ├── arithmetic/           # Half adder, full adder, ripple adders
│   ├── sequential/           # DFF, registers, shift registers
│   ├── counter/              # Parametric + low-level counters
│   ├── fsm/                  # Finite State Machine designs
│   ├── datapath_control/     # Datapath + controller integration
│   └── top_level/            # More advanced/system-level modules
│
├── tb/                       # Testbenches for each module
│   ├── basic_gates/
│   ├── arithmetic/
│   ├── sequential/
│   ├── counter/
│   ├── fsm/
│   ├── datapath_control/
│   └── top_level/
│
├── sim/                      # Simulation scripts, Makefile flows
│   ├── Makefile
│   ├── run.do / .tcl
│   └── waveforms/            # .fsdb/.vcd/.diag files
│
├── docs/                     # Documentation, notes, diagrams
│   ├── block_diagrams/
│   ├── design_notes.md
│   └── course_outline.md
│
├── scripts/                  # Helper scripts (Python, bash, TCL)
│
├── synthesis/ (later)        # Synthesis scripts / reports
│
├── README.md                 # Project overview
└── LICENSE (optional)
```

## ▶ How to Run Simulations

### Without GUI:
```bash
make tb_counter_4bit
make tb_counter_hdl

```
##Tools Used

SystemVerilog
Cadence Xcelium (xrun)
Cocotb (Python-based testbench framework)
Makefile for automation
Git + GitHub for version control


Author - Rose Maina
