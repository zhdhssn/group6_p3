//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface performs the execute_in signal monitoring.
//      It is accessed by the uvm execute_in monitor through a virtual
//      interface handle in the execute_in configuration.  It monitors the
//      signals passed in through the port connection named bus of
//      type execute_in_if.
//
//     Input signals from the execute_in_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//      Interface functions and tasks used by UVM components:
//             monitor(inout TRANS_T txn);
//                   This task receives the transaction, txn, from the
//                   UVM monitor and then populates variables in txn
//                   from values observed on bus activity.  This task
//                   blocks until an operation on the execute_in bus is complete.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import execute_in_pkg_hdl::*;
`include "src/execute_in_macros.svh"


interface execute_in_monitor_bfm 
  ( execute_in_if  bus );
  // The pragma below and additional ones in-lined further down are for running this BFM on Veloce
  // pragma attribute execute_in_monitor_bfm partition_interface_xif                                  

`ifndef XRTL
// This code is to aid in debugging parameter mismatches between the BFM and its corresponding agent.
// Enable this debug by setting UVM_VERBOSITY to UVM_DEBUG
// Setting UVM_VERBOSITY to UVM_DEBUG causes all BFM's and all agents to display their parameter settings.
// All of the messages from this feature have a UVM messaging id value of "CFG"
// The transcript or run.log can be parsed to ensure BFM parameter settings match its corresponding agents parameter settings.
import uvm_pkg::*;
`include "uvm_macros.svh"
initial begin : bfm_vs_agent_parameter_debug
  `uvm_info("CFG", 
      $psprintf("The BFM at '%m' has the following parameters: ", ),
      UVM_DEBUG)
