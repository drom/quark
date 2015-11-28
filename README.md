# quark
## Introduction
Stack CPU with 16 instructions.

![ISA](https://rawgit.com/drom/quark/master/isa.svg)

## Instructions

| N | name  | description         | tail | tail                      | DS                    | RS
|---| ----- | ------------------- | ---- | ------------------------- | --------------------- | --------
| 0 | LIT4  | push literal to DS  | 4    | imm4                      | ( -- n )              |
| 1 | LIT8  | --//--              | 8    | imm8                      | ( -- n )              |
| 2 | LIT16 | --//--              | 16   | imm16                     | ( -- n )              |
| 3 | LIT32 | --//--              | 32   | imm32                     | ( -- n )              |
| 4 | B?    | conditional branch  | 4    | condition                 | ( addr -- )           |
| 5 |       |                     |      |                           |                       |
| 6 |       |                     |      |                           |                       |
| 7 | CALL  | subroutine call     |      |                           | ( addr -- )           | ( -- addr )
| 8 | L?    | load from memory    | 4    | i8, i16, i32, u8, u16,... | ( addr -- data )      |
| 9 | PICK  | copy Nth DS element | 4    | element number            | ( -- n )              |
| A | DUP   | copy DS top         |      |                           | ( n -- n n )          |
| B | R>    | move RS top -> DS   |      |                           | ( -- n )              | ( n -- )
| C | S?    | store to the memory | 4    | i8, i16, i32              | ( data addr -- addr ) |
| D | A?    |                     | 4    | operation: + - * >> <<    | ( a b -- c )          |
| E | DROP  | DS pop              |      |                           | ( n -- )              |
| F | >R    | move DS top -> RS   |      |                           | ( n -- )              | ( -- n )

## ALU

| N | name | description | extention
|---|------|-------------|-----------
| 0 | SLL  | shift left
| 1 | SRL  | shift right
| 2 | SRA  | shift right arithmetic
| 3 | ADD  | add
| 4 | SUB  | substract
| 5 | XOR  | xor
| 6 | OR   | or
| 7 | AND  | and
| 8 | SLT  | <
| 9 | SLTU | < unsigned

## Conditions

| N | name | description   | extention
|---|------|---------------|-----------
| 0 |      | unconditional | I
| 1 | BEQ  | =             | I
| 2 | BNE  | !=            | I
| 3 | BLT  | <             | I
| 4 | BGE  | >=            | I
| 5 | BLTU | <             | I
| 6 | BGEU | >=            | I

## Loads

| N | name | description | extention
|---|------|-------------|-----------
| 0 | Li8  | load 8-bit  | I
| 1 | Li16 | load 16-bit | I
| 2 | Li32 | load 32-bit | I
| 3 | Lu8  | load unsigned 8-bit | I
| 4 | Lu16 | load unsigned 16-bit | I
| 5 | Li64
| 6 | Li128
| 7 | Lu64
| 8 | Lu128

## Stores

| N | name | description | extention
|---|------|-------------|-----------
| 0 | Si8  |
| 1 | Si16 |
| 2 | Si32 |
| 3 | Si64 |
| 4 | Si128|
