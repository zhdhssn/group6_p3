//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
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

//Harry's note: this is centralized control, we place all the sequences and coordinators here
//it acts as a virtual sequence that
// Coordinates sequences for all pipeline stages
// Manages instruction memory (imem) and data memory (dmem) sequences
// Controls test flow and timing
// Allows testing the full pipeline or individual stages
class LC3_bench_sequence_base extends uvmf_sequence_base #(uvm_sequence_item);

  `uvm_object_utils( LC3_bench_sequence_base );

  // pragma uvmf custom sequences begin

// This example shows how to use the environment sequence base
// It can only be used on environments generated with UVMF_2022.3 and later.
// Environment sequences generated with UVMF_2022.1 and earlier do not have the required 
//    environment level virtual sequencer
// typedef lc3_env_sequence_base #(
//         .CONFIG_T(lc3_env_configuration_t)// 
//         )
//         lc3_env_sequence_base_t;
// rand lc3_env_sequence_base_t lc3_env_seq;



  // UVMF_CHANGE_ME : Instantiate, construct, and start sequences as needed to create stimulus scenarios.
  // Instantiate sequences here
  typedef fetch_in_random_sequence  fetch_env_fetch_in_agent_random_seq_t;
  fetch_env_fetch_in_agent_random_seq_t fetch_env_fetch_in_agent_random_seq;
  typedef fetch_out_responder_sequence  fetch_env_fetch_out_agent_responder_seq_t;
  fetch_env_fetch_out_agent_responder_seq_t fetch_env_fetch_out_agent_responder_seq;
  typedef decode_in_random_sequence  decode_env_dec_in_agent_random_seq_t;
  decode_env_dec_in_agent_random_seq_t decode_env_dec_in_agent_random_seq;
  typedef decode_out_responder_sequence  decode_env_dec_out_agent_responder_seq_t;
  decode_env_dec_out_agent_responder_seq_t decode_env_dec_out_agent_responder_seq;
  typedef execute_in_random_sequence  execute_env_exe_in_agent_random_seq_t;
  execute_env_exe_in_agent_random_seq_t execute_env_exe_in_agent_random_seq;
  typedef execute_out_responder_sequence  execute_env_exe_out_agent_responder_seq_t;
  execute_env_exe_out_agent_responder_seq_t execute_env_exe_out_agent_responder_seq;
  typedef memaccess_in_random_sequence  memaccess_env_memaccess_in_agt_random_seq_t;
  memaccess_env_memaccess_in_agt_random_seq_t memaccess_env_memaccess_in_agt_random_seq;
  typedef memaccess_out_responder_sequence  memaccess_env_memaccess_out_agt_responder_seq_t;
  memaccess_env_memaccess_out_agt_responder_seq_t memaccess_env_memaccess_out_agt_responder_seq;
  typedef writeback_in_responder_sequence  writeback_env_writeback_in_agent_responder_seq_t;
  writeback_env_writeback_in_agent_responder_seq_t writeback_env_writeback_in_agent_responder_seq;
  typedef writeback_out_responder_sequence  writeback_env_writeback_out_agent_responder_seq_t;
  writeback_env_writeback_out_agent_responder_seq_t writeback_env_writeback_out_agent_responder_seq;
  typedef controller_in_random_sequence  controller_env_controller_in_agent_random_seq_t;
  controller_env_controller_in_agent_random_seq_t controller_env_controller_in_agent_random_seq;
  typedef controller_out_random_sequence  controller_env_controller_out_agent_random_seq_t;
  controller_env_controller_out_agent_random_seq_t controller_env_controller_out_agent_random_seq;
  // typedef fetch_out_responder_sequence  imem_agent_responder_seq_t;
  // imem_agent_responder_seq_t imem_agent_responder_seq;
  //Harry: comment out the code above and uncomment the code below
  typedef imem_responder_sequence  imem_agent_responder_seq_t;
  imem_agent_responder_seq_t imem_agent_responder_seq;
  typedef dmem_responder_sequence  dmem_agent_responder_seq_t;
  dmem_agent_responder_seq_t dmem_agent_responder_seq;
  // pragma uvmf custom sequences end

  // Sequencer handles for each active interface in the environment
  typedef fetch_in_transaction  fetch_env_fetch_in_agent_transaction_t;
  uvm_sequencer #(fetch_env_fetch_in_agent_transaction_t)  fetch_env_fetch_in_agent_sequencer; 
  typedef fetch_out_transaction  fetch_env_fetch_out_agent_transaction_t;
  uvm_sequencer #(fetch_env_fetch_out_agent_transaction_t)  fetch_env_fetch_out_agent_sequencer; 
  typedef decode_in_transaction  decode_env_dec_in_agent_transaction_t;
  uvm_sequencer #(decode_env_dec_in_agent_transaction_t)  decode_env_dec_in_agent_sequencer; 
  typedef decode_out_transaction  decode_env_dec_out_agent_transaction_t;
  uvm_sequencer #(decode_env_dec_out_agent_transaction_t)  decode_env_dec_out_agent_sequencer; 
  typedef execute_in_transaction  execute_env_exe_in_agent_transaction_t;
  uvm_sequencer #(execute_env_exe_in_agent_transaction_t)  execute_env_exe_in_agent_sequencer; 
  typedef execute_out_transaction  execute_env_exe_out_agent_transaction_t;
  uvm_sequencer #(execute_env_exe_out_agent_transaction_t)  execute_env_exe_out_agent_sequencer; 
  typedef memaccess_in_transaction  memaccess_env_memaccess_in_agt_transaction_t;
  uvm_sequencer #(memaccess_env_memaccess_in_agt_transaction_t)  memaccess_env_memaccess_in_agt_sequencer; 
  typedef memaccess_out_transaction  memaccess_env_memaccess_out_agt_transaction_t;
  uvm_sequencer #(memaccess_env_memaccess_out_agt_transaction_t)  memaccess_env_memaccess_out_agt_sequencer; 
  typedef writeback_in_transaction  writeback_env_writeback_in_agent_transaction_t;
  uvm_sequencer #(writeback_env_writeback_in_agent_transaction_t)  writeback_env_writeback_in_agent_sequencer; 
  typedef writeback_out_transaction  writeback_env_writeback_out_agent_transaction_t;
  uvm_sequencer #(writeback_env_writeback_out_agent_transaction_t)  writeback_env_writeback_out_agent_sequencer; 
  typedef controller_in_transaction  controller_env_controller_in_agent_transaction_t;
  uvm_sequencer #(controller_env_controller_in_agent_transaction_t)  controller_env_controller_in_agent_sequencer; 
  typedef controller_out_transaction  controller_env_controller_out_agent_transaction_t;
  uvm_sequencer #(controller_env_controller_out_agent_transaction_t)  controller_env_controller_out_agent_sequencer; 
  // typedef fetch_out_transaction  imem_agent_transaction_t;
  // uvm_sequencer #(imem_agent_transaction_t)  imem_agent_sequencer; 
  //Harry: comment out the code above and uncomment the code below
  typedef imem_transaction  imem_agent_transaction_t;
  uvm_sequencer #(imem_agent_transaction_t)  imem_agent_sequencer;
  typedef dmem_transaction  dmem_agent_transaction_t;
  uvm_sequencer #(dmem_agent_transaction_t)  dmem_agent_sequencer; 


  // Top level environment configuration handle
  lc3_env_configuration_t top_configuration;

  // Configuration handles to access interface BFM's
  fetch_in_configuration  fetch_env_fetch_in_agent_config;
  fetch_out_configuration  fetch_env_fetch_out_agent_config;
  decode_in_configuration  decode_env_dec_in_agent_config;
  decode_out_configuration  decode_env_dec_out_agent_config;
  execute_in_configuration  execute_env_exe_in_agent_config;
  execute_out_configuration  execute_env_exe_out_agent_config;
  memaccess_in_configuration  memaccess_env_memaccess_in_agt_config;
  memaccess_out_configuration  memaccess_env_memaccess_out_agt_config;
  writeback_in_configuration  writeback_env_writeback_in_agent_config;
  writeback_out_configuration  writeback_env_writeback_out_agent_config;
  controller_in_configuration  controller_env_controller_in_agent_config;
  controller_out_configuration  controller_env_controller_out_agent_config;
  //fetch_out_configuration  imem_agent_config;
  //Harry comment the code above and change to the below one
  imem_configuration imem_agent_config;
  dmem_configuration  dmem_agent_config;

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
    if( !uvm_config_db #( fetch_in_configuration )::get( null , UVMF_CONFIGURATIONS , fetch_env_fetch_in_agent_BFM , fetch_env_fetch_in_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( fetch_in_configuration )::get cannot find resource fetch_env_fetch_in_agent_BFM" )
    if( !uvm_config_db #( fetch_out_configuration )::get( null , UVMF_CONFIGURATIONS , fetch_env_fetch_out_agent_BFM , fetch_env_fetch_out_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( fetch_out_configuration )::get cannot find resource fetch_env_fetch_out_agent_BFM" )
    if( !uvm_config_db #( decode_in_configuration )::get( null , UVMF_CONFIGURATIONS , decode_env_dec_in_agent_BFM , decode_env_dec_in_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( decode_in_configuration )::get cannot find resource decode_env_dec_in_agent_BFM" )
    if( !uvm_config_db #( decode_out_configuration )::get( null , UVMF_CONFIGURATIONS , decode_env_dec_out_agent_BFM , decode_env_dec_out_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( decode_out_configuration )::get cannot find resource decode_env_dec_out_agent_BFM" )
    if( !uvm_config_db #( execute_in_configuration )::get( null , UVMF_CONFIGURATIONS , execute_env_exe_in_agent_BFM , execute_env_exe_in_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( execute_in_configuration )::get cannot find resource execute_env_exe_in_agent_BFM" )
    if( !uvm_config_db #( execute_out_configuration )::get( null , UVMF_CONFIGURATIONS , execute_env_exe_out_agent_BFM , execute_env_exe_out_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( execute_out_configuration )::get cannot find resource execute_env_exe_out_agent_BFM" )
    if( !uvm_config_db #( memaccess_in_configuration )::get( null , UVMF_CONFIGURATIONS , memaccess_env_memaccess_in_agt_BFM , memaccess_env_memaccess_in_agt_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( memaccess_in_configuration )::get cannot find resource memaccess_env_memaccess_in_agt_BFM" )
    if( !uvm_config_db #( memaccess_out_configuration )::get( null , UVMF_CONFIGURATIONS , memaccess_env_memaccess_out_agt_BFM , memaccess_env_memaccess_out_agt_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( memaccess_out_configuration )::get cannot find resource memaccess_env_memaccess_out_agt_BFM" )
    if( !uvm_config_db #( writeback_in_configuration )::get( null , UVMF_CONFIGURATIONS , writeback_env_writeback_in_agent_BFM , writeback_env_writeback_in_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( writeback_in_configuration )::get cannot find resource writeback_env_writeback_in_agent_BFM" )
    if( !uvm_config_db #( writeback_out_configuration )::get( null , UVMF_CONFIGURATIONS , writeback_env_writeback_out_agent_BFM , writeback_env_writeback_out_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( writeback_out_configuration )::get cannot find resource writeback_env_writeback_out_agent_BFM" )
    if( !uvm_config_db #( controller_in_configuration )::get( null , UVMF_CONFIGURATIONS , controller_env_controller_in_agent_BFM , controller_env_controller_in_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( controller_in_configuration )::get cannot find resource controller_env_controller_in_agent_BFM" )
    if( !uvm_config_db #( controller_out_configuration )::get( null , UVMF_CONFIGURATIONS , controller_env_controller_out_agent_BFM , controller_env_controller_out_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( controller_out_configuration )::get cannot find resource controller_env_controller_out_agent_BFM" )
    // if( !uvm_config_db #( fetch_out_configuration )::get( null , UVMF_CONFIGURATIONS , imem_agent_BFM , imem_agent_config ) ) 
    //   `uvm_fatal("CFG" , "uvm_config_db #( fetch_out_configuration )::get cannot find resource imem_agent_BFM" )
    //Harry: comment out the code above and uncomment the code below
    if( !uvm_config_db #( imem_configuration )::get( null , UVMF_CONFIGURATIONS , imem_agent_BFM , imem_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( imem_configuration )::get cannot find resource imem_agent_BFM" )
    if( !uvm_config_db #( dmem_configuration )::get( null , UVMF_CONFIGURATIONS , dmem_agent_BFM , dmem_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( dmem_configuration )::get cannot find resource dmem_agent_BFM" )

    // Assign the sequencer handles from the handles within agent configurations
    fetch_env_fetch_in_agent_sequencer = fetch_env_fetch_in_agent_config.get_sequencer();
    fetch_env_fetch_out_agent_sequencer = fetch_env_fetch_out_agent_config.get_sequencer();
    decode_env_dec_in_agent_sequencer = decode_env_dec_in_agent_config.get_sequencer();
    decode_env_dec_out_agent_sequencer = decode_env_dec_out_agent_config.get_sequencer();
    execute_env_exe_in_agent_sequencer = execute_env_exe_in_agent_config.get_sequencer();
    execute_env_exe_out_agent_sequencer = execute_env_exe_out_agent_config.get_sequencer();
    memaccess_env_memaccess_in_agt_sequencer = memaccess_env_memaccess_in_agt_config.get_sequencer();
    memaccess_env_memaccess_out_agt_sequencer = memaccess_env_memaccess_out_agt_config.get_sequencer();
    writeback_env_writeback_in_agent_sequencer = writeback_env_writeback_in_agent_config.get_sequencer();
    writeback_env_writeback_out_agent_sequencer = writeback_env_writeback_out_agent_config.get_sequencer();
    controller_env_controller_in_agent_sequencer = controller_env_controller_in_agent_config.get_sequencer();
    controller_env_controller_out_agent_sequencer = controller_env_controller_out_agent_config.get_sequencer();
    imem_agent_sequencer = imem_agent_config.get_sequencer();
    dmem_agent_sequencer = dmem_agent_config.get_sequencer();



    // pragma uvmf custom new begin
    // pragma uvmf custom new end

  endfunction

  // ****************************************************************************
  virtual task body();
    // pragma uvmf custom body begin

    // Construct sequences here

    // lc3_env_seq = lc3_env_sequence_base_t::type_id::create("lc3_env_seq");

//Harry: comment these seq out as we dont need to gen random sequence for each stage
    // fetch_env_fetch_in_agent_random_seq     = fetch_env_fetch_in_agent_random_seq_t::type_id::create("fetch_env_fetch_in_agent_random_seq");
    // fetch_env_fetch_out_agent_responder_seq  = fetch_env_fetch_out_agent_responder_seq_t::type_id::create("fetch_env_fetch_out_agent_responder_seq");
    // decode_env_dec_in_agent_random_seq     = decode_env_dec_in_agent_random_seq_t::type_id::create("decode_env_dec_in_agent_random_seq");
    // decode_env_dec_out_agent_responder_seq  = decode_env_dec_out_agent_responder_seq_t::type_id::create("decode_env_dec_out_agent_responder_seq");
    // execute_env_exe_in_agent_random_seq     = execute_env_exe_in_agent_random_seq_t::type_id::create("execute_env_exe_in_agent_random_seq");
    // execute_env_exe_out_agent_responder_seq  = execute_env_exe_out_agent_responder_seq_t::type_id::create("execute_env_exe_out_agent_responder_seq");
    // memaccess_env_memaccess_in_agt_random_seq     = memaccess_env_memaccess_in_agt_random_seq_t::type_id::create("memaccess_env_memaccess_in_agt_random_seq");
    // memaccess_env_memaccess_out_agt_responder_seq  = memaccess_env_memaccess_out_agt_responder_seq_t::type_id::create("memaccess_env_memaccess_out_agt_responder_seq");
    // writeback_env_writeback_in_agent_responder_seq  = writeback_env_writeback_in_agent_responder_seq_t::type_id::create("writeback_env_writeback_in_agent_responder_seq");
    // writeback_env_writeback_out_agent_responder_seq  = writeback_env_writeback_out_agent_responder_seq_t::type_id::create("writeback_env_writeback_out_agent_responder_seq");
    // controller_env_controller_in_agent_random_seq     = controller_env_controller_in_agent_random_seq_t::type_id::create("controller_env_controller_in_agent_random_seq");
    // controller_env_controller_out_agent_random_seq     = controller_env_controller_out_agent_random_seq_t::type_id::create("controller_env_controller_out_agent_random_seq");

    //Harry: debug message
    `uvm_info("LC3_BENCH_SEQUENCE_BASE", "Harry-> creating imem_agent_responder_seq...", UVM_HIGH)
    imem_agent_responder_seq  = imem_agent_responder_seq_t::type_id::create("imem_agent_responder_seq");
    `uvm_info("LC3_BENCH_SEQUENCE_BASE", "Harry-> created imem_agent_responder_seq...", UVM_HIGH)

    dmem_agent_responder_seq  = dmem_agent_responder_seq_t::type_id::create("dmem_agent_responder_seq");


    fork
      fetch_env_fetch_in_agent_config.wait_for_reset();
      fetch_env_fetch_out_agent_config.wait_for_reset();
      decode_env_dec_in_agent_config.wait_for_reset();
      decode_env_dec_out_agent_config.wait_for_reset();
      execute_env_exe_in_agent_config.wait_for_reset();
      execute_env_exe_out_agent_config.wait_for_reset();
      memaccess_env_memaccess_in_agt_config.wait_for_reset();
      memaccess_env_memaccess_out_agt_config.wait_for_reset();
      writeback_env_writeback_in_agent_config.wait_for_reset();
      writeback_env_writeback_out_agent_config.wait_for_reset();
      controller_env_controller_in_agent_config.wait_for_reset();
      controller_env_controller_out_agent_config.wait_for_reset();
      imem_agent_config.wait_for_reset();
      dmem_agent_config.wait_for_reset();
    join

    // Start RESPONDER sequences here
    fork
      //Harry comment out the code below as we dont need to start the sequences for the fetch, decode, execute, memaccess, writeback stages
      // fetch_env_fetch_out_agent_responder_seq.start(fetch_env_fetch_out_agent_sequencer);
      // decode_env_dec_out_agent_responder_seq.start(decode_env_dec_out_agent_sequencer);
      // execute_env_exe_out_agent_responder_seq.start(execute_env_exe_out_agent_sequencer);
      // memaccess_env_memaccess_out_agt_responder_seq.start(memaccess_env_memaccess_out_agt_sequencer);
      // writeback_env_writeback_in_agent_responder_seq.start(writeback_env_writeback_in_agent_sequencer);
      // writeback_env_writeback_out_agent_responder_seq.start(writeback_env_writeback_out_agent_sequencer);
      imem_agent_responder_seq.start(imem_agent_sequencer);
      dmem_agent_responder_seq.start(dmem_agent_sequencer);
    join_none

    //Harry: comment out the code below as we dont need to start the sequences for the fetch, decode, execute, memaccess, writeback stages
    // Start INITIATOR sequences here
    // fork
    //   repeat (25) fetch_env_fetch_in_agent_random_seq.start(fetch_env_fetch_in_agent_sequencer);
    //   repeat (25) decode_env_dec_in_agent_random_seq.start(decode_env_dec_in_agent_sequencer);
    //   repeat (25) execute_env_exe_in_agent_random_seq.start(execute_env_exe_in_agent_sequencer);
    //   repeat (25) memaccess_env_memaccess_in_agt_random_seq.start(memaccess_env_memaccess_in_agt_sequencer);
    //   repeat (25) controller_env_controller_in_agent_random_seq.start(controller_env_controller_in_agent_sequencer);
    //   repeat (25) controller_env_controller_out_agent_random_seq.start(controller_env_controller_out_agent_sequencer);
    // join

// lc3_env_seq.start(top_configuration.vsqr);

    // UVMF_CHANGE_ME : Extend the simulation XXX number of clocks after 
    // the last sequence to allow for the last sequence item to flow 
    // through the design.
    fork
      fetch_env_fetch_in_agent_config.wait_for_num_clocks(400);
      fetch_env_fetch_out_agent_config.wait_for_num_clocks(400);
      decode_env_dec_in_agent_config.wait_for_num_clocks(400);
      decode_env_dec_out_agent_config.wait_for_num_clocks(400);
      execute_env_exe_in_agent_config.wait_for_num_clocks(400);
      execute_env_exe_out_agent_config.wait_for_num_clocks(400);
      memaccess_env_memaccess_in_agt_config.wait_for_num_clocks(400);
      memaccess_env_memaccess_out_agt_config.wait_for_num_clocks(400);
      writeback_env_writeback_in_agent_config.wait_for_num_clocks(400);
      writeback_env_writeback_out_agent_config.wait_for_num_clocks(400);
      controller_env_controller_in_agent_config.wait_for_num_clocks(400);
      controller_env_controller_out_agent_config.wait_for_num_clocks(400);
      imem_agent_config.wait_for_num_clocks(400);
      dmem_agent_config.wait_for_num_clocks(400);
    join

    // pragma uvmf custom body end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

