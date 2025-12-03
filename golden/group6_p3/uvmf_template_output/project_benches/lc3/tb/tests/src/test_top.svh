//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
// Description: This top level UVM test is the base class for all
//     future tests created for this project.
//
//     This test class contains:
//          Configuration:  The top level configuration for the project.
//          Environment:    The top level environment for the project.
//          Top_level_sequence:  The top level sequence for the project.
//                                        
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

typedef lc3_env_configuration lc3_env_configuration_t;
typedef lc3_environment lc3_environment_t;

class test_top extends uvmf_test_base #(.CONFIG_T(lc3_env_configuration_t), 
                                        .ENV_T(lc3_environment_t), 
                                        .TOP_LEVEL_SEQ_T(lc3_bench_sequence_base));

  `uvm_component_utils( test_top );


  string interface_names[] = {
    fetch_env_fet_in_BFM /* fetch_env_fet_in     [0] */ , 
    fetch_env_fet_out_BFM /* fetch_env_fet_out     [1] */ , 
    decode_env_dec_in_BFM /* decode_env_dec_in     [2] */ , 
    decode_env_dec_out_BFM /* decode_env_dec_out     [3] */ , 
    execute_env_execute_in_agent_BFM /* execute_env_execute_in_agent     [4] */ , 
    execute_env_execute_out_agent_BFM /* execute_env_execute_out_agent     [5] */ , 
    writeback_env_wb_in_BFM /* writeback_env_wb_in     [6] */ , 
    writeback_env_wb_out_BFM /* writeback_env_wb_out     [7] */ , 
    memaccess_env_agent_in_BFM /* memaccess_env_agent_in     [8] */ , 
    memaccess_env_agent_out_BFM /* memaccess_env_agent_out     [9] */ , 
    controller_env_controller_in_agent_BFM /* controller_env_controller_in_agent     [10] */ , 
    controller_env_controller_out_agent_BFM /* controller_env_controller_out_agent     [11] */ , 
    imem_agent_BFM /* instr_mem_agent     [12] */ , 
    dmem_agent_BFM /* dat_mem_agent     [13] */ 
};

uvmf_active_passive_t interface_activities[] = { 
    PASSIVE /* fetch_env_fet_in     [0] */ , 
    PASSIVE /* fetch_env_fet_out     [1] */ , 
    PASSIVE /* decode_env_dec_in     [2] */ , 
    PASSIVE /* decode_env_dec_out     [3] */ , 
    PASSIVE /* execute_env_execute_in_agent     [4] */ , 
    PASSIVE /* execute_env_execute_out_agent     [5] */ , 
    PASSIVE /* writeback_env_wb_in     [6] */ , 
    PASSIVE /* writeback_env_wb_out     [7] */ , 
    PASSIVE /* memaccess_env_agent_in     [8] */ , 
    PASSIVE /* memaccess_env_agent_out     [9] */ , 
    PASSIVE /* controller_env_controller_in_agent     [10] */ , 
    PASSIVE /* controller_env_controller_out_agent     [11] */ , 
    ACTIVE /* imem_agent     [12] */ , 
    ACTIVE /* dmem_agent     [13] */   };


  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // ****************************************************************************
  // FUNCTION: new()
  // This is the standard systemVerilog constructor.  All components are 
  // constructed in the build_phase to allow factory overriding.
  //
  function new( string name = "", uvm_component parent = null );
     super.new( name ,parent );
  endfunction



  // ****************************************************************************
  // FUNCTION: build_phase()
  // The construction of the configuration and environment classes is done in
  // the build_phase of uvmf_test_base.  Once the configuraton and environment
  // classes are built then the initialize call is made to perform the
  // following: 
  //     Monitor and driver BFM virtual interface handle passing into agents
  //     Set the active/passive state for each agent
  // Once this build_phase completes, the build_phase of the environment is
  // executed which builds the agents.
  //
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    // pragma uvmf custom configuration_settings_post_randomize begin
    // pragma uvmf custom configuration_settings_post_randomize end
    configuration.initialize(NA, "uvm_test_top.environment", interface_names, null, interface_activities);
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

