//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class can be used to provide stimulus when an interface
//              has been configured to run in a responder mode. It
//              will never finish by default, always going back to the driver
//              and driver BFM for the next transaction with which to respond.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_responder_sequence extends imem_sequence_base;

  `uvm_object_utils(imem_responder_sequence)

  int count = -1;

  // pragma uvmf custom class_item_additional begin
  // Statistics tracking
  int total_transactions_generated = 0;
  int opcode_distribution[op_t];
  
  // Helper method to update statistics
  protected function void update_statistics(imem_transaction txn);
    total_transactions_generated++;
    if(opcode_distribution.exists(txn.opcode)) begin
      opcode_distribution[txn.opcode]++;
    end
    else begin
      opcode_distribution[txn.opcode] = 1;
    end
  endfunction

  // Helper method to generate BR instruction with specific flags
  protected function void generate_br_instruction(imem_transaction txn, bit n_val, bit z_val, bit p_val);
    assert(txn.randomize() with {
      opcode == BR;
      n == n_val;
      z == z_val;
      p == p_val;
    });
  endfunction

  // Helper method to generate LD instruction for specific register
  protected function void generate_ld_instruction(imem_transaction txn, int reg_index);
    assert(txn.randomize() with {
      opcode == LD;
      dr == reg_index;
    });
  endfunction

  // Helper method to generate ST instruction for specific register
  protected function void generate_st_instruction(imem_transaction txn, int reg_index);
    assert(txn.randomize() with {
      opcode == ST;
      sr1 == reg_index;
    });
  endfunction

  // Helper method to generate ALU instructions
  protected function void generate_alu_instruction(imem_transaction txn);
    assert(txn.randomize() with {
      opcode inside {ADD, AND, NOT};
    });
  endfunction

  // Helper method to generate control flow instructions
  protected function void generate_control_instruction(imem_transaction txn);
    assert(txn.randomize() with {
      opcode inside {BR, JMP};
    });
  endfunction

  // Helper method to generate memory instructions
  protected function void generate_memory_instruction(imem_transaction txn);
    assert(txn.randomize() with {
      opcode inside {LD, LDR, LDI, LEA, ST, STR, STI};
    });
  endfunction

  // Method to print statistics at end of sequence
  function void print_statistics();
    `uvm_info("SEQ_STATS", $sformatf("Total transactions generated: %0d", total_transactions_generated), UVM_MEDIUM)
    foreach(opcode_distribution[op]) begin
      `uvm_info("SEQ_STATS", $sformatf("Opcode %s: %0d occurrences", op.name(), opcode_distribution[op]), UVM_MEDIUM)
    end
  endfunction
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req = imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin
      start_item(req);
      if(count == 0) begin
        assert(req.randomize() with {
          opcode == BR;
          n == 1'b0;
          z == 1'b1;
          p == 1'b0;
        });
      end
      else if(count >= 1 && count < 9) begin
        assert(req.randomize() with {
          opcode == LD;
          dr == count - 1;
        });
      end
      else if(count >= 9 && count < 17) begin
        assert(req.randomize() with {
          opcode == ST;
          sr1 == count - 9;
        });
      end
      else if(count >= 17 && count < 27) begin
        assert(req.randomize() with {
          opcode inside {ADD, AND, NOT};
        });
      end
      else if(count >= 27 && count < 37) begin
        assert(req.randomize() with {
          opcode inside {BR, JMP};
        });
      end
      else if(count >= 37 && count < 47) begin
        assert(req.randomize() with {
          opcode inside {LD, LDR, LDI, LEA, ST, STR, STI};
        });
      end
      else begin
        assert(req.randomize());
      end
      finish_item(req);
      count = count + 1;
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      update_statistics(req);
      `uvm_info("SEQ", $sformatf("Processed txn: %s", req.convert2string()), UVM_HIGH)
      // pragma uvmf custom body end
    end
    print_statistics();
  endtask

endclass


