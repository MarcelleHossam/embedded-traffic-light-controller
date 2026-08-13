# Embedded Traffic Light Controller
Assembly Language + Arduino C++ | Embedded Systems | Computer Organization | Real-Time Control

## 📌 Overview
This project implements a simple embedded traffic light controller using Assembly Language and Arduino C++.
The system models a real-world traffic light as a continuous state machine:
RED → YELLOW → GREEN → RED → ...

# Embedded Traffic Light Controller
 Assembly Language + Arduino C++ | Embedded Systems | Computer Organization | Real-Time Control

## 📌 Overview
This project implements a simple embedded traffic light controller using Assembly Language and Arduino C++.
It demonstrates how low-level programming concepts, timing mechanisms, state sequencing, and hardware I/O can be used to implement a real-time control system.
The Assembly implementation focuses on low-level control and BIOS timer services, while the Arduino implementation provides a hardware-oriented implementation using digital output pins.

## 🎯 Project Objectives
Implement a traffic light control sequence.
Demonstrate state-machine logic.
Implement timed state transitions.
Explore low-level Assembly programming.
Use BIOS timer services for Assembly-based timing.
Control physical output pins using Arduino.
Compare low-level and high-level approaches to embedded control.

## 🚦 Traffic Light Sequence
The controller continuously cycles through three states:

State	Duration	Action
🔴 Red	5 seconds	Stop
🟡 Yellow	2 seconds	Prepare to go
🟢 Green	5 seconds	Go

The sequence repeats continuously.

       ┌───────────────┐
       │               ▼
    🔴 RED ───────► 🟡 YELLOW
       ▲                │
       │                ▼
       └──────────── 🟢 GREEN
       
## 🧠 Computer Organization Concepts
This project demonstrates several concepts related to computer organization and low-level programming:
CPU instruction execution
Registers
Memory addressing
Instruction Pointer (IP)
Stack operations
Procedure calls and returns
Interrupts
BIOS services
Timer-based delays
Hardware I/O
Continuous control loops
The Assembly program uses ORG 100H and is structured as a DOS COM-style program.

## 💻 Assembly Implementation
The Assembly implementation uses a continuous MAIN_LOOP to control the traffic-light states.

The sequence is:
MAIN_LOOP
    │
    ├── RED
    │
    ├── YELLOW
    │
    ├── GREEN
    │
    └── JMP MAIN_LOOP

The state sequence is implemented using separate blocks for RED, YELLOW, and GREEN, with each state calling the BIOS-based delay procedure before moving to the next state.

BIOS Timer
Timing is implemented using BIOS interrupt INT 1AH.
The program reads the current BIOS timer tick count, calculates a target time, and waits until the target is reached.

Current Time
     │
     ▼
Add Required Delay
     │
     ▼
Target Time
     │
     ▼
Check Current Time
     │
     ├── Current < Target → WAIT
     │
     └── Current ≥ Target → Continue

The delay procedure saves the required registers, reads the timer, calculates the target, repeatedly checks the current timer value, and then restores the registers before returning.

Timer Values
The Assembly implementation uses BIOS timer ticks of approximately 18.2 ticks per second.
RED    → 91 ticks ≈ 5 seconds
YELLOW → 36 ticks ≈ 2 seconds
GREEN  → 91 ticks ≈ 5 seconds

These values are defined using assembler constants:
DELAY_LONG_TICKS  EQU 91
DELAY_SHORT_TICKS EQU 36

## ⚙️ Assembly Interrupts
The Assembly implementaion uses several system interrupts:
Interrupt	Purpose
INT 10H	BIOS video services
INT 21H	DOS services / text output
INT 1AH	BIOS timer service
The program uses INT 21H with function 09H to display the current traffic-light state.

## 🖥️ State Output
The Assembly implementation displays the current state using messages:
STATE: RED (Stopping)
STATE: YELLOW (Preparing for GO)
STATE: GREEN (Go)
These messages are stored as byte-defined strings and printed through the DOS display service.

## 🔌 Arduino Implementation
The Arduino implementation provides a hardware-oriented version of the traffic light controller.
Three digital output pins are used:

const int RED_PIN = 13;
const int YELLOW_PIN = 12;
const int GREEN_PIN = 11;
The pins are configured as outputs during setup().


## 🔧 Hardware Interface
The Arduino implementation uses digital output pins to control the traffic-light LEDs.

Component	Arduino Pin
🔴 Red LED	13
🟡 Yellow LED	12
🟢 Green LED	11
The implementation uses digitalWrite() to control the LED states.

## 🧪 Testing
The system was tested by observing the repeated traffic-light sequence and verifying the timing and state transitions.

Expected behavior:
RED    → 5 seconds
YELLOW → 2 seconds
GREEN  → 5 seconds
RED    → ...

The Arduino Serial Monitor can also be used to observe the current state:
STATE: RED (Stopping)
STATE: YELLOW (Preparing for GO)
STATE: GREEN (Go)

## 📊 Technologies Used
Assembly Language
Arduino C++
Arduino
BIOS Interrupts
DOS Interrupts
Timer-Based Control
Digital I/O
State-Machine Logic
Embedded Systems Concepts
Computer Organization
