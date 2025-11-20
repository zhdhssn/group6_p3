//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the execute_out interface signals.
//      It is instantiated once per execute_out bus.  Bus Functional Models, 
//      BFM's named execute_out_driver_bfm, are used to drive signals on the bus.
//      BFM's named execute_out_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(execute_out_bus.w_control_out), // Agent input 
// .dut_signal_port(execute_out_bus.mem_control_out), // Agent input 
// .dut_signal_port(execute_out_bus.aluout), // Agent input 
// .dut_signal_port(execute_out_bus.pcout), // Agent input 
// .dut_signal_port(execute_out_bus.dr), // Agent input 
// .dut_signal_port(execute_out_bus.sr1), // Agent input 
// .dut_signal_port(execute_out_bus.sr2), // Agent input 
// .dut_signal_port(execute_out_bus.ir_exec), // Agent input 
// .dut_signal_port(execute_out_bus.nzp), // Agent input 
// .dut_signal_port(execute_out_bus.m_data), // Agent input 
// .dut_signal_port(execute_out_bus.enable_execute), // Agent input 

import uvmf_base_pkg_hdl::*;
import execute_out_pkg_hdl::*;

interface  execute_out_if 

  (
  input tri clock, 
  input tri reset,
  inout tri [1:0] w_control_out,
  inout tri  mem_control_out,
  inout tri [15:0] aluout,
  inout tri [15:0] pcout,
  inout tri [2:0] dr,
  inout tri [2:0] sr1,
  inout tri [2:0] sr2,
  inout tri [15:0] ir_exec,
  inout tri [2:0] nzp,
  inout tri [15:0] m_data,
  inout tri  enable_execute
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input w_control_out,
  input mem_control_out,
  input aluout,
  input pcout,
  input dr,
  input sr1,
  input sr2,
  input ir_exec,
  input nzp,
  input m_data,
  input enable_execute
  );

modport initiator_port 
  (
  input clock,
  input reset,
  input w_control_out,
  input mem_control_out,
  input aluout,
  input pcout,
  input dr,
  input sr1,
  input sr2,
  input ir_exec,
  input nzp,
  input m_data,
  input enable_execute
  );

modport responder_port 
  (
  input clock,
  input reset,  
  output w_control_out,
  output mem_control_out,
  output aluout,
  output pcout,
  output dr,
  output sr1,
  output sr2,
  output ir_exec,
  output nzp,
  output m_data,
  output enable_execute
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

