`include "define.v"// defines opcodes

module decoder(
    input [`ISIZE-1:0] instr,  //32-bit instruction	
    output reg [3:0] instr_code, //Instruction code
    output reg [`ASIZE-1:0] rs1,    //Source Register address 1
    output reg [`ASIZE-1:0] rs2,    //Source Register address 2
    output reg [`ASIZE-1:0] rd,     //Destination Register address
    output reg [`DSIZE-1:0] imm    //Sign extended immediate value
    );
 
    always @(*)
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
            imm={{20{instr[31]}}, {{{{instr[31:25]}, {instr[11:7]}}}}};
            instr_code = `SW;
          end

          `JAL_OPC: begin //NOT COMPLETE
            rd = instr[11:7];
            imm={{12{instr[31]}}, {{instr[31:12]}}};
            instr_code = `JAL;
          end

          `JR_OPC: begin
            rs1 = instr[19:15];
            instr_code = `JR;
          end

    		  `CONBRANCH_OPC: begin
            rs1 = instr[19:15];
            rs2 = instr[24:20];
            imm={{21{instr[31]}}, {{{{instr[7]}, {instr[30:25]}, {instr[11:8]}}}}};
            case(instr[14:12])
              3'b001: instr_code = `BNE;
            endcase
          end
        endcase

    end

endmodule
   
       