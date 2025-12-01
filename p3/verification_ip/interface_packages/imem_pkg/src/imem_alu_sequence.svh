class imem_alu_sequence extends imem_responder_sequence;

  `uvm_object_utils(imem_alu_sequence)

  // ROM for ALU instructions
  rand bit [15:0] program_mem [0:255];

  // Request pointer (must be declared before body)
  imem_transaction req;

  function new(string name = "imem_alu_sequence");
    super.new(name);

    // Preload ALU test program
    program_mem[16'h3000] = 16'b0001_001_010_0_00_011; // ADD
    program_mem[16'h3001] = 16'b0001_100_101_1_00010; // ADDI
    program_mem[16'h3002] = 16'b0101_000_001_0_00_010; // AND
    program_mem[16'h3003] = 16'b0101_111_001_1_01111; // ANDI
    program_mem[16'h3004] = 16'b1001_011_100_111111; // NOT
    program_mem[16'h3005] = 16'b0000_000_000000000;   // NOP
  endfunction


  task body();
    super.body();
    `uvm_info("IMEM_ALU_SEQ", "Starting ALU IMEM responder sequence", UVM_LOW)

    // Allocate request object once
    req = imem_transaction::type_id::create("req");

    forever begin
      //-------------------------------------------
      // WAIT FOR DUT TO REQUEST AN INSTRUCTION
      //-------------------------------------------
      start_item(req);
      finish_item(req);   // req.PC becomes valid here

      //-------------------------------------------
      // RETURN INSTRUCTION BASED ON PC
      //-------------------------------------------
      req.Instr_dout     = program_mem[req.PC];
      req.complete_instr = 1;

      `uvm_info("IMEM_ALU_SEQ",
        $sformatf("Responding: PC=0x%h Instr=0x%h",
          req.PC, req.Instr_dout),
        UVM_MEDIUM
      )

      // Send back to driver
      req.set_id_info(req);
    end

  endtask

endclass
