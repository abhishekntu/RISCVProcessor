`include "define.v"// defines opcodes

module decoder(
    clk,
    rst,
    instr,  //32-bit instruction	
    instr_code, //Instruction code
    rs1,    //Source Register address 1
    rs2,    //Source Register address 2
    imm,    //Sign extended immediate value
    rd     //Destination Register address
    );

    input clk;                          
    input rst;
    input [`ISIZE-1:0] instr;
    output reg [3:0] instr_code;
    output reg [`ASIZE-1:0] rs1, rs2, rd;
    output reg [`DSIZE-1:0] imm;
      
    always @(posedge clk)
    begin
        
        case(instr[6:0])

          `RTYPE_OPC: begin
              rs1 = instr[19:15];
              rs2 = instr[24:20];
              rd = instr[11:7];
              case(instr[31:25])        //ADD MORE CASES HERE FOR SUB, SRA
                7'b0000000: begin
                  case(instr[14:12])    //ADD MORE CASES HERE FOR AND, OR, XOR, SLT, SLTU, SRL, SLL
                    3'b000: instr_code = `ADD;    
		              endcase
                end
                7'b0000001: instr_code = `MUL;
              endcase
          end

          `ITYPE_OPC: begin
              rs1 = instr[19:15];
              imm={{20{instr[31]}}, {{instr[31:20]}}};
              rd = instr[11:7];
              case(instr[14:12])
                3'b000: instr_code = `ADDI;
              endcase
          end

          `LW_OPC: begin
            rs1 = instr[19:15];
            imm={{20{instr[31]}}, {{instr[31:20]}}};
            rd = instr[11:7];
            instr_code = `LW;
          end

    		  `SW_OPC: begin
            rs1 = instr[19:15];
            rs2 = instr[24:20];
            imm={{20{instr[11]}}, {{{{instr[11:5]}, {instr[4:0]}}}}};
            instr_code = `SW;
          end

          `JAL_OPC: begin
            rd = instr[11:7];
            imm={{12{instr[31]}}, {{instr[31:12]}}};
            instr_code = `JAL;
          end

          `JR_OPC: begin
            instr_code = `JR;
          end

    		  `CONBRANCH_OPC: begin // NOT COMPLETE
            case(instr[14:12])
              3'b001: instr_code = `BNE;
            endcase
          end
        endcase

    end

endmodule