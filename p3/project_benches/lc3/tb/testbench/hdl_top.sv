//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------                     
//               
// Description: This top level module instantiates all synthesizable
//    static content.  This and tb_top.sv are the two top level modules
//    of the simulation.  
//
//    This module instantiates the following:
//        DUT: The Design Under Test
//        Interfaces:  Signal bundles that contain signals connected to DUT
//        Driver BFM's: BFM's that actively drive interface signals
//        Monitor BFM's: BFM's that passively monitor interface signals
//
//----------------------------------------------------------------------

//----------------------------------------------------------------------
//

module hdl_top;

import LC3_parameters_pkg::*;
import uvmf_base_pkg_hdl::*;

  // pragma attribute hdl_top partition_module_xrtl                                            
// pragma uvmf custom clock_generator begin
  bit clk;
  // Instantiate a clk driver 
  // tbx clkgen
  initial begin
    clk = 0;
    #9ns;
    forever begin
      clk = ~clk;
      #5ns;
    end
  end
// pragma uvmf custom clock_generator end

// pragma uvmf custom reset_generator begin
  bit rst;
  // Instantiate a rst driver
  // tbx clkgen
  initial begin
    rst = 0; 
    #200ns;
    rst =  1; 
  end
// pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin
  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.
  fetch_in_if  fetch_env_fetch_in_agent_bus(
     // pragma uvmf custom fetch_env_fetch_in_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom fetch_env_fetch_in_agent_bus_connections end
     );
  fetch_out_if  fetch_env_fetch_out_agent_bus(
     // pragma uvmf custom fetch_env_fetch_out_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom fetch_env_fetch_out_agent_bus_connections end
     );
  decode_in_if  decode_env_dec_in_agent_bus(
     // pragma uvmf custom decode_env_dec_in_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom decode_env_dec_in_agent_bus_connections end
     );
  decode_out_if  decode_env_dec_out_agent_bus(
     // pragma uvmf custom decode_env_dec_out_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom decode_env_dec_out_agent_bus_connections end
     );
  execute_in_if  execute_env_exe_in_agent_bus(
     // pragma uvmf custom execute_env_exe_in_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom execute_env_exe_in_agent_bus_connections end
     );
  execute_out_if  execute_env_exe_out_agent_bus(
     // pragma uvmf custom execute_env_exe_out_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom execute_env_exe_out_agent_bus_connections end
     );
  memaccess_in_if  memaccess_env_memaccess_in_agt_bus(
     // pragma uvmf custom memaccess_env_memaccess_in_agt_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom memaccess_env_memaccess_in_agt_bus_connections end
     );
  memaccess_out_if  memaccess_env_memaccess_out_agt_bus(
     // pragma uvmf custom memaccess_env_memaccess_out_agt_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom memaccess_env_memaccess_out_agt_bus_connections end
     );
  writeback_in_if  writeback_env_writeback_in_agent_bus(
     // pragma uvmf custom writeback_env_writeback_in_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom writeback_env_writeback_in_agent_bus_connections end
     );
  writeback_out_if  writeback_env_writeback_out_agent_bus(
     // pragma uvmf custom writeback_env_writeback_out_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom writeback_env_writeback_out_agent_bus_connections end
     );
  controller_in_if  controller_env_controller_in_agent_bus(
     // pragma uvmf custom controller_env_controller_in_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom controller_env_controller_in_agent_bus_connections end
     );
  controller_out_if  controller_env_controller_out_agent_bus(
     // pragma uvmf custom controller_env_controller_out_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom controller_env_controller_out_agent_bus_connections end
     );
  imem_if  imem_agent_bus(
     // pragma uvmf custom imem_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom imem_agent_bus_connections end
     );
  dmem_if  dmem_agent_bus(
     // pragma uvmf custom dmem_agent_bus_connections begin
     .clock(clk), .reset(rst)
     // pragma uvmf custom dmem_agent_bus_connections end
     );
  fetch_in_monitor_bfm  fetch_env_fetch_in_agent_mon_bfm(fetch_env_fetch_in_agent_bus);
  fetch_out_monitor_bfm  fetch_env_fetch_out_agent_mon_bfm(fetch_env_fetch_out_agent_bus);
  decode_in_monitor_bfm  decode_env_dec_in_agent_mon_bfm(decode_env_dec_in_agent_bus);
  decode_out_monitor_bfm  decode_env_dec_out_agent_mon_bfm(decode_env_dec_out_agent_bus);
  execute_in_monitor_bfm  execute_env_exe_in_agent_mon_bfm(execute_env_exe_in_agent_bus);
  execute_out_monitor_bfm  execute_env_exe_out_agent_mon_bfm(execute_env_exe_out_agent_bus);
  memaccess_in_monitor_bfm  memaccess_env_memaccess_in_agt_mon_bfm(memaccess_env_memaccess_in_agt_bus);
  memaccess_out_monitor_bfm  memaccess_env_memaccess_out_agt_mon_bfm(memaccess_env_memaccess_out_agt_bus);
  writeback_in_monitor_bfm  writeback_env_writeback_in_agent_mon_bfm(writeback_env_writeback_in_agent_bus);
  writeback_out_monitor_bfm  writeback_env_writeback_out_agent_mon_bfm(writeback_env_writeback_out_agent_bus);
  controller_in_monitor_bfm  controller_env_controller_in_agent_mon_bfm(controller_env_controller_in_agent_bus);
  controller_out_monitor_bfm  controller_env_controller_out_agent_mon_bfm(controller_env_controller_out_agent_bus);
  fetch_out_monitor_bfm  imem_agent_mon_bfm(imem_agent_bus);
  dmem_monitor_bfm  dmem_agent_mon_bfm(dmem_agent_bus);
  fetch_in_driver_bfm  fetch_env_fetch_in_agent_drv_bfm(fetch_env_fetch_in_agent_bus);
  fetch_out_driver_bfm  fetch_env_fetch_out_agent_drv_bfm(fetch_env_fetch_out_agent_bus);
  decode_in_driver_bfm  decode_env_dec_in_agent_drv_bfm(decode_env_dec_in_agent_bus);
  decode_out_driver_bfm  decode_env_dec_out_agent_drv_bfm(decode_env_dec_out_agent_bus);
  execute_in_driver_bfm  execute_env_exe_in_agent_drv_bfm(execute_env_exe_in_agent_bus);
  execute_out_driver_bfm  execute_env_exe_out_agent_drv_bfm(execute_env_exe_out_agent_bus);
  memaccess_in_driver_bfm  memaccess_env_memaccess_in_agt_drv_bfm(memaccess_env_memaccess_in_agt_bus);
  memaccess_out_driver_bfm  memaccess_env_memaccess_out_agt_drv_bfm(memaccess_env_memaccess_out_agt_bus);
  writeback_in_driver_bfm  writeback_env_writeback_in_agent_drv_bfm(writeback_env_writeback_in_agent_bus);
  writeback_out_driver_bfm  writeback_env_writeback_out_agent_drv_bfm(writeback_env_writeback_out_agent_bus);
  controller_in_driver_bfm  controller_env_controller_in_agent_drv_bfm(controller_env_controller_in_agent_bus);
  controller_out_driver_bfm  controller_env_controller_out_agent_drv_bfm(controller_env_controller_out_agent_bus);
  fetch_out_driver_bfm  imem_agent_drv_bfm(imem_agent_bus);
  dmem_driver_bfm  dmem_agent_drv_bfm(dmem_agent_bus);


