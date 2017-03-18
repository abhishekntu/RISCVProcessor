`timescale 1ns / 1ps
`include "define.v"

module instruction_memory(input clk, 
			  input rst, 
			  input mem_read, 
			  input [`ISIZE-1:0] addr, 
			  output [`DSIZE-1:0] instr_out);

  reg [`ISIZE-1:0] memory [0:`MAX_LINE_LENGTH-1];
  reg [1023:0] firmware_file;
  assign instr_out = (mem_read==1'b1)? memory[addr]: 16'b0;
  initial 
      begin //if begins
	   firmware_file = "firmware.hex";
	   $readmemh(firmware_file, memory);
  end
  


endmodule
