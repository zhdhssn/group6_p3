class imem_alu_sequence extends imem_responder_sequence;

  `uvm_object_utils(imem_alu_sequence)

  function new(string name = "imem_alu_sequence");
    super.new(name);
  endfunction

  task body();
    `uvm_info("ALU_SEQ", "Running FULL LC3 ALU instruction sequence", UVM_LOW)

    req = imem_transaction::type_id::create("req");

    // --------------------------------------------------------------------
    // INSTRUCTION 0: ADD R1 = R2 + R3          opcode=0001, DR=001, SR1=010, mode=0, SR2=011
    // --------------------------------------------------------------------
    start_item(req);
    req.PC          = 16'h3000;
    req.Instr_dout  = 16'b0001_001_010_0_00_011;
    req.complete_instr = 1;
    finish_item(req);

    // --------------------------------------------------------------------
    // INSTRUCTION 1: ADD R4 = R5 + #2          opcode=0001, DR=100, SR1=101, imm mode=1, imm5=00010
    // --------------------------------------------------------------------
    start_item(req);
    req.PC          = 16'h3001;
    req.Instr_dout  = 16'b0001_100_101_1_00010;
    req.complete_instr = 1;
    finish_item(req);

    // --------------------------------------------------------------------
    // INSTRUCTION 2: AND R0 = R1 & R2          opcode=0101, DR=000, SR1=001, mode=0, SR2=010
    // --------------------------------------------------------------------
    start_item(req);
    req.PC          = 16'h3002;
    req.Instr_dout  = 16'b0101_000_001_0_00_010;
    req.complete_instr = 1;
    finish_item(req);

    // --------------------------------------------------------------------
    // INSTRUCTION 3: AND R7 = R1 & #15         opcode=0101, DR=111, SR1=001, imm mode=1, imm5=01111
    // --------------------------------------------------------------------
    start_item(req);
    req.PC          = 16'h3003;
    req.Instr_dout  = 16'b0101_111_001_1_01111;
    req.complete_instr = 1;
    finish_item(req);

    // --------------------------------------------------------------------
    // INSTRUCTION 4: NOT R3 = NOT R4           opcode=1001, DR=011, SR1=100, XXXXX=111111
    // --------------------------------------------------------------------
    start_item(req);
    req.PC          = 16'h3004;
    req.Instr_dout  = 16'b1001_011_100_111111;
    req.complete_instr = 1;
    finish_item(req);

    // --------------------------------------------------------------------
    // INSTRUCTION 5: NOP                        (encoded as BRnzp with all zeros)
    // --------------------------------------------------------------------
    start_item(req);
    req.PC          = 16'h3005;
    req.Instr_dout  = 16'b0000_000_000000000; // BR with no conditions = NOP
    req.complete_instr = 1;
    finish_item(req);

    // --------------------------------------------------------------------
    // PIPELINE END: feed no new instructions but keep IMEM alive
    // --------------------------------------------------------------------
    forever begin
      start_item(req);
      finish_item(req);
    end

  endtask

endclass
