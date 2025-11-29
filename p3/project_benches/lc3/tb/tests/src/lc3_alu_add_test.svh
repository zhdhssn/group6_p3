//Harry: Focused ADD-only regression
class lc3_alu_add_test extends test_top;

  `uvm_component_utils(lc3_alu_add_test)

  function new(string name = "lc3_alu_add_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //Harry: debug message
    `uvm_info("lc3_alu_add_test", "Harry-> imem_responder_alu_add_sequence overridding imem_responder_sequence(base)...", UVM_HIGH)
    
    //Harry: Override the instruction memory responder with our deterministic ADD program
    set_type_override_by_type(
      imem_responder_sequence::get_type(),
      imem_responder_alu_add_sequence::get_type()
    );
    
  endfunction

  //Harry: the run_phase is working
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("ALU_ADD_TEST", "===== LC3 ALU ADD TEST START =====", UVM_LOW)
    //Harry: debug -> reduce one error by creating virtual sequence: add test -> test_top -> created virtual sequence
    super.run_phase(phase); // let uvmf_test_base start LC3_bench_sequence_base
    #1us; //Harry->question: how long should we run the simulation?
    `uvm_info("ALU_ADD_TEST", "===== LC3 ALU ADD TEST COMPLETE =====", UVM_LOW)
    phase.drop_objection(this);

    
  endtask

endclass


