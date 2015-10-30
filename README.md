# Stack HAT
## Introduction
Simple stack CPU using Head-and-tail instruction format, described in [Hedi01](http://www.cs.berkeley.edu/~krste/papers/hat-cases2001.pdf)

![ISA](https://rawgit.com/drom/quark/master/isa.svg)

## Instructions

| N | name  | description         | tail | tail                      | DS                    | RS
|---| ----- | ------------------- | ---- | ------------------------- | --------------------- | --------
| 0 | LIT4  | push literal to DS  | 4    |                           | ( -- n )              |
| 1 | LIT8  | --//--              | 8    |                           | ( -- n )              |
| 2 | LIT16 | --//--              | 16   |                           | ( -- n )              |
| 3 | LIT32 | --//--              | 32   |                           | ( -- n )              |
| 4 | J?    | conditional branch  | 4    | condition                 | ( addr -- )           |
| 5 |       |                     |      |                           |                       |
| 6 | JMP   |                     |      |                           | ( addr -- )           |
| 7 | CALL  | subroutine call     |      |                           | ( addr -- )           |
| 8 | LOAD  | load from memory    | 4    | i8, i16, i32, u8, u16,... | ( addr -- data )      |
| 9 | PICK  | copy Nth DS element | 4    | element number            | ( -- n )              |
| A | DUP   | copy DS top         |      |                           | ( n -- n n )          |
| B | R>    | move RS top -> DS   |      |                           | ( -- n )              | ( n -- )
| C | STORE | store to the memory | 4    | i8, i16, i32              | ( data addr -- addr ) |
| D | ALU   |                     | 4    | operation: + - * >> <<    | ( a b -- c )          |
| E | DROP  | DS pop              |      |                           | ( n -- )              |
| F | >R    | move DS top -> RS   |      |                           | ( n -- )              | ( -- n )