// Default dut creation from YAML file
//   // pragma uvmf custom dut_instantiation begin
//   // UVMF_CHANGE_ME : Add DUT and connect to signals in _bus interfaces listed above
//   // Instantiate your DUT here
//   // These DUT's instantiated to show verilog and vhdl instantiation
//   verilog_dut         dut_verilog(   .clk(clk), .rst(rst), .in_signal(vhdl_to_verilog_signal), .out_signal(verilog_to_vhdl_signal));
//   vhdl_dut            dut_vhdl   (   .clk(clk), .rst(rst), .in_signal(verilog_to_vhdl_signal), .out_signal(vhdl_to_verilog_signal));
//   // pragma uvmf custom dut_instantiation end

// implemented DUT
// pragma uvmf custom dut_instantiation begin
LC3 dut (
  // Clock and reset signals
  .clock(clk),
  .reset(rst),
  
  // Instruction memory interface (imem_agent)
  .pc(imem_agent_bus.pc),
  .instrmem_rd(imem_agent_bus.instrmem_rd),
  
  // Instruction memory response (from controller_in, which receives from imem)
  .Instr_dout(controller_env_controller_in_agent_bus.IMem_dout),
  .complete_instr(controller_env_controller_in_agent_bus.complete_instr),
  
  // Data memory interface (dmem_agent)
  .Data_addr(dmem_agent_bus.Data_addr),
  .Data_din(dmem_agent_bus.Data_din),
  .Data_rd(dmem_agent_bus.Data_rd),
  
  // Data memory response (dmem_agent)
  .Data_dout(dmem_agent_bus.Data_dout),
  .complete_data(controller_env_controller_in_agent_bus.complete_data)
);
// pragma uvmf custom dut_instantiation end

  initial begin      // tbx vif_binding_block 
    import uvm_pkg::uvm_config_db;
    // The monitor_bfm and driver_bfm for each interface is placed into the uvm_config_db.
    // They are placed into the uvm_config_db using the string names defined in the parameters package.
    // The string names are passed to the agent configurations by test_top through the top level configuration.
    // They are retrieved by the agents configuration class for use by the agent.
    uvm_config_db #( virtual fetch_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_fetch_in_agent_BFM , fetch_env_fetch_in_agent_mon_bfm ); 
    uvm_config_db #( virtual fetch_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_fetch_out_agent_BFM , fetch_env_fetch_out_agent_mon_bfm ); 
    uvm_config_db #( virtual decode_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_dec_in_agent_BFM , decode_env_dec_in_agent_mon_bfm ); 
    uvm_config_db #( virtual decode_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_dec_out_agent_BFM , decode_env_dec_out_agent_mon_bfm ); 
    uvm_config_db #( virtual execute_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_exe_in_agent_BFM , execute_env_exe_in_agent_mon_bfm ); 
    uvm_config_db #( virtual execute_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_exe_out_agent_BFM , execute_env_exe_out_agent_mon_bfm ); 
    uvm_config_db #( virtual memaccess_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_memaccess_in_agt_BFM , memaccess_env_memaccess_in_agt_mon_bfm ); 
    uvm_config_db #( virtual memaccess_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_memaccess_out_agt_BFM , memaccess_env_memaccess_out_agt_mon_bfm ); 
    uvm_config_db #( virtual writeback_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_writeback_in_agent_BFM , writeback_env_writeback_in_agent_mon_bfm ); 
    uvm_config_db #( virtual writeback_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_writeback_out_agent_BFM , writeback_env_writeback_out_agent_mon_bfm ); 
    uvm_config_db #( virtual controller_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , controller_env_controller_in_agent_BFM , controller_env_controller_in_agent_mon_bfm ); 
    uvm_config_db #( virtual controller_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , controller_env_controller_out_agent_BFM , controller_env_controller_out_agent_mon_bfm ); 
    uvm_config_db #( virtual fetch_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_agent_BFM , imem_agent_mon_bfm ); 
    uvm_config_db #( virtual dmem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , dmem_agent_BFM , dmem_agent_mon_bfm ); 
    uvm_config_db #( virtual fetch_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_fetch_in_agent_BFM , fetch_env_fetch_in_agent_drv_bfm  );
    uvm_config_db #( virtual fetch_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_fetch_out_agent_BFM , fetch_env_fetch_out_agent_drv_bfm  );
    uvm_config_db #( virtual decode_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_dec_in_agent_BFM , decode_env_dec_in_agent_drv_bfm  );
    uvm_config_db #( virtual decode_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_dec_out_agent_BFM , decode_env_dec_out_agent_drv_bfm  );
    uvm_config_db #( virtual execute_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_exe_in_agent_BFM , execute_env_exe_in_agent_drv_bfm  );
    uvm_config_db #( virtual execute_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_exe_out_agent_BFM , execute_env_exe_out_agent_drv_bfm  );
    uvm_config_db #( virtual memaccess_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_memaccess_in_agt_BFM , memaccess_env_memaccess_in_agt_drv_bfm  );
    uvm_config_db #( virtual memaccess_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_memaccess_out_agt_BFM , memaccess_env_memaccess_out_agt_drv_bfm  );
    uvm_config_db #( virtual writeback_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_writeback_in_agent_BFM , writeback_env_writeback_in_agent_drv_bfm  );
    uvm_config_db #( virtual writeback_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_writeback_out_agent_BFM , writeback_env_writeback_out_agent_drv_bfm  );
    uvm_config_db #( virtual controller_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , controller_env_controller_in_agent_BFM , controller_env_controller_in_agent_drv_bfm  );
    uvm_config_db #( virtual controller_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , controller_env_controller_out_agent_BFM , controller_env_controller_out_agent_drv_bfm  );
    uvm_config_db #( virtual fetch_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_agent_BFM , imem_agent_drv_bfm  );
    uvm_config_db #( virtual dmem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , dmem_agent_BFM , dmem_agent_drv_bfm  );
  end

endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end

