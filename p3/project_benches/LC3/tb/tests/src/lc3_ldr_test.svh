//Harry: Test that overrides the imem responder to supply deterministic LDR instructions
class lc3_ldr_test extends test_top;

  `uvm_component_utils(lc3_ldr_test)

  function new(string name = "lc3_ldr_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    // Provide the load-specific instruction stream before calling parent build.
    uvm_factory::get().set_type_override_by_type(
      imem_responder_sequence::get_type(),
      imem_responder_mem_ldr_sequence::get_type()
    );
    super.build_phase(phase);
  endfunction

  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("LDR_TEST", "===== LC3 LDR TEST STARTED =====", UVM_LOW)
    #1us;
    `uvm_info("LDR_TEST", "===== LC3 LDR TEST COMPLETED =====", UVM_LOW)
    phase.drop_objection(this);
  endtask

endclass

