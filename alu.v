`include "define.v"// defines opcodes

module alu(
    clk,
    rst,
    a,   //1st operand
    b,   //2nd operand
    op,   //7-bit opcode
    instr,  //32-bit instruction
    imm_12bit, //12 bit immediate value for I and S type instructions:ADDI, LW, JR, SW, BNE
    out,   //output
    zero   //zer flag bit for branch 
    );

    input clk;                          
    input rst;
    input [`DSIZE-1:0] a, b;
    input [6:0] op;
    input [`ISIZE-1:0] instr;
    input [11:0] imm_12bit;
    output reg [`DSIZE-1:0] out;
    output reg zero;
	reg [`DSIZE-1:0] imm;
      
    always @(posedge clk)
    begin
        
        case(op)

          `R_TYPE: begin
              case(instr[31:25])        //ADD MORE CASES HERE FOR SUB, SRA
                7'b0000000: begin
                  case(instr[14:12])    //ADD MORE CASES HERE FOR AND, OR, XOR, SLT, SLTU, SRL, SLL
                    3'b000: out = a + b; //ADD
		              endcase
                end
                7'b0000001: out = a * b; //MUL
              endcase
          end

          `I_TYPE: begin
              case(instr[14:12])
                3'b000: begin
                  assign imm={{20{imm_12bit[11]}}, {{imm_12bit[11:0]}}};
                  out = a + imm_12bit; //ADDI
                end
              endcase
          end

          `LW: begin
            assign imm={{20{imm_12bit[11]}}, {{imm_12bit[11:0]}}};
            out = a + imm_12bit; //LW memory address
          end

    		  `SW: begin
            assign imm={{20{imm_12bit[11]}}, {{imm_12bit[11:0]}}};
            out = a + imm_12bit; //SW memory address
          end

    		  `COND_BRANCH: out = a - b;
        endcase
    	
    	if(out==0)
    		zero=1;
    	else
    		zero=0;
    end

endmodule