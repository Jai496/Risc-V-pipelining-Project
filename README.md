# RV64I Sequential and Pipelined Processor

Verilog implementation of a 64-bit RV64I processor developed as part of the Intro to Processor Architecture course project.

## Team Members

- Jai Srikar M (2024102041)
- Mohammad Shabaj (2024102016)
- Nelagonda Pavaneswar (2024102063)

---

## Features

### Sequential Processor
- Single-cycle RV64I datapath
- Arithmetic, logical, load/store, and branch instruction support
- 64-bit ALU and register file

### Pipelined Processor
- 5-stage pipeline:
  - IF
  - ID
  - EX
  - MEM
  - WB
- Pipeline registers
- Forwarding unit
- Store data forwarding
- Branch handling support

---

## Supported Instructions

```text
add
sub
and
or
addi
ld
sd
beq
```

---

## Repository Structure

```text
common/       -> Shared hardware modules used by both processors
sequential/   -> Sequential RV64I processor implementation
pipelined/    -> 5-stage pipelined RV64I processor implementation
```


## Tools Used
- Icarus Verilog
- Python
