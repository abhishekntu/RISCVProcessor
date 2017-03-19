`timescale 1ns / 1ps
`include "define.v"

module instruction_memory(input clk, 
			  input rst, 
			  input read_en, 
			  input [`ISIZE-1:0] r_addr, 
			  output [`ISIZE-1:0] instr_out);

  reg [`ISIZE-1:0] memory [0:`MAX_LINE_LENGTH-1];
  reg [1023:0] firmware_file;
  assign instr_out = (read_en==1'b1)? memory[r_addr]: 16'b0;
  initial 
      begin 
	   // Read instructions from firmware.hex file
	   firmware_file = "firmware.hex";
	   $readmemh(firmware_file, memory);
  end
endmodule

module data_memory(input clk, 
		   input rst, 
		   input write_en,
    		   input read_en, 
		   input [`DSIZE-1:0] addr,
 		   input [`DSIZE-1:0] w_data,
		   output [`DSIZE-1:0] data_out);

  reg [`ISIZE-1:0] memory [0:`MAX_LINE_LENGTH-1];
  reg [1023:0] memory_file;
  reg [`ISIZE-1:0] addr_r;
  assign data_out = (read_en==1'b1)? memory[addr_r]: 16'b0;
  integer i;
  initial 
  begin
      memory_file = "data_memory.hex";
      $readmemh(memory_file, memory);
  end
  always @ (posedge clk)
  begin
      //if (rst)
//	  begin
//              for (i=0; i<`MAX_LINE_LENGTH; i=i+1)
//                  memory[i] <= 0;
//	  end			
     // else
          addr_r <= addr;
          memory[addr_r] <= ((write_en == 1)) ? w_data : memory[addr_r];
  end
endmodule
