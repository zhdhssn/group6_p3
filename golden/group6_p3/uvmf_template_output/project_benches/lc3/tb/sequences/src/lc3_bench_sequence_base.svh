//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// Description: This file contains the top level and utility sequences
//     used by test_top. It can be extended to create derivative top
//     level sequences.
//
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//


typedef lc3_env_configuration  lc3_env_configuration_t;

class lc3_bench_sequence_base extends uvmf_sequence_base #(uvm_sequence_item);

  `uvm_object_utils( lc3_bench_sequence_base );

  // pragma uvmf custom sequences begin

// This example shows how to use the environment sequence base
// It can only be used on environments generated with UVMF_2022.3 and later.
// Environment sequences generated with UVMF_2022.1 and earlier do not have the required 
//    environment level virtual sequencer
typedef lc3_env_sequence_base #(
        .CONFIG_T(lc3_env_configuration_t)// 
        )
        lc3_env_sequence_base_t;
rand lc3_env_sequence_base_t lc3_env_seq;



  // UVMF_CHANGE_ME : Instantiate, construct, and start sequences as needed to create stimulus scenarios.
  // Instantiate sequences here
  typedef fetch_in_random_sequence  fetch_env_fet_in_random_seq_t;
  fetch_env_fet_in_random_seq_t fetch_env_fet_in_random_seq;
  typedef fetch_out_random_sequence  fetch_env_fet_out_random_seq_t;
  fetch_env_fet_out_random_seq_t fetch_env_fet_out_random_seq;
  typedef decode_in_random_sequence  decode_env_dec_in_random_seq_t;
  decode_env_dec_in_random_seq_t decode_env_dec_in_random_seq;
  typedef decode_out_random_sequence  decode_env_dec_out_random_seq_t;
  decode_env_dec_out_random_seq_t decode_env_dec_out_random_seq;
  typedef execute_in_random_sequence  execute_env_execute_in_agent_random_seq_t;
  execute_env_execute_in_agent_random_seq_t execute_env_execute_in_agent_random_seq;
  typedef execute_out_random_sequence  execute_env_execute_out_agent_random_seq_t;
  execute_env_execute_out_agent_random_seq_t execute_env_execute_out_agent_random_seq;
  typedef writeback_in_random_sequence  writeback_env_wb_in_random_seq_t;
  writeback_env_wb_in_random_seq_t writeback_env_wb_in_random_seq;
  typedef writeback_out_random_sequence  writeback_env_wb_out_random_seq_t;
  writeback_env_wb_out_random_seq_t writeback_env_wb_out_random_seq;
  typedef memaccess_in_random_sequence  memaccess_env_agent_in_random_seq_t;
  memaccess_env_agent_in_random_seq_t memaccess_env_agent_in_random_seq;
  typedef memaccess_out_random_sequence  memaccess_env_agent_out_random_seq_t;
  memaccess_env_agent_out_random_seq_t memaccess_env_agent_out_random_seq;
  typedef controller_in_random_sequence  controller_env_controller_in_agent_random_seq_t;
  controller_env_controller_in_agent_random_seq_t controller_env_controller_in_agent_random_seq;
  typedef controller_out_random_sequence  controller_env_controller_out_agent_random_seq_t;
  controller_env_controller_out_agent_random_seq_t controller_env_controller_out_agent_random_seq;
  typedef imem_responder_sequence  imem_agent_responder_seq_t;
  imem_agent_responder_seq_t imem_agent_responder_seq;
  typedef dmem_responder_sequence  dmem_agent_responder_seq_t;
  dmem_agent_responder_seq_t dmem_agent_responder_seq;
  // pragma uvmf custom sequences end

    imem_misc_responder_sequence imem_misc_responder_seq;

//
  // Sequencer handles for each active interface in the environment
  typedef fetch_in_transaction  fetch_env_fet_in_transaction_t;
  uvm_sequencer #(fetch_env_fet_in_transaction_t)  fetch_env_fet_in_sequencer; 
  typedef fetch_out_transaction  fetch_env_fet_out_transaction_t;
  uvm_sequencer #(fetch_env_fet_out_transaction_t)  fetch_env_fet_out_sequencer; 
  typedef decode_in_transaction  decode_env_dec_in_transaction_t;
  uvm_sequencer #(decode_env_dec_in_transaction_t)  decode_env_dec_in_sequencer; 
  typedef decode_out_transaction  decode_env_dec_out_transaction_t;
  uvm_sequencer #(decode_env_dec_out_transaction_t)  decode_env_dec_out_sequencer; 
  typedef execute_in_transaction  execute_env_execute_in_agent_transaction_t;
  uvm_sequencer #(execute_env_execute_in_agent_transaction_t)  execute_env_execute_in_agent_sequencer; 
  typedef execute_out_transaction  execute_env_execute_out_agent_transaction_t;
  uvm_sequencer #(execute_env_execute_out_agent_transaction_t)  execute_env_execute_out_agent_sequencer; 
  typedef writeback_in_transaction  writeback_env_wb_in_transaction_t;
  uvm_sequencer #(writeback_env_wb_in_transaction_t)  writeback_env_wb_in_sequencer; 
  typedef writeback_out_transaction  writeback_env_wb_out_transaction_t;
  uvm_sequencer #(writeback_env_wb_out_transaction_t)  writeback_env_wb_out_sequencer; 
  typedef memaccess_in_transaction  memaccess_env_agent_in_transaction_t;
  uvm_sequencer #(memaccess_env_agent_in_transaction_t)  memaccess_env_agent_in_sequencer; 
  typedef memaccess_out_transaction  memaccess_env_agent_out_transaction_t;
  uvm_sequencer #(memaccess_env_agent_out_transaction_t)  memaccess_env_agent_out_sequencer; 
  typedef controller_in_transaction  controller_env_controller_in_agent_transaction_t;
  uvm_sequencer #(controller_env_controller_in_agent_transaction_t)  controller_env_controller_in_agent_sequencer; 
  typedef controller_out_transaction  controller_env_controller_out_agent_transaction_t;
  uvm_sequencer #(controller_env_controller_out_agent_transaction_t)  controller_env_controller_out_agent_sequencer; 
  typedef imem_transaction  imem_agent_transaction_t;
  uvm_sequencer #(imem_agent_transaction_t)  imem_agent_sequencer; 
  typedef dmem_transaction  dmem_agent_transaction_t;
  uvm_sequencer #(dmem_agent_transaction_t)  dmem_agent_sequencer; 


  // Top level environment configuration handle
  lc3_env_configuration_t top_configuration;

  // Configuration handles to access interface BFM's
  fetch_in_configuration  fetch_env_fet_in_config;
  fetch_out_configuration  fetch_env_fet_out_config;
  decode_in_configuration  decode_env_dec_in_config;
  decode_out_configuration  decode_env_dec_out_config;
  execute_in_configuration  execute_env_execute_in_agent_config;
  execute_out_configuration  execute_env_execute_out_agent_config;
  writeback_in_configuration  writeback_env_wb_in_config;
  writeback_out_configuration  writeback_env_wb_out_config;
  memaccess_in_configuration  memaccess_env_agent_in_config;
  memaccess_out_configuration  memaccess_env_agent_out_config;
  controller_in_configuration  controller_env_controller_in_agent_config;
  controller_out_configuration  controller_env_controller_out_agent_config;
  imem_configuration  imem_agent_config;
  dmem_configuration  dmem_agent_config;

  //lc3_reg_model reg_model;
  uvm_status_e status;
  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // ****************************************************************************
  function new( string name = "" );
    super.new( name );
    // Retrieve the configuration handles from the uvm_config_db

    // Retrieve top level configuration handle
    if ( !uvm_config_db#(lc3_env_configuration_t)::get(null,UVMF_CONFIGURATIONS, "TOP_ENV_CONFIG",top_configuration) ) begin
      `uvm_info("CFG", "*** FATAL *** uvm_config_db::get can not find TOP_ENV_CONFIG.  Are you using an older UVMF release than what was used to generate this bench?",UVM_NONE);
      `uvm_fatal("CFG", "uvm_config_db#(lc3_env_configuration_t)::get cannot find resource TOP_ENV_CONFIG");
    end

    // Retrieve config handles for all agents
    if( !uvm_config_db #( fetch_in_configuration )::get( null , UVMF_CONFIGURATIONS , fetch_env_fet_in_BFM , fetch_env_fet_in_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( fetch_in_configuration )::get cannot find resource fetch_env_fet_in_BFM" )
    if( !uvm_config_db #( fetch_out_configuration )::get( null , UVMF_CONFIGURATIONS , fetch_env_fet_out_BFM , fetch_env_fet_out_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( fetch_out_configuration )::get cannot find resource fetch_env_fet_out_BFM" )
    if( !uvm_config_db #( decode_in_configuration )::get( null , UVMF_CONFIGURATIONS , decode_env_dec_in_BFM , decode_env_dec_in_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( decode_in_configuration )::get cannot find resource decode_env_dec_in_BFM" )
    if( !uvm_config_db #( decode_out_configuration )::get( null , UVMF_CONFIGURATIONS , decode_env_dec_out_BFM , decode_env_dec_out_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( decode_out_configuration )::get cannot find resource decode_env_dec_out_BFM" )
    if( !uvm_config_db #( execute_in_configuration )::get( null , UVMF_CONFIGURATIONS , execute_env_execute_in_agent_BFM , execute_env_execute_in_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( execute_in_configuration )::get cannot find resource execute_env_execute_in_agent_BFM" )
    if( !uvm_config_db #( execute_out_configuration )::get( null , UVMF_CONFIGURATIONS , execute_env_execute_out_agent_BFM , execute_env_execute_out_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( execute_out_configuration )::get cannot find resource execute_env_execute_out_agent_BFM" )
    if( !uvm_config_db #( writeback_in_configuration )::get( null , UVMF_CONFIGURATIONS , writeback_env_wb_in_BFM , writeback_env_wb_in_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( writeback_in_configuration )::get cannot find resource writeback_env_wb_in_BFM" )
    if( !uvm_config_db #( writeback_out_configuration )::get( null , UVMF_CONFIGURATIONS , writeback_env_wb_out_BFM , writeback_env_wb_out_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( writeback_out_configuration )::get cannot find resource writeback_env_wb_out_BFM" )
    if( !uvm_config_db #( memaccess_in_configuration )::get( null , UVMF_CONFIGURATIONS , memaccess_env_agent_in_BFM , memaccess_env_agent_in_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( memaccess_in_configuration )::get cannot find resource memaccess_env_agent_in_BFM" )
    if( !uvm_config_db #( memaccess_out_configuration )::get( null , UVMF_CONFIGURATIONS , memaccess_env_agent_out_BFM , memaccess_env_agent_out_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( memaccess_out_configuration )::get cannot find resource memaccess_env_agent_out_BFM" )
    if( !uvm_config_db #( controller_in_configuration )::get( null , UVMF_CONFIGURATIONS , controller_env_controller_in_agent_BFM , controller_env_controller_in_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( controller_in_configuration )::get cannot find resource controller_env_controller_in_agent_BFM" )
    if( !uvm_config_db #( controller_out_configuration )::get( null , UVMF_CONFIGURATIONS , controller_env_controller_out_agent_BFM , controller_env_controller_out_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( controller_out_configuration )::get cannot find resource controller_env_controller_out_agent_BFM" )
    if( !uvm_config_db #( imem_configuration )::get( null , UVMF_CONFIGURATIONS , imem_agent_BFM , imem_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( imem_configuration )::get cannot find resource imem_agent_BFM" )
    if( !uvm_config_db #( dmem_configuration )::get( null , UVMF_CONFIGURATIONS , dmem_agent_BFM , dmem_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( dmem_configuration )::get cannot find resource dmem_agent_BFM" )

    // Assign the sequencer handles from the handles within agent configurations
    fetch_env_fet_in_sequencer = fetch_env_fet_in_config.get_sequencer();
    fetch_env_fet_out_sequencer = fetch_env_fet_out_config.get_sequencer();
    decode_env_dec_in_sequencer = decode_env_dec_in_config.get_sequencer();
    decode_env_dec_out_sequencer = decode_env_dec_out_config.get_sequencer();
    execute_env_execute_in_agent_sequencer = execute_env_execute_in_agent_config.get_sequencer();
    execute_env_execute_out_agent_sequencer = execute_env_execute_out_agent_config.get_sequencer();
    writeback_env_wb_in_sequencer = writeback_env_wb_in_config.get_sequencer();
    writeback_env_wb_out_sequencer = writeback_env_wb_out_config.get_sequencer();
    memaccess_env_agent_in_sequencer = memaccess_env_agent_in_config.get_sequencer();
    memaccess_env_agent_out_sequencer = memaccess_env_agent_out_config.get_sequencer();
    controller_env_controller_in_agent_sequencer = controller_env_controller_in_agent_config.get_sequencer();
    controller_env_controller_out_agent_sequencer = controller_env_controller_out_agent_config.get_sequencer();
    imem_agent_sequencer = imem_agent_config.get_sequencer();
    dmem_agent_sequencer = dmem_agent_config.get_sequencer();

    //reg_model = top_configuration.lc3_rm;

    // pragma uvmf custom new begin
    // pragma uvmf custom new end

  endfunction

  // ****************************************************************************
  virtual task body();
    // pragma uvmf custom body begin

    // Construct sequences here

     lc3_env_seq = lc3_env_sequence_base_t::type_id::create("lc3_env_seq");

    fetch_env_fet_in_random_seq     = fetch_env_fet_in_random_seq_t::type_id::create("fetch_env_fet_in_random_seq");
    fetch_env_fet_out_random_seq     = fetch_env_fet_out_random_seq_t::type_id::create("fetch_env_fet_out_random_seq");
    decode_env_dec_in_random_seq     = decode_env_dec_in_random_seq_t::type_id::create("decode_env_dec_in_random_seq");
    decode_env_dec_out_random_seq     = decode_env_dec_out_random_seq_t::type_id::create("decode_env_dec_out_random_seq");
    execute_env_execute_in_agent_random_seq     = execute_env_execute_in_agent_random_seq_t::type_id::create("execute_env_execute_in_agent_random_seq");
    execute_env_execute_out_agent_random_seq     = execute_env_execute_out_agent_random_seq_t::type_id::create("execute_env_execute_out_agent_random_seq");
    writeback_env_wb_in_random_seq     = writeback_env_wb_in_random_seq_t::type_id::create("writeback_env_wb_in_random_seq");
    writeback_env_wb_out_random_seq     = writeback_env_wb_out_random_seq_t::type_id::create("writeback_env_wb_out_random_seq");
    memaccess_env_agent_in_random_seq     = memaccess_env_agent_in_random_seq_t::type_id::create("memaccess_env_agent_in_random_seq");
    memaccess_env_agent_out_random_seq     = memaccess_env_agent_out_random_seq_t::type_id::create("memaccess_env_agent_out_random_seq");
    controller_env_controller_in_agent_random_seq     = controller_env_controller_in_agent_random_seq_t::type_id::create("controller_env_controller_in_agent_random_seq");
    controller_env_controller_out_agent_random_seq     = controller_env_controller_out_agent_random_seq_t::type_id::create("controller_env_controller_out_agent_random_seq");
    imem_agent_responder_seq  = imem_agent_responder_seq_t::type_id::create("imem_agent_responder_seq");
    dmem_agent_responder_seq  = dmem_agent_responder_seq_t::type_id::create("dmem_agent_responder_seq");


    imem_misc_responder_seq  = imem_misc_responder_sequence::type_id::create("imem_misc_responder_seq");
    //
    fork
      fetch_env_fet_in_config.wait_for_reset();
      fetch_env_fet_out_config.wait_for_reset();
      decode_env_dec_in_config.wait_for_reset();
      decode_env_dec_out_config.wait_for_reset();
      execute_env_execute_in_agent_config.wait_for_reset();
      execute_env_execute_out_agent_config.wait_for_reset();
      writeback_env_wb_in_config.wait_for_reset();
      writeback_env_wb_out_config.wait_for_reset();
      memaccess_env_agent_in_config.wait_for_reset();
      memaccess_env_agent_out_config.wait_for_reset();
      controller_env_controller_in_agent_config.wait_for_reset();
      controller_env_controller_out_agent_config.wait_for_reset();
      imem_agent_config.wait_for_reset();
      dmem_agent_config.wait_for_reset();
    join
        //reg_model.reset();
    // Start RESPONDER sequences here
    fork
      imem_agent_responder_seq.start(imem_agent_sequencer);

      dmem_agent_responder_seq.start(dmem_agent_sequencer);
    join_any

 

    fork
      fetch_env_fet_in_config.wait_for_num_clocks(40);
      fetch_env_fet_out_config.wait_for_num_clocks(40);
      decode_env_dec_in_config.wait_for_num_clocks(40);
      decode_env_dec_out_config.wait_for_num_clocks(40);
      execute_env_execute_in_agent_config.wait_for_num_clocks(40);
      execute_env_execute_out_agent_config.wait_for_num_clocks(40);
      writeback_env_wb_in_config.wait_for_num_clocks(40);
      writeback_env_wb_out_config.wait_for_num_clocks(40);
      memaccess_env_agent_in_config.wait_for_num_clocks(40);
      memaccess_env_agent_out_config.wait_for_num_clocks(40);
      controller_env_controller_in_agent_config.wait_for_num_clocks(40);
      controller_env_controller_out_agent_config.wait_for_num_clocks(40);
      imem_agent_config.wait_for_num_clocks(40);
      dmem_agent_config.wait_for_num_clocks(40);
    join

    // pragma uvmf custom body end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end