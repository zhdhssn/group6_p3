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
//   execute_in_agent_ae receives transactions of type  execute_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  execute_in_sb_ap broadcasts transactions of type execute_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class execute_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  )
 extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( execute_predictor #(
                              CONFIG_T,
                              BASE_T
                              )
)


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_execute_in_agent_ae #(execute_in_transaction, execute_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )
) execute_in_agent_ae;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(execute_out_transaction) execute_in_sb_ap;


  // Transaction variable for predicted values to be sent out execute_in_sb_ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef execute_out_transaction execute_in_sb_ap_output_transaction_t;
  execute_in_sb_ap_output_transaction_t execute_in_sb_ap_output_transaction;
  // Code for sending output transaction out through execute_in_sb_ap
  // execute_in_sb_ap.write(execute_in_sb_ap_output_transaction);

  // Define transaction handles for debug visibility 
  execute_in_transaction execute_in_agent_ae_debug;


  // pragma uvmf custom class_item_additional begin
    bit ex_model_output;
  // pragma uvmf custom class_item_additional end

  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
 //   `uvm_warning("PREDICTOR_REVIEW", "This predictor has been created either through generation or re-generation with merging.  Remove this warning after the predictor has been reviewed.")
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);

    execute_in_agent_ae = new("execute_in_agent_ae", this);
    execute_in_sb_ap =new("execute_in_sb_ap", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_execute_in_agent_ae
  // Transactions received through execute_in_agent_ae initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_execute_in_agent_ae(execute_in_transaction t);
    // pragma uvmf custom execute_in_agent_ae_predictor begin
    execute_in_agent_ae_debug = t;
    `uvm_info("PRED", "Transaction Received through execute_in_agent_ae", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    execute_in_sb_ap_output_transaction = execute_in_sb_ap_output_transaction_t::type_id::create("execute_in_sb_ap_output_transaction");
    //  UVMF_CHANGE_ME: Implement predictor model here.  
	  ex_model_output = execute_model(.E_Control(t.E_control), .bypass_alu_1(t.bypass_alu_1), .bypass_alu_2(t.bypass_alu_2), .bypass_mem_1(t.bypass_mem_1), .bypass_mem_2(t.bypass_mem_2), .enable_execute(t.enable_execute), .IR(t.IR), .npc_in(t.npc_in), .Mem_Control_in(t.Mem_Control_in), .W_Control_in(t.W_control_in),.Mem_Bypass_Val(t.Mem_Bypass_Val), .VSR1(t.VSR1), .VSR2(t.VSR2), .aluout(execute_in_sb_ap_output_transaction.aluout), .W_Control_out(execute_in_sb_ap_output_transaction.W_Control_out), .Mem_Control_out(execute_in_sb_ap_output_transaction.Mem_Control_out), .M_Data(execute_in_sb_ap_output_transaction.M_Data), .dr(execute_in_sb_ap_output_transaction.dr), .sr1(execute_in_sb_ap_output_transaction.sr1), .sr2(execute_in_sb_ap_output_transaction.sr2), .IR_Exec(execute_in_sb_ap_output_transaction.IR_Exec), .NZP(execute_in_sb_ap_output_transaction.NZP), .pcout(execute_in_sb_ap_output_transaction.pcout));
 
    // Code for sending output transaction out through execute_in_sb_ap
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    if(ex_model_output==0)begin
    execute_in_sb_ap.write(execute_in_sb_ap_output_transaction);
    end
    // pragma uvmf custom execute_in_agent_ae_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end