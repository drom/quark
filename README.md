# Stack HAT

## Introduction

QUARK is a simple dual-stack CPU instruction set architecture (ISA) that can be extended.

QUARK uses Head-and-tail instruction format, described in [Hedi01](http://www.cs.berkeley.edu/~krste/papers/hat-cases2001.pdf)

![ISA](https://rawgit.com/drom/quark/master/isa.svg)

## Instructions

QUARK has integer data-path width 32, 64 or 128.

It has two stack units data stack (DS) and return stack (RS) of base width and configurable depth.

Each instruction has 4-bit `Head` part that defines following side effects:
 - Stack effect (DS and RS)
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
| 7 | CALL   | subroutine call     |      |                | ( addr -- )           | ( -- addr )
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
| 0 |      | unconditional
| 1 | BDZ  | second element of DS is equal 0
| 2 | BRZ  | second element on RS is equal 0

## Load type

| N | name  | description
|---|-------|------------
| 0 | Li8   | load byte
| 1 | Li16  | load 2 byte
| 2 | Li32  | load 4 byte
| 3 | Lu8   | load byte unsigned
| 4 | Lu16  | load 2 byte unsigned
| 5 | Li64  |
| 6 | Li128 |
| 7 | Lu64  |
| 8 | Lu128 |

## Stores

| N | name  | description
|---|-------|------------
| 0 | Si8   | store byte
| 1 | Si16  | store 2 bytes
| 2 | Si32  | store 4 bytes
| 3 | Si64  | store 8 bytes
| 4 | Si128 | store 16 bytes

## ALU

| N | name | description
|---|------|------------
| 0 | SLL  | shift left
| 1 | SRL  | shift right
| 2 | SRA  | shift right arithmetic
| 3 | ADD  | add
| 4 | SUB  | substract
| 4 | SSUB | swap substract   |
| 5 | XOR  | xor
| 6 | OR   | or
| 7 | AND  | and
| 8 | SLT  | <
| 9 | SLTU | < unsigned
