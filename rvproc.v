`include "define.v"

module rvproc (input clk,
	       input rst,
	       input [31:0] PCOUT,
	       output [31:0] instr_out);

//Program Counter
wire [`ISIZE-1:0] PC_IN;
wire [`ISIZE-1:0] PC_OUT;
wire reg_write_en;
wire imem_read_en;

//To control reading and writing from data mem
wire dmem_read_en, dmem_write_en;


wire aluToReg, branch, jr, jal;

wire [`ASIZE-1:0] r_src_addr1, r_src_addr2, r_dest_addr;

reg [`ISIZE-1:0] addr;
 
// Outputs
wire [`DSIZE-1:0] data_out;
wire [`DSIZE-1:0] write_data_reg;
wire [`DSIZE-1:0] write_data_mux;
wire [3:0] instr_id;
wire [6:0] opcode;
wire [`DSIZE-1:0] imm_ext;
wire [`DSIZE-1:0] alu_out, r_data1, r_data2;
wire zflag;

assign PC_IN = PC_OUT + 32'b1;

//assign write_data_mux = (jal==1) ? PC_OUT : write_data_reg;
assign write_data_reg = (aluToReg==1) ? (alu_out) : (data_out); // write_data_reg is to be written in Register file

program_counter pc(.clk(clk), .rst(rst), .nextPC(PC_IN), .currPC(PC_OUT)); //PC_OUT is your PC value and PC_IN is your next PC

instruction_memory imem (.clk(clk), .rst(rst), .read_en(1'b1), .r_addr(PC_OUT), .instr_out(instr_out));

data_memory dmem (.clk(clk), .rst(rst), .read_en(dmem_read_en), .write_en(dmem_write_en), .addr(alu_out), .w_data(r_data2), .data_out(data_out));

decoder dec (.instr(instr_out), .instr_code(instr_id), .rs1(r_src_addr1), .rs2(r_src_addr2), .imm(imm_ext), .rd(r_dest_addr));

control ctrl (.instr_code(instr_id), .wen(reg_write_en), .mem_read(dmem_read_en), .mem_write(dmem_write_en), .AluToReg(aluToReg), .branch(branch), .jr(jr), .jal(jal));

regfile rfile(.clk(clk), .rst(rst), .write_en(reg_write_en), .raddr1(r_src_addr1), .raddr2(r_src_addr2), .waddr(r_dest_addr), .wdata(write_data_reg), .rdata1(r_data1), .rdata2(r_data2));

alu alu0(.clk(clk), .rst(rst), .instr_code(instr_id), .a(r_data1), .b(r_data2), .imm(imm_ext), .out(alu_out), .zero(zflag));

endmodule