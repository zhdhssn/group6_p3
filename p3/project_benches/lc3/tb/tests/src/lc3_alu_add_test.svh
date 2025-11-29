//Harry: Focused ADD-only regression
class lc3_alu_add_test extends test_top;

  `uvm_component_utils(lc3_alu_add_test)

  function new(string name = "lc3_alu_add_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);

    //Harry: debug message
    `uvm_info("lc3_alu_add_test", "Harry-> alu_add_seq overridding seq(base)...", UVM_HIGH)
    
    //Harry: Override the instruction memory responder with our deterministic ADD program
    set_type_override_by_type(
      imem_responder_sequence::get_type(),
      imem_responder_alu_add_sequence::get_type()
    );

    //Harry: must call the super.build_phase after the override!
    //since the build_phase is top-down, kinda like first come first serve!
    super.build_phase(phase);
  endfunction

  //Harry: the run_phase is working
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    `uvm_info("ALU_ADD_TEST", "===== LC3 ALU ADD TEST START =====", UVM_LOW)
    #1us; //Harry->question: how should should we run the simulation?
    `uvm_info("ALU_ADD_TEST", "===== LC3 ALU ADD TEST COMPLETE =====", UVM_LOW)
    phase.drop_objection(this);
  endtask

endclass


