# Stack HAT

## Introduction

QUARK is a simple dual-stack CPU instruction set architecture (ISA) that can be extended.

QUARK uses Head-and-tail instruction format, described in [Hedi01](http://www.cs.berkeley.edu/~krste/papers/hat-cases2001.pdf)

64-bit instraction word

![instr64](https://rawgit.com/drom/quark/master/instr64_be.svg)

![ISA](https://rawgit.com/drom/quark/master/isa.svg)

## Instructions

QUARK has integer data-path width 32, 64 or 128.

It has two stack units data stack (DS) and return stack (RS) of base width and configurable depth.

Each instruction has 4-bit `Head` part that defines following side effects:
 - Stack effect (DS and RS) change of the stack depth and marked position
 - Load / Store effect
 - Control flow change (branch)
 - Size of `Tail`

Each instruction has 4, 8, 16 or 32 bit `Tail`.

The following table describes  

| N | name   | description         | tail | tail           | DS                    | RS
|---| ------ | ------------------- | ---- | -------------- | --------------------- | --------
| 0 | LIT4   | push literal to DS  | 4    | imm4           | ( -- n )              |
| 1 | LIT8   | --//--              | 8    | imm8           | ( -- n )              |
| 2 | LIT16  | --//--              | 16   | imm16          | ( -- n )              |
| 3 | LIT32  | --//--              | 32   | imm32          | ( -- n )              |
| 4 | BRANCH | branch              | 4    | condition      | ( addr -- )           |
| 5 |        |                     |      |                |                       |
| 6 |        |                     |      |                |                       |
| 7 | CALL   | subroutine call     |      |                | ( addr -- )           | ( -- pc )
| 8 | LOAD   | load from memory    | 4    | load type      | ( addr -- data )      |
| 9 | PICK   | copy Nth DS element | 4    | element number | ( -- n )              |
| A | DUP    | copy DS top         |      |                | ( n -- n n )          |
| B | R>     | move RS top -> DS   |      |                | ( -- n )              | ( n -- )
| C | STORE  | store to the memory | 4    | store type     | ( data addr -- addr ) |
| D | ALU    | ALU operations      | 4    | operation      | ( a b -- c )          |
| E | DROP   | DS pop              |      |                | ( n -- )              |
| F | >R     | move DS top -> RS   |      |                | ( n -- )              | ( -- n )

## imm4, imm8, imm16, imm32

Sign extended immediate value that will be pushed into DS.

## BRANCH Conditions

| N | name | description
|---|------|------------
| 0 | JMP  | unconditional
| 1 | BDZ  | second element of DS is equal 0
| 2 | DRZ  | top element on RS is equal 0

## Load type

| N | name     | description
|---|----------|------------
| 0 | load8_s  | load 1 byte with sign-extention
| 1 | load8_u  | load 1 byte zero extended
| 2 | load16_s | load 2 bytes with sign-extention
| 3 | load16_u | load 2 bytes zero extended
| 4 | load32_s | load 4 bytes with sign-extention
| 5 | load32_u | load 4 bytes zero extended
| 6 | load64_s | load 8 bytes with sign-extention
| 7 | load64_u | load 8 bytes zero extended
| 8 | load128  | load 16 bytes

```
isa32:  0 1 2 3 4
isa64:  0 1 2 3 4 5 6
isa128: 0 1 2 3 4 5 6 7 8
```

## Stores

| N | name     | description
|---|----------|------------
| 0 | store8   | store 1 byte
| 1 | store16  | store 2 bytes
| 2 | store32  | store 4 bytes
| 3 | store64  | store 8 bytes
| 4 | store128 | store 16 bytes

```
isa32:  0 1 2
isa64:  0 1 2 3
isa128: 0 1 2 3 4
```


## ALU

| N | name  | description
|---|-------|------------
| 0 | add   | sign-agnostic addition
| 1 | sub   | sign-agnostic subtraction
| 2 | ssub  | swap and sign-agnostic subtraction
| 3 | and   | sign-agnostic bitwise and
| 4 | or    | sign-agnostic bitwise inclusive or
| 5 | xor   | sign-agnostic bitwise exclusive or
| 6 | shl   | sign-agnostic shift left
| 7 | shr_u | zero-replicating (logical) shift right
| 8 | shr_s | sign-replicating (arithmetic) shift right
| 9 | rotl  | sign-agnostic rotate left
| 10| rotr  | sign-agnostic rotate right
|   |       |
|   | mul   | sign-agnostic multiplication
|   | div_s | signed division (result is truncated toward zero)
|   | div_u | unsigned division (result is floored)
|   | rem_s | signed remainder (result has the sign of the dividend)
|   | rem_u | unsigned remainder
|   | eq    | sign-agnostic compare equal
|   | ne    | sign-agnostic compare unequal
|   | lt_s  | signed less than
|   | le_s  | signed less than or equal
|   | lt_u  | unsigned less than
|   | le_u  | unsigned less than or equal
|   | gt_s  | signed greater than
|   | ge_s  | signed greater than or equal
|   | gt_u  | unsigned greater than
|   | ge_u  | unsigned greater than or equal
|   | clz   | sign-agnostic count leading zero bits (All zero bits are considered leading if the value is zero)
|   | ctz   | sign-agnostic count trailing zero bits (All zero bits are considered trailing if the value is zero)
|   | popcnt| sign-agnostic count number of one bits
|   | eqz   | compare equal to zero (return 1 if operand is zero, 0 otherwise)
