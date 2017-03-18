`timescale 1ns / 1ps

// Instruction Opcodes
`define RTYPE_OPC 7'b0110011
`define ITYPE_OPC 7'b0010011
`define LW_OPC 7'b0000011
`define SW_OPC  7'b0100011
`define JAL_OPC 7'b1101111
`define JR_OPC 7'b1100111
`define CONBRANCH_OPC 7'b1100011

//	Instruction codes
`define ADD 4'h0
`define MUL 4'h1
`define ADDI 4'h2
`define LW 4'h3
`define SW 4'h4
`define JAL 4'h5
`define JR 4'h6
`define BNE 4'h7

`define EOF 32'hFFFF_FFFF
`define NULL 0
`define MAX_LINE_LENGTH 16384
`define DSIZE 32 // datasize
`define NREG 31//no of registers
`define ISIZE 32 //instuction size
`define ASIZE 8 //Address size
