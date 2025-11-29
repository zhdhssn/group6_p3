//Harry: Deterministic responder that feeds a focused ADD program to the DUT
class imem_responder_alu_add_sequence extends imem_responder_sequence;

  `uvm_object_utils(imem_responder_alu_add_sequence)

  localparam bit [15:0] BASE_PC = 16'h3000;

  //Harry: build a queue to store instructions
  bit [15:0] add_program[$];

  function new(string name = "imem_responder_alu_add_sequence");
    super.new(name);
  endfunction

//Harry: refer to page 23 ISA SPEC
  //Harry: Build ADD register form opcode (opcode=0001, bit5=0).
  protected function bit [15:0] build_add_reg(bit [2:0] dr, bit [2:0] sr1, bit [2:0] sr2);
    return {4'b0001, dr, sr1, 1'b0, 2'b00, sr2};
  endfunction

  //Harry: Build ADD immediate form opcode (bit5=1).
  protected function bit [15:0] build_add_imm(bit [2:0] dr, bit [2:0] sr1, bit signed [4:0] imm5);
    return {4'b0001, dr, sr1, 1'b1, imm5[4:0]};
  endfunction

  //Harry: Precompute a short program that mixes register and immediate variants.
  protected function void build_program();
    add_program.delete();
    //Harry: just tests 1 = 0 + 1 for now for the R1 register
    add_program.push_back(build_add_imm(3'd1, 3'd1, 5'sd1));  // ADD R1, R1, #1


    // add_program.push_back(build_add_reg(3'd0, 3'd1, 3'd2));   // ADD R0, R1, R2
    // add_program.push_back(build_add_reg(3'd3, 3'd4, 3'd5));   // ADD R3, R4, R5
    // add_program.push_back(build_add_imm(3'd6, 3'd6, 5'sd1));  // ADD R6, R6, #1
    // add_program.push_back(build_add_imm(3'd7, 3'd0, -5'sd2)); // ADD R7, R0, #-2
    // add_program.push_back(build_add_reg(3'd2, 3'd7, 3'd1));   // ADD R2, R7, R1
  endfunction

  protected task drive_instr(bit [15:0] instr, bit [15:0] pc_value);
    
    start_item(req);
    req.PC             = pc_value;
    req.Instr_dout     = instr;
    req.complete_instr = 1'b1;
    finish_item(req);
    `uvm_info("ADD_SEQ", $sformatf("Issued ADD 0x%04h at PC 0x%04h", instr, pc_value), UVM_MEDIUM)
  endtask

  virtual task body();
    req = imem_transaction::type_id::create("req");
    build_program(); //Harry: we hardcoded for now to test top-level integration instead of generating a random program

    //Harry: debug message
    `uvm_info("imem_responder_alu_add_sequence", "Harry-> driving one ADD instr to imem...", UVM_HIGH)
    foreach (add_program[idx]) begin
      drive_instr(add_program[idx], BASE_PC + idx);
    end
    //Harry: debug message
    `uvm_info("imem_responder_alu_add_sequence", "Harry-> finished driving one ADD instr to imem...(actually we just put one ADD instr to the program queue)", UVM_HIGH)

    //Harry: Hold the pipeline alive by replaying the last ADD continuously.
    forever begin
      drive_instr(add_program[$high(add_program)], BASE_PC + add_program.size());
    end
  endtask

endclass


