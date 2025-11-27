//----------------------------------------------------------------------
// ALU-only LC3 test
//----------------------------------------------------------------------

class lc3_alu_test extends test_top;
  `uvm_component_utils(lc3_alu_test)

  function new(string name = "lc3_alu_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // override the instruction memory transaction type
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    `uvm_info("ALU_TEST", "Applying ALU instruction override", UVM_LOW)

    uvm_factory::get().set_type_override_by_type(
      imem_transaction::get_type(),
      lc3_alu_imem_txn::get_type()
    );
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("ALU_TEST", "===== LC3 ALU TEST STARTED =====", UVM_LOW)
    #1us; 
    `uvm_info("ALU_TEST", "===== LC3 ALU TEST COMPLETED =====", UVM_LOW)
    phase.drop_objection(this);
  endtask

endclass
