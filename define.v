`timescale 1ns / 1ps

// Instruction Opcodes
`define R_TYPE 7'b0110011
`define I_TYPE 7'b0010011
`define LW  7'b0000011
`define SW  7'b0100011
`define JAL 7'b1101111
`define JR 7'b1100111
`define COND_BRANCH 7'b1100011

`define EOF 32'hFFFF_FFFF
`define NULL 0
`define MAX_LINE_LENGTH 16384
`define DSIZE 32 // datasize
`define NREG 31//no of registers
`define ISIZE 32 //instuction size
`define ASIZE 8 //Address size
