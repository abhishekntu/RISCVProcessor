`include "define.v"// defines opcodes

module alu(
    clk,
    rst,
    instr_code,
    a,   //1st operand
    b,   //2nd operand
    imm, //32 bit immediate value
    out,   //output
  	zero   //zer flag bit for branch 
    );

    input clk;                          
    input rst;
    input[3:0] instr_code;
    input [`DSIZE-1:0] a, b, imm;
    output reg [`DSIZE-1:0] out;
    output reg zero;
      
    always @(posedge clk)
    begin
      case(instr_code)
        `ADD: out = a + b;
        `MUL: out = a * b;
        `ADDI: out = a + imm;
        `LW: out = a + imm;
        `SW: out = a +imm;
        `BNE: out = a - b;
      endcase
    	
    	if(out==0)
    		zero=1;
    	else
    		zero=0;
    end
endmodule