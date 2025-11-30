//Harry: Deterministic responder that feeds a focused ADD program to the DUT
class imem_responder_alu_add_sequence extends imem_responder_sequence;

  `uvm_object_utils(imem_responder_alu_add_sequence)

  localparam bit [15:0] BASE_PC = 16'h3000;

  //Harry: build a queue to store instructions
  bit [15:0] add_program[$];
  //Harry: Track metadata so we can print human-readable debug text
  typedef struct {
    lc3_opcode_e opcode;
    bit [2:0]    dr;
    bit [2:0]    sr1;
    bit [2:0]    sr2;
    bit          uses_imm;
    bit signed [4:0] imm5;
  } lc3_instr_meta_t;
  lc3_instr_meta_t add_program_meta[$];

  function new(string name = "imem_responder_alu_add_sequence");
    super.new(name);
  endfunction

  //Harry: helper to print register names like R0, R1, etc.
  protected function string reg_name(bit [2:0] reg_id);
    return $sformatf("R%0d", reg_id);
  endfunction

  //Harry: helper to print opcode mnemonics using the new lc3_opcode_e typedef
  protected function string opcode_name(lc3_opcode_e opcode);
    case (opcode)
      ADD: return "ADD";
      AND: return "AND";
      NOT: return "NOT";
      LD : return "LD";
      LDR: return "LDR";
      default: return "UNKNOWN";
    endcase
  endfunction

//Harry: refer to page 23 ISA SPEC
  //Harry: Build ADD register form opcode (opcode=0001, bit5=0).
  protected function bit [15:0] build_add_reg(bit [2:0] dr, bit [2:0] sr1, bit [2:0] sr2);
    return {ADD, dr, sr1, 1'b0, 2'b00, sr2};
  endfunction

  //Harry: Build ADD immediate form opcode (bit5=1).
  protected function bit [15:0] build_add_imm(bit [2:0] dr, bit [2:0] sr1, bit signed [4:0] imm5);
    return {ADD, dr, sr1, 1'b1, imm5[4:0]};
  endfunction

  //Harry: helper to describe operand2 for debug (either reg or immediate)
  protected function string operand2_string(lc3_instr_meta_t info);
    return info.uses_imm ? $sformatf("#%0d", info.imm5) : reg_name(info.sr2);
  endfunction

  //Harry: present a human readable summary of the instruction fields
  protected function string instr_summary(lc3_instr_meta_t info);
    return $sformatf("opcode=%s dr=%s sr1=%s op2=%s",
      opcode_name(info.opcode),
      reg_name(info.dr),
      reg_name(info.sr1),
      operand2_string(info));
  endfunction

  //Harry: Precompute a short program that mixes register and immediate variants.
  protected function void build_program();
    lc3_instr_meta_t meta;
    add_program.delete();
    add_program_meta.delete();
    //Harry: just tests 1 = 0 + 1 for now for the R1 register
    add_program.push_back(build_add_imm(3'd1, 3'd1, 5'sd1));  // ADD R1, R1, #1
    meta.opcode   = ADD;
    meta.dr       = 3'd1;
    meta.sr1      = 3'd1;
    meta.sr2      = 3'd0;
    meta.uses_imm = 1'b1;
    meta.imm5     = 5'sd1;
    add_program_meta.push_back(meta);


    // add_program.push_back(build_add_reg(3'd0, 3'd1, 3'd2));   // ADD R0, R1, R2
    // add_program.push_back(build_add_reg(3'd3, 3'd4, 3'd5));   // ADD R3, R4, R5
    // add_program.push_back(build_add_imm(3'd6, 3'd6, 5'sd1));  // ADD R6, R6, #1
    // add_program.push_back(build_add_imm(3'd7, 3'd0, -5'sd2)); // ADD R7, R0, #-2
    // add_program.push_back(build_add_reg(3'd2, 3'd7, 3'd1));   // ADD R2, R7, R1
  endfunction

  protected task drive_instr(bit [15:0] instr, bit [15:0] pc_value, lc3_instr_meta_t info);
    
    start_item(req);
    req.PC             = pc_value;
    req.Instr_dout     = instr;
    req.complete_instr = 1'b1;
    finish_item(req);
    `uvm_info("ADD_SEQ",
      $sformatf("Issued %s %s, %s, %s at PC 0x%04h (instr 0x%04h)",
        opcode_name(info.opcode),
        reg_name(info.dr),
        reg_name(info.sr1),
        operand2_string(info),
        pc_value,
        instr),
      UVM_MEDIUM)
  endtask

  virtual task body();
    string first_instr_detail;
    int last;
    req = imem_transaction::type_id::create("req");
    build_program(); //Harry: we hardcoded for now to test top-level integration instead of generating a random program

    //Harry: debug message(print out the PC, Instr_dout(opcode, dr, sr1, sr2, uses_imm, imm5), and complete_instr)
    first_instr_detail = add_program_meta.size() ? instr_summary(add_program_meta[0]) : "no instruction available";
    `uvm_info("imem_responder_alu_add_sequence",
      $sformatf("Harry-> driving one ADD instr to imem... PC: 0x%04h, Instr_dout: 0x%04h (%s), complete_instr: %b",
        BASE_PC, add_program.size() ? add_program[0] : 16'h0000, first_instr_detail, 1'b1),
      UVM_HIGH)
    
    foreach (add_program[idx]) begin
      drive_instr(add_program[idx], BASE_PC + idx, add_program_meta[idx]);
    end
    //Harry: debug message
    `uvm_info("imem_responder_alu_add_sequence", "Harry-> finished driving one ADD instr to imem...(actually we just put one ADD instr to the program queue)", UVM_HIGH)

    //Harry: Hold the pipeline alive by replaying the last ADD continuously.
    forever begin
      last = $high(add_program);
      drive_instr(add_program[last], BASE_PC + add_program.size(), add_program_meta[last]);
    end
  endtask

endclass


