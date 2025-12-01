//----------------------------------------------------------------------
// ALU-only LC3 test
//----------------------------------------------------------------------

class lc3_alu_test extends test_top;
  `uvm_component_utils(lc3_alu_test)

  function new(string name = "lc3_alu_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Apply type overrides in build_phase BEFORE calling super.build_phase
  virtual function void build_phase(uvm_phase phase);

    `uvm_info("ALU_TEST", "Applying ALU IMEM sequence override", UVM_LOW)

    // Optional: if you want a specialized transaction type
    // uvm_factory::get().set_type_override_by_type(
    //   imem_transaction::get_type(),
    //   imem_alu_transaction::get_type()
    // );

    // Use ALU responder sequence for IMEM
    uvm_factory::get().set_type_override_by_type(
      imem_responder_sequence::get_type(),
      imem_alu_sequence::get_type()
    );

    // Now let UVMF build the rest of the bench
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    `uvm_info("ALU_TEST", "===== LC3 ALU TEST STARTED =====", UVM_LOW)

    // Just let the pipeline run
    #1us;

    `uvm_info("ALU_TEST", "===== LC3 ALU TEST COMPLETED =====", UVM_LOW)

    phase.drop_objection(this);
  endtask

endclass