end
`endif


  // Structure used to pass transaction data from monitor BFM to monitor class in agent.
`execute_in_MONITOR_STRUCT
  execute_in_monitor_s execute_in_monitor_struct;

  // Structure used to pass configuration data from monitor class to monitor BFM.
 `execute_in_CONFIGURATION_STRUCT
 

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;
  tri [5:0] e_control_i;
  tri [15:0] ir_i;
  tri [15:0] npc_in_i;
  tri  bypass_alu_1_i;
  tri  bypass_alu_2_i;
  tri  bypass_mem_1_i;
  tri  bypass_mem_2_i;
  tri [15:0] vsr1_i;
  tri [15:0] vsr2_i;
  tri [1:0] w_control_in_i;
  tri  mem_control_in_i;
  tri  enable_execute_i;
  tri [15:0] mem_bypass_val_i;
  assign clock_i = bus.clock;
  assign reset_i = bus.reset;
  assign e_control_i = bus.e_control;
  assign ir_i = bus.ir;
  assign npc_in_i = bus.npc_in;
  assign bypass_alu_1_i = bus.bypass_alu_1;
  assign bypass_alu_2_i = bus.bypass_alu_2;
  assign bypass_mem_1_i = bus.bypass_mem_1;
  assign bypass_mem_2_i = bus.bypass_mem_2;
  assign vsr1_i = bus.vsr1;
  assign vsr2_i = bus.vsr2;
  assign w_control_in_i = bus.w_control_in;
  assign mem_control_in_i = bus.mem_control_in;
  assign enable_execute_i = bus.enable_execute;
  assign mem_bypass_val_i = bus.mem_bypass_val;

  // Proxy handle to UVM monitor
  execute_in_pkg::execute_in_monitor  proxy;
  // pragma tbx oneway proxy.notify_transaction                 

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end
  
  //******************************************************************                         
  task wait_for_reset();// pragma tbx xtf  
    @(posedge clock_i) ;                                                                    
    do_wait_for_reset();                                                                   
  endtask                                                                                   

  // ****************************************************************************              
  task do_wait_for_reset(); 
  // pragma uvmf custom reset_condition begin
    wait ( reset_i === 0 ) ;                                                              
    @(posedge clock_i) ;                                                                    
  // pragma uvmf custom reset_condition end                                                                
  endtask    

  //******************************************************************                         
 
  task wait_for_num_clocks(input int unsigned count); // pragma tbx xtf 
    @(posedge clock_i);  
                                                                   
    repeat (count-1) @(posedge clock_i);                                                    
  endtask      

  //******************************************************************                         
  event go;                                                                                 
  function void start_monitoring();// pragma tbx xtf    
    -> go;
  endfunction                                                                               
  
  // ****************************************************************************              
  initial begin                                                                             
    @go;                                                                                   
    forever begin                                                                        
      @(posedge clock_i);  
      do_monitor( execute_in_monitor_struct );
                                                                 
 
      proxy.notify_transaction( execute_in_monitor_struct );
 
    end                                                                                    
  end                                                                                       

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the monitor BFM.  It is called by the monitor within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the monitor BFM needs to be aware of the new configuration 
  // variables.
  //
    function void configure(execute_in_configuration_s execute_in_configuration_arg); // pragma tbx xtf  
    initiator_responder = execute_in_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction   


  // ****************************************************************************  
            
  task do_monitor(output execute_in_monitor_s execute_in_monitor_struct);
    //
    // Available struct members:
    //     //    execute_in_monitor_struct.e_control
    //     //    execute_in_monitor_struct.ir
    //     //    execute_in_monitor_struct.npc_in
    //     //    execute_in_monitor_struct.bypass_alu_1
    //     //    execute_in_monitor_struct.bypass_alu_2
    //     //    execute_in_monitor_struct.bypass_mem_1
    //     //    execute_in_monitor_struct.bypass_mem_2
    //     //    execute_in_monitor_struct.vsr1
    //     //    execute_in_monitor_struct.vsr2
    //     //    execute_in_monitor_struct.w_control_in
    //     //    execute_in_monitor_struct.mem_control_in
    //     //    execute_in_monitor_struct.enable_execute
    //     //    execute_in_monitor_struct.mem_bypass_val
    //     //
    // Reference code;
    //    How to wait for signal value
    //      while (control_signal === 1'b1) @(posedge clock_i);
    //    
    //    How to assign a struct member, named xyz, from a signal.   
    //    All available input signals listed.
    //      execute_in_monitor_struct.xyz = e_control_i;  //    [5:0] 
    //      execute_in_monitor_struct.xyz = ir_i;  //    [15:0] 
    //      execute_in_monitor_struct.xyz = npc_in_i;  //    [15:0] 
    //      execute_in_monitor_struct.xyz = bypass_alu_1_i;  //     
    //      execute_in_monitor_struct.xyz = bypass_alu_2_i;  //     
    //      execute_in_monitor_struct.xyz = bypass_mem_1_i;  //     
    //      execute_in_monitor_struct.xyz = bypass_mem_2_i;  //     
    //      execute_in_monitor_struct.xyz = vsr1_i;  //    [15:0] 
    //      execute_in_monitor_struct.xyz = vsr2_i;  //    [15:0] 
    //      execute_in_monitor_struct.xyz = w_control_in_i;  //    [1:0] 
    //      execute_in_monitor_struct.xyz = mem_control_in_i;  //     
    //      execute_in_monitor_struct.xyz = enable_execute_i;  //     
    //      execute_in_monitor_struct.xyz = mem_bypass_val_i;  //    [15:0] 
    // pragma uvmf custom do_monitor begin
    // UVMF_CHANGE_ME : Implement protocol monitoring.  The commented reference code 
    // below are examples of how to capture signal values and assign them to 
    // structure members.  All available input signals are listed.  The 'while' 
    // code example shows how to wait for a synchronous flow control signal.  This
    // task should return when a complete transfer has been observed.  Once this task is
    // exited with captured values, it is then called again to wait for and observe 
    // the next transfer. One clock cycle is consumed between calls to do_monitor.
    // @(posedge clock_i);
    // @(posedge clock_i);
    // @(posedge clock_i);
    // @(posedge clock_i);

    if(reset_i) wait_for_reset();

    while (enable_execute_i === 1'b0) @(posedge clock_i);

    execute_in_monitor_struct.e_control = e_control_i;  //    [5:0]
    execute_in_monitor_struct.ir = ir_i;  //    [15:0]
    execute_in_monitor_struct.npc_in = npc_in_i;  //    [15:0]
    execute_in_monitor_struct.bypass_alu_1 = bypass_alu_1_i;  //
    execute_in_monitor_struct.bypass_alu_2 = bypass_alu_2_i;  //
    execute_in_monitor_struct.bypass_mem_1 = bypass_mem_1_i;  //
    execute_in_monitor_struct.bypass_mem_2 = bypass_mem_2_i;  //
    execute_in_monitor_struct.vsr1 = vsr1_i;  //    [15:0]
    execute_in_monitor_struct.vsr2 = vsr2_i;  //    [15:0]
    execute_in_monitor_struct.w_control_in = w_control_in_i;  //    [1:0]
    execute_in_monitor_struct.mem_control_in = mem_control_in_i;  //
    execute_in_monitor_struct.enable_execute = enable_execute_i;  //
    execute_in_monitor_struct.mem_bypass_val = mem_bypass_val_i;  //
    
    // pragma uvmf custom do_monitor end
  endtask         
  
 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

