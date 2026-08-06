# Multi-Product Vending Machine using Verilog HDL

A synthesizable Finite State Machine (FSM)-based vending machine controller implemented in Verilog HDL. The design accepts user coins, accumulates the inserted amount, dispenses the selected product when sufficient balance is available, and automatically returns any excess amount as change.

---

## Features

- Finite State Machine (FSM) based controller
- Multi-product vending support
- Coin accumulation logic
- Automatic product dispensing
- Automatic change return
- Synthesizable RTL implementation
- Functional verification using Verilog testbench

---

## Design Overview

The vending machine continuously monitors user inputs and maintains the current balance using a finite state machine. After a product is selected, the controller verifies whether the inserted amount is sufficient.

If the balance is:

- Less than the product price → Waits for additional coins.
- Equal to the product price → Dispenses the product.
- Greater than the product price → Dispenses the product and returns the remaining amount as change.

After every successful transaction, the controller returns to the idle state and is ready for the next customer.

---

## Block Diagram

```
                   +----------------------+
                   |    Coin Inputs       |
                   +----------+-----------+
                              |
                              v
                    +--------------------+
                    | Money Accumulator  |
                    +----------+---------+
                               |
                               v
                    +--------------------+
                    |   FSM Controller   |
                    +----+----------+----+
                         |          |
             Dispense ---+          +--- Change
                         |
                         v
                  Product Output
```

---

## FSM States

- Idle
- Coin Collection
- Amount Verification
- Product Dispense
- Change Return
- Reset to Idle

---

## Directory Structure

```
Vending-Machine/
│
├── rtl/
│   └── vending_machine.v
│
├── tb/
│   └── vending_machine_tb.v
│
├── waveforms/
│   └── simulation.png
│
├── README.md
└── LICENSE
```

---

## Inputs

| Signal | Description |
|---------|-------------|
| clk | System Clock |
| reset | Synchronous Reset |
| coin | Coin Input |
| product_select | Product Selection |

---

## Outputs

| Signal | Description |
|---------|-------------|
| dispense | Product Dispense Signal |
| change | Returned Change |

---

## Functional Verification

The design was verified through simulation using a dedicated Verilog testbench.

The following scenarios were tested:

- Initial reset
- Exact payment
- Insufficient balance
- Excess payment with change return
- Multiple coin insertion
- Multiple product selections
- Consecutive transactions
- State transition verification

---

## Simulation Results

Simulation confirms correct implementation of:

- FSM state transitions
- Coin accumulation
- Product dispensing
- Change calculation
- Reset operation
- Multiple transaction handling

---

## Tools Used

- Verilog HDL
- EDA Playground
- Git
- GitHub

---

## Applications

- Digital System Design
- RTL Design
- FPGA Prototyping
- Digital Logic Education
- VLSI Design Projects

---

## Future Improvements

- Parameterized product prices
- Support for additional coin denominations
- Inventory management
- LCD/7-Segment display interface
- FPGA implementation on Xilinx/Intel boards
- UART-based payment interface

---

## Author

**Shiwani Chaubey**

B.Tech, Electronics and Communication Engineering

National Institute of Technology Patna

