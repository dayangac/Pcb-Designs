# LED PATTERN GENERATOR ASIC: CHIP 1.0

## NON TECHNICAL INTRO
Dear reader this is the readme file for my first ASIC design a simple led pattern generator that I got inspired to do after I first heard about ASIC and how I could make and then get one manufactured. Hope it catches your interest.  

## TECHNICAL SPECIFICATION DOCUMENT v1.0

**DEVICE TYPE:** Custom Application-Specific Integrated Circuit (ASIC)  
**PROCESS:** Digital CMOS 130nm  
**INTERFACE:** 8-bit I/O with dedicated clock and reset  
**POWER SUPPLY:** 3.3V nominal operation  

## FUNCTIONAL OVERVIEW

The LED Pattern Generator ASIC is a programmable digital circuit designed to produce various illumination patterns for external LED arrays. The device accepts a 2-bit mode selection input and generates an 8-bit synchronized output pattern. Four distinct patterns are available, each optimized for different visual effects and applications.

## ARCHITECTURE

The core consists of a synchronous finite state machine with programmable pattern generator. Internal circuitry includes:
- 8-bit timing counter
- 8-bit pattern output register
- Mode selection decoder
- Linear Feedback Shift Register (LFSR)
- Clock synchronization logic

## MODES OF OPERATION

### MODE 00: BINARY COUNTER
Sequential binary counting pattern incrementing at programmed intervals.  
**OUTPUT SEQUENCE:** 00000001 -> 00000010 -> 00000011 -> ...

### MODE 01: KNIGHT RIDER SCAN  
Bidirectional shifting pattern reminiscent of automotive scanning effects.  
**OUTPUT SEQUENCE:** 00000001 -> 00000010 -> 00000100 -> ... -> 10000000 -> 01000000 -> ...

### MODE 02: PSEUDO-RANDOM
8-bit LFSR implementation with optimized taps at bits 7,5,4,3.  
**CHARACTERISTIC POLYNOMIAL:** x^8 + x^7 + x^5 + x^4 + x^3 + 1

### MODE 03: ALTERNATING PATTERN
Toggle between complementary patterns at fixed intervals.  
**OUTPUT SEQUENCE:** 01010101 <-> 10101010

## TIMING CHARACTERISTICS

- **CLOCK FREQUENCY:** DC to 50MHz
- **PATTERN UPDATE RATE:** Programmable via internal counter
- **PROPAGATION DELAY:** <20ns
- **SETUP TIME:** 10ns
- **HOLD TIME:** 5ns

## DESIGN PROCESS

The LED Pattern Generator ASIC was developed through a systematic hardware design methodology:

1. **Requirements Analysis**
   - Defined four distinct LED pattern modes
   - Established timing and interface requirements
   - Determined I/O constraints

2. **RTL Design**
   - Created modular Verilog HDL implementation
   - Implemented synchronous state machine architecture
   - Developed LFSR for pseudo-random pattern generation
   - Established clean clock domain for predictable timing

3. **Functional Verification**
   - Developed comprehensive testbench for all operating modes
   - Performed clock-accurate simulation with Icarus Verilog
   - Verified behavior through waveform analysis with GTKWave
   - Confirmed all modes function as specified

4. **Synthesis**
   - Performed logic synthesis to generate gate-level netlist
   - Optimized for area and power efficiency
   - Analyzed timing constraints
   - Generated circuit schematic for visualization

5. **Verification**
   - Validated synthesized netlist against RTL behavior
   - Performed post-synthesis timing analysis
   - Confirmed functionality across all operating modes

## SIMULATION RESULTS

All pattern modes were successfully verified through functional simulation:

- **Binary Counter Mode:** Properly increments through sequential values
- **Knight Rider Mode:** Demonstrates correct bidirectional shifting behavior
- **LFSR Mode:** Produces pseudo-random patterns without repeating in short sequence
- **Alternating Mode:** Toggles between complementary patterns at correct intervals