class imem_alu_responder_sequence extends imem_responder_sequence;

  `uvm_object_utils(imem_alu_responder_sequence)

  // pragma uvmf custom class_item_additional begin
  // ALU-specific statistics
  int alu_op_count = 0;
  int load_op_count = 0;
  int store_op_count = 0;
  
  // Override statistics update for ALU-specific tracking
  function void update_statistics(imem_transaction txn);
    super.update_statistics(txn);
    if(txn.opcode inside {ADD, AND, NOT}) begin
      alu_op_count++;
    end
    else if(txn.opcode inside {LD, LDR, LDI, LEA}) begin
      load_op_count++;
    end
    else if(txn.opcode inside {ST, STR, STI}) begin
      store_op_count++;
    end
  endfunction

  // Override print statistics to include ALU-specific info
  function void print_statistics();
    super.print_statistics();
    `uvm_info("ALU_SEQ_STATS", $sformatf("ALU operations: %0d", alu_op_count), UVM_MEDIUM)
    `uvm_info("ALU_SEQ_STATS", $sformatf("Load operations: %0d", load_op_count), UVM_MEDIUM)
    `uvm_info("ALU_SEQ_STATS", $sformatf("Store operations: %0d", store_op_count), UVM_MEDIUM)
  endfunction
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_alu_responder_sequence");
    super.new(name);
  endfunction

  task body();
    int count = -1;
    req = imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin
      start_item(req);
      if(count == 0) begin
        assert(req.randomize() with {
          opcode == BR;
          n == 1'b1;
          z == 1'b1;
          p == 1'b1;
        });
      end
      else if(count >= 1 && count < 9) begin
        assert(req.randomize() with {
          opcode == LD;
          dr == count - 1;
        });
      end
      else if(count >= 9 && count < 17) begin
        assert(req.randomize() with {
          opcode == ST;
          sr1 == count - 9;
        });
      end
      else begin
        assert(req.randomize() with {
          opcode inside {ADD, AND, NOT};
        });
      end
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the alu_responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      update_statistics(req);
      `uvm_info("SEQ", $sformatf("Processed txn: %s", req.convert2string()), UVM_HIGH)
      count++;
      // pragma uvmf custom body end
    end
    print_statistics();
  endtask

endclass

class imem_misc_responder_sequence extends imem_responder_sequence;

  `uvm_object_utils(imem_misc_responder_sequence)

  // pragma uvmf custom class_item_additional begin
  int count = -1;
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_misc_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req = imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin
      start_item(req);
      if(count == 0) begin
        assert(req.randomize() with {
          opcode == BR;
          n == 1'b1;
          z == 1'b1;
          p == 1'b1;
        });
      end
      else if(count >= 1 && count < 9) begin
        assert(req.randomize() with {
          opcode == LD;
          dr == count - 1;
        });
      end
      else if(count >= 9 && count < 17) begin
        assert(req.randomize() with {
          opcode == ST;
          sr1 == count - 9;
        });
      end
      else if(count == 17) begin
        assert(req.randomize() with {
          opcode == JMP;
          baser == 3'b0;
        });
      end
      else begin
        assert(req.randomize() with {
          sr1 == sr2;
          dr == sr2;
          baser == sr2;
        });
      end
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the misc_responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      update_statistics(req);
      `uvm_info("SEQ", $sformatf("Processed txn: %s", req.convert2string()), UVM_HIGH)
      count = count + 1;
      // pragma uvmf custom body end
    end
    print_statistics();
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

class imem_mem_coverage_responder_sequence extends imem_responder_sequence;

  `uvm_object_utils(imem_mem_coverage_responder_sequence)

  // pragma uvmf custom class_item_additional begin
  int count = 0;
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_mem_coverage_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req = imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin
      start_item(req);

      if(count % 2 == 0) begin
        assert(req.randomize() with {
          opcode inside {LD, ST};
        });
      end
      else begin
        assert(req.randomize() with {
          opcode == BR;
        });
      end

      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the raw_responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      update_statistics(req);
      `uvm_info("SEQ", $sformatf("Processed txn: %s", req.convert2string()), UVM_HIGH)
      count = count + 1;
      // pragma uvmf custom body end
    end
    print_statistics();
  endtask

endclass

class imem_ctrl_switch_responder_sequence extends imem_responder_sequence;

  `uvm_object_utils(imem_ctrl_switch_responder_sequence)

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_ctrl_switch_responder_sequence");
    super.new(name);
  endfunction

  task body();
    int count = -1;
    req = imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin
      start_item(req);
      if(count == 0) begin
        assert(req.randomize() with {
          opcode == BR;
          n == 1'b1;
          z == 1'b1;
          p == 1'b1;
        });
      end
      else if(count >= 1 && count < 9) begin
        assert(req.randomize() with {
          opcode == LD;
          dr == count - 1;
        });
      end
      else if(count >= 9 && count < 17) begin
        assert(req.randomize() with {
          opcode == ST;
          sr1 == count - 9;
        });
      end
      else if(count >= 240) begin
        assert(req.randomize() with {
          opcode inside {AND, ADD, NOT};
        });
      end
      else begin
        assert(req.randomize() with {
          opcode inside {BR, JMP};
        });
      end
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the ctrl_switch_responder sequence.
      // If this was an item that required a ctrl_switch_response, the expectation is
      // that the ctrl_switch_response should be populated within this transaction now.
      update_statistics(req);
      `uvm_info("SEQ", $sformatf("Processed txn: %s", req.convert2string()), UVM_HIGH)
      count++;
      // pragma uvmf custom body end
    end
    print_statistics();
  endtask

endclass

class imem_mem_responder_sequence extends imem_responder_sequence;

  `uvm_object_utils(imem_mem_responder_sequence)

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_mem_responder_sequence");
    super.new(name);
  endfunction

  virtual task body();
    int count = -1;
    req = imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin
      start_item(req);
      if(count == 0) begin
        assert(req.randomize() with {
          opcode == BR;
          n == 1'b1;
          z == 1'b1;
          p == 1'b1;
        });
      end
      else if(count >= 1 && count < 9) begin
        assert(req.randomize() with {
          opcode == LD;
          dr == count - 1;
        });
      end
      else if(count >= 9 && count < 17) begin
        assert(req.randomize() with {
          opcode == ST;
          sr1 == count - 9;
        });
      end
      else begin
        assert(req.randomize() with {
          opcode inside {LD, LDR, LDI, LEA, ST, STR, STI};
        });
      end
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the mem_responder sequence.
      // If this was an item that required a mem_response, the expectation is
      // that the mem_response should be populated within this transaction now.
      update_statistics(req);
      `uvm_info("SEQ", $sformatf("Processed txn: %s", req.convert2string()), UVM_HIGH)
      count++;
      // pragma uvmf custom body end
    end
    print_statistics();
  endtask

endclass

class imem_ld_st_coverage_responder_sequence extends imem_responder_sequence;

  `uvm_object_utils(imem_ld_st_coverage_responder_sequence)

  // pragma uvmf custom class_item_additional begin
  int count = 0;
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_ld_st_coverage_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req = imem_transaction::type_id::create("req");
    repeat(sequence_runs * 1.5) begin
      start_item(req);

      if(count % 3 == 1 || count % 3 == 2) begin
        assert(req.randomize() with {
          opcode inside {LD, LDI, LEA};
        });
      end
      else begin
        assert(req.randomize() with {
          opcode inside {ST, STI};
        });
      end

      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the raw_responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      update_statistics(req);
      `uvm_info("SEQ", $sformatf("Processed txn: %s", req.convert2string()), UVM_HIGH)
      count = count + 1;
      // pragma uvmf custom body end
    end
    print_statistics();
  endtask

endclass

class imem_ldr_str_coverage_responder_sequence extends imem_responder_sequence;

  `uvm_object_utils(imem_ldr_str_coverage_responder_sequence)

  // pragma uvmf custom class_item_additional begin
  int count = 0;
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_ldr_str_coverage_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req = imem_transaction::type_id::create("req");
    repeat(sequence_runs) begin
      start_item(req);

      // Loads all regs first
      if(count >= 1 && count < 9) begin
        assert(req.randomize() with {
          opcode == LD;
          dr == count - 1;
        });
      end
      else begin
        assert(req.randomize() with {
          opcode inside {LDR, STR};
        });
      end

      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the raw_responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      update_statistics(req);
      `uvm_info("SEQ", $sformatf("Processed txn: %s", req.convert2string()), UVM_HIGH)
      count = count + 1;
      // pragma uvmf custom body end
    end
    print_statistics();
  endtask

endclass

//---------------------------------------------------------------------------------------------
