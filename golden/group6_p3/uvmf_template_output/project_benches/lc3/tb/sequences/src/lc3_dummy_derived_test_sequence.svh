//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This file contains the top level sequence used in  example_derived_test.
// It is an example of a sequence that is extended from %(benchName)_bench_sequence_base
// and can override %(benchName)_bench_sequence_base.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class lc3_dummy_derived_test_sequence extends lc3_bench_sequence_base;

  `uvm_object_utils( lc3_dummy_derived_test_sequence );

  imem_dummy_sequence dummy_sequence;
// dmem_dummy_sequence dmem_dummy_sequence

  function new(string name = "" );
    super.new(name);
  endfunction

  virtual task body();
    
    // Construct sequence
    dummy_sequence = imem_dummy_sequence::type_id::create("dummy_sequence");

    // Wait for reset
    super.imem_agent_config.wait_for_reset();

    // Start sequence here
    // fork
      dummy_sequence.start(super.imem_agent_sequencer);
      // dmem dummy sequence
    // join_none
    
  endtask

endclass

// pragma uvmf custom external begin
 
// pragma uvmf custom external end

