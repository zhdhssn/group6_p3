//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This environment contains all agents, predictors and
// scoreboards required for the block level design.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class controller_environment  extends uvmf_environment_base #(
    .CONFIG_T( controller_env_configuration 
  ));
  `uvm_component_utils( controller_environment )





  typedef controller_in_agent  controller_in_agent_t;
  controller_in_agent_t controller_in_agent;

  typedef controller_out_agent  controller_out_agent_t;
  controller_out_agent_t controller_out_agent;




  typedef controller_predictor #(
                .CONFIG_T(CONFIG_T)
                )
 controller_pred_t;
  controller_pred_t controller_pred;

  typedef uvmf_in_order_race_scoreboard #(.T(controller_out_transaction))  controller_scoreboard_t;
  controller_scoreboard_t controller_scoreboard;



  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(controller_env_configuration)) controller_vsqr_t;
  controller_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
 
// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// FUNCTION: build_phase()
// This function builds all components within this environment.
//
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    controller_in_agent = controller_in_agent_t::type_id::create("controller_in_agent",this);
    controller_in_agent.set_config(configuration.controller_in_agent_config);
    controller_out_agent = controller_out_agent_t::type_id::create("controller_out_agent",this);
    controller_out_agent.set_config(configuration.controller_out_agent_config);
    controller_pred = controller_pred_t::type_id::create("controller_pred",this);
    controller_pred.configuration = configuration;
    controller_scoreboard = controller_scoreboard_t::type_id::create("controller_scoreboard",this);

    vsqr = controller_vsqr_t::type_id::create("vsqr", this);
    vsqr.set_config(configuration);
    configuration.set_vsqr(vsqr);

    // pragma uvmf custom build_phase begin
    // pragma uvmf custom build_phase end
  endfunction

// ****************************************************************************
// FUNCTION: connect_phase()
// This function makes all connections within this environment.  Connections
// typically inclue agent to predictor, predictor to scoreboard and scoreboard
// to agent.
//
  virtual function void connect_phase(uvm_phase phase);
// pragma uvmf custom connect_phase_pre_super begin
// pragma uvmf custom connect_phase_pre_super end
    super.connect_phase(phase);
    controller_in_agent.monitored_ap.connect(controller_pred.analysis_export);
    controller_out_agent.monitored_ap.connect(controller_scoreboard.actual_analysis_export);
    controller_pred.analysis_port.connect(controller_scoreboard.expected_analysis_export);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

// ****************************************************************************
// FUNCTION: end_of_simulation_phase()
// This function is executed just prior to executing run_phase.  This function
// was added to the environment to sample environment configuration settings
// just before the simulation exits time 0.  The configuration structure is 
// randomized in the build phase before the environment structure is constructed.
// Configuration variables can be customized after randomization in the build_phase
// of the extended test.
// If a sequence modifies values in the configuration structure then the sequence is
// responsible for sampling the covergroup in the configuration if required.
//
  virtual function void start_of_simulation_phase(uvm_phase phase);
     configuration.controller_configuration_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

