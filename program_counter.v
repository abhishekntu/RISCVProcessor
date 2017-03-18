`include "define.v"

module program_counter(input clk,
           input rst,       
	   input [`ISIZE - 1:0]nextPC,	 
	   output reg [`ISIZE - 1:0]currPC);

  always @( posedge clk)
  begin
      if (rst) 
	begin
	 currPC <= 16'h0000;
	end
      else 
        begin
	 currPC <= nextPC;
	end
  end
endmodule
