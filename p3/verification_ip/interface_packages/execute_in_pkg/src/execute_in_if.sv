//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the execute_in interface signals.
//      It is instantiated once per execute_in bus.  Bus Functional Models, 
//      BFM's named execute_in_driver_bfm, are used to drive signals on the bus.
//      BFM's named execute_in_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(execute_in_bus.e_control), // Agent output 
// .dut_signal_port(execute_in_bus.ir), // Agent output 
// .dut_signal_port(execute_in_bus.npc_in), // Agent output 
// .dut_signal_port(execute_in_bus.bypass_alu_1), // Agent output 
// .dut_signal_port(execute_in_bus.bypass_alu_2), // Agent output 
// .dut_signal_port(execute_in_bus.bypass_mem_1), // Agent output 
// .dut_signal_port(execute_in_bus.bypass_mem_2), // Agent output 
// .dut_signal_port(execute_in_bus.vsr1), // Agent output 
// .dut_signal_port(execute_in_bus.vsr2), // Agent output 
// .dut_signal_port(execute_in_bus.w_control_in), // Agent output 
// .dut_signal_port(execute_in_bus.mem_control_in), // Agent output 
// .dut_signal_port(execute_in_bus.enable_execute), // Agent output 
// .dut_signal_port(execute_in_bus.mem_bypass_val), // Agent output 

import uvmf_base_pkg_hdl::*;
import execute_in_pkg_hdl::*;

interface  execute_in_if 

  (
  input tri clock, 
  input tri reset,
  inout tri [5:0] e_control,
  inout tri [15:0] ir,
  inout tri [15:0] npc_in,
  inout tri  bypass_alu_1,
  inout tri  bypass_alu_2,
  inout tri  bypass_mem_1,
  inout tri  bypass_mem_2,
  inout tri [15:0] vsr1,
  inout tri [15:0] vsr2,
  inout tri [1:0] w_control_in,
  inout tri  mem_control_in,
  inout tri  enable_execute,
  inout tri [15:0] mem_bypass_val
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input e_control,
  input ir,
  input npc_in,
  input bypass_alu_1,
  input bypass_alu_2,
  input bypass_mem_1,
  input bypass_mem_2,
  input vsr1,
  input vsr2,
  input w_control_in,
  input mem_control_in,
  input enable_execute,
  input mem_bypass_val
  );

modport initiator_port 
  (
  input clock,
  input reset,
  output e_control,
  output ir,
  output npc_in,
  output bypass_alu_1,
  output bypass_alu_2,
  output bypass_mem_1,
  output bypass_mem_2,
  output vsr1,
  output vsr2,
  output w_control_in,
  output mem_control_in,
  output enable_execute,
  output mem_bypass_val
  );

modport responder_port 
  (
  input clock,
  input reset,  
  input e_control,
  input ir,
  input npc_in,
  input bypass_alu_1,
  input bypass_alu_2,
  input bypass_mem_1,
  input bypass_mem_2,
  input vsr1,
  input vsr2,
  input w_control_in,
  input mem_control_in,
  input enable_execute,
  input mem_bypass_val
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

