
//control unit for write enable and ALU control

`include "define.v"
module control(
  input reg [3:0] instr_code,
  output reg wen,
  output reg mem_read,
  output reg mem_write,
  output reg AluToReg,
  output reg branch,
  output reg jr,
  output reg jal
  );
  
  initial
  begin
	wen = 0;
	mem_read = 0;
	mem_write = 0;
	AluToReg = 1;
	branch=0;
	jr=0;
	jal=0;
  end
  
  always@(*)
 	 begin
		wen = 1;
		mem_read = 0;
		mem_write = 0;
		AluToReg = 1;
		branch = 0;
		jr=0;
		jal=0;

		case(instr_code)
			`LW: begin
				mem_read = 1;
				AluToReg = 0;
			end

			`SW: begin
				wen = 0;
				mem_write = 1;
			end

			`JR: begin
				wen = 0;
				jr = 1;
			end

			`JAL: begin
				wen = 0;
				jr = 1;
				jal = 1;
			end

			`BNE: begin
				wen = 0;
				branch = 1;
			end
		endcase
	end
endmodule