//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//
// DESCRIPTION: This analysis component contains analysis_exports for receiving
//   data and analysis_ports for sending data.
// 
//   This analysis component has the following analysis_exports that receive the 
//   listed transaction type.
//   
//   fet_in_agent_ae receives transactions of type  fetch_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  fet_sb_ap broadcasts transactions of type fetch_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class fetch_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  )
 extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( fetch_predictor #(
                              CONFIG_T,
                              BASE_T
                              )
)


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  

uvm_analysis_imp_analysis_export #(fetch_in_transaction, fetch_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )
) analysis_export;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(fetch_out_transaction) analysis_port;


  // Transaction variable for predicted values to be sent out fet_sb_ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 

  typedef fetch_out_transaction analysis_port_output_transaction_t;
  analysis_port_output_transaction_t analysis_port_output_transaction;


  // Code for sending output transaction out through fet_sb_ap


  // Define transaction handles for debug visibility 
 

   fetch_in_transaction analysis_export_debug;


  // pragma uvmf custom class_item_additional begin
  bit mod_output;
  // pragma uvmf custom class_item_additional end

  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
//    `uvm_warning("PREDICTOR_REVIEW", "This predictor has been created either through generation or re-generation with merging.  Remove this warning after the predictor has been reviewed.")
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);


    analysis_export = new("analysis_export", this);
    analysis_port =new("analysis_port", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: 
  // Transactions received through fet_in_agent_ae initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_analysis_export(fetch_in_transaction t);
    // pragma uvmf custom fet_in_agent_ae_predictor begin
    analysis_export_debug = t;
    


    `uvm_info("PRED", "Transaction Received through analysis_export", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    //fet_sb_ap_output_transaction = fet_sb_ap_output_transaction_t::type_id::create("fet_sb_ap_output_transaction");
    analysis_port_output_transaction = analysis_port_output_transaction_t::type_id::create("analysis_port_output_transaction");
    //  UVMF_CHANGE_ME: Implement predictor model here.  
    //
	  // mod_output = fetch_model(.enable_updatePC(t.enable_updatePC), .enable_fetch(t.enable_fetch), .br_taken(t.br_taken), .taddr(t.addr), .npc(fet_sb_ap_output_transaction.npc), .pc(fet_sb_ap_output_transaction.pc), instrmem_rd(fet_sb_ap_output_transaction.instrmem_rd));
	  mod_output = fetch_model(t.enable_updatePC, t.enable_fetch, t.br_taken, t.taddr, analysis_port_output_transaction.npc, analysis_port_output_transaction.pc, analysis_port_output_transaction.instrmem_rd);
// Print the inputs and outputs passed to fetch_model
//`uvm_info("FETCH_MODEL_PRINT", $sformatf("Arguments to fetch_model:\n  enable_updatePC: %0b\n  enable_fetch: %0b\n  br_taken: %0b\n  taddr: %0h\n  npc: %0h\n  pc: %0h\n  instrmem_rd: %0b",t.enable_updatePC, t.enable_fetch, t.br_taken, t.taddr,fet_sb_ap_output_transaction.npc, fet_sb_ap_output_transaction.pc, fet_sb_ap_output_transaction.instrmem_rd), UVM_LOW);

    // Code for sending output transaction out through fet_sb_ap
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    //
    if(mod_output==0)begin
    analysis_port.write(analysis_port_output_transaction);
    end

    // pragma uvmf custom fet_in_agent_ae_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

