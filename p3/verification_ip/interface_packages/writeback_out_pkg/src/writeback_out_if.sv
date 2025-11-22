//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the writeback_out interface signals.
//      It is instantiated once per writeback_out bus.  Bus Functional Models, 
//      BFM's named writeback_out_driver_bfm, are used to drive signals on the bus.
//      BFM's named writeback_out_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(writeback_out_bus.psr), // Agent input 
// .dut_signal_port(writeback_out_bus.vsr1), // Agent input 
// .dut_signal_port(writeback_out_bus.vsr2), // Agent input 

import uvmf_base_pkg_hdl::*;
import writeback_out_pkg_hdl::*;

interface  writeback_out_if 

  (
  input tri clock, 
  input tri reset,
  inout tri [2:0] psr,
  inout tri [15:0] vsr1,
  inout tri [15:0] vsr2
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input psr,
  input vsr1,
  input vsr2
  );

modport initiator_port 
  (
  input clock,
  input reset,
  input psr,
  input vsr1,
  input vsr2
  );

modport responder_port 
  (
  input clock,
  input reset,  
  output psr,
  output vsr1,
  output vsr2
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

