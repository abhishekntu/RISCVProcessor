`timescale 1ns / 1ps
`include "define.v"

module testbench_rvproc;

	// Inputs
	reg clk;
	reg rst;
	reg [`ISIZE-1:0] addr; 

	// Outputs
	wire [`DSIZE-1:0] instr_out;

	rvproc uut (
		.clk(clk), 
		.rst(rst), 
		.PCOUT(addr), 
		.instr_out(instr_out));
	always #5 clk = ~clk;
	initial 
	  begin
	  // Initialize Inputs
	  clk = 0;
          rst = 1;
	  addr = 32'h0000_0000;
	  // Wait 50 ns for global reset to finish
          #50;
	  // Add stimulus here
	  rst = 0;
	  addr = 32'h0000_0000;
	end
	
endmodule
	

