`include "define.v"

module rvproc (input clk,
	       input rst,
	       input [31:0] PCOUT,
	       output [31:0] instr_out);

//Program Counter
wire [`ISIZE-1:0] PC_IN;
wire [`ISIZE-1:0] PC_OUT;
wire wen;
wire mem_read;
wire [`ASIZE-1:0] r_src_addr1, r_src_addr2, r_dest_addr;

reg [`ISIZE-1:0] addr;
 
// Outputs
wire [`DSIZE-1:0] data_out;
wire [3:0] instr_id;
wire [6:0] opcode;
wire [`DSIZE-1:0] imm_ext;
wire [`DSIZE-1:0] alu_out, alu_in1, alu_in2;
wire zflag;

assign PC_IN = PC_OUT + 32'b1;
program_counter pc(.clk(clk), .rst(rst), .nextPC(PC_IN), .currPC(PC_OUT)); //PC_OUT is your PC value and PC_IN is your next PC

instruction_memory mem (.clk(clk), .rst(rst), .mem_read(1'b1), .addr(PC_OUT), .instr_out(instr_out));

decoder dec (.clk(clk), .rst(rst), .instr(instr_out), .instr_code(instr_id), .rs1(r_src_addr1), .rs2(r_src_addr2), .imm(imm_ext), .rd(r_dest_addr));


regfile rfile(.clk(clk), .rst(rst), .wen(1'b1), .raddr1(r_src_addr1), .raddr2(r_src_addr2), .waddr(r_dest_addr), .wdata(alu_out), .rdata1(alu_in1), .rdata2(alu_in2));

alu alu0(.clk(clk), .rst(rst), .instr_code(instr_id), .a(alu_in1), .b(alu_in2), .imm(imm_ext), .out(alu_out), .zero(zflag));

endmodule