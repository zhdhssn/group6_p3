//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
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

import lc3_parameters_pkg::*;
import uvmf_base_pkg_hdl::*;

  // pragma attribute hdl_top partition_module_xrtl                                            
// pragma uvmf custom clock_generator begin
  bit clk;
  bit psr;
  wire [15:0] pc;
  wire instrmem_rd;
  wire [15:0] instr_dout;
  wire complete_instr;
  wire complete_data;
  wire [15:0] Data_dout;
  wire [15:0] Data_din;
  wire [15:0] Data_addr;
  wire Data_rd;
  
  // Instantiate a clk driver 
  // tbx clkgen
  initial begin
    clk = 0;
    #0ns;
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
    rst = 1; 
    #25ns;
    rst =  0; 
  end
// pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin
  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.

     // pragma uvmf custom fetch_env_fet_in_bus_bind begin
      // fetch_in_if fetch_env_fet_in_bus();
      bind LC3_inst fetch_in_if fetch_env_fet_in_bus (.clock(clock), .reset(reset), 
                                                      .enable_updatePC(enable_updatePC), .enable_fetch(enable_fetch), .taddr(pcout), .br_taken(br_taken)
      );   
     // pragma uvmf custom fetch_env_fet_in_bus_bind end


     // pragma uvmf custom fetch_env_fet_out_bus_bind begin
    //  fetch_out_if fetch_env_fet_out_bus();
      bind LC3_inst fetch_out_if fetch_env_fet_out_bus (.clock(clock), .reset(reset),
                                                       .npc(npc_out_fetch), .pc(pc), .instrmem_rd(instrmem_rd), .enable_fetch(enable_fetch)
      );
     // pragma uvmf custom fetch_env_fet_out_bus_bind end


     // pragma uvmf custom decode_env_dec_in_bus_bind begin
     
     // psr is not connected in TopLevelLC3 nor is used in prediction model for decode
      // decode_in_if decode_env_dec_in_bus();
      // bind LC3_inst.Dec decode_in_if decode_env_dec_in_bus (.clock(clock), .reset(reset),
      //                                                  .npc_in(npc_in), .enable_decode(enable_decode), .instr_dout(dout)
      // );

      // decode_in_if decode_env_dec_in_bus();
      bind LC3_inst decode_in_if decode_env_dec_in_bus (.clock(clock), .reset(reset),
                                                       .npc_in(npc_out_fetch), .enable_decode(enable_decode), .instr_dout(Instr_dout),.psr(psr)
      );
     // pragma uvmf custom decode_env_dec_in_bus_bind end


     // pragma uvmf custom decode_env_dec_out_bus_bind begin
      // decode_out_if decode_env_dec_out_bus();
      bind LC3_inst decode_out_if decode_env_dec_out_bus (.clock(clock), .reset(reset),
                                                       .IR(IR), .E_control(E_Control), .npc_out(npc_out_dec),
                                                       .Mem_control(Mem_Control), .W_control(W_Control), .enable_decode(enable_decode)
      );
     // pragma uvmf custom decode_env_dec_out_bus_bind end


     // pragma uvmf custom execute_env_execute_in_bus_bind begin
    //  execute_in_if execute_env_execute_in_bus();
     bind LC3_inst execute_in_if execute_env_execute_in_bus (.clock(clock), .reset(reset),
                                                             .enable_execute(enable_execute), .E_control(E_Control), .bypass_alu_1(bypass_alu_1),
                                                             .bypass_alu_2(bypass_alu_2), .bypass_mem_1(bypass_mem_1), .bypass_mem_2(bypass_mem_2),
                                                             .VSR1(VSR1), .VSR2(VSR2), .Mem_Bypass_Val(memout), .IR(IR), .npc_in(npc_out_dec), 
                                                             .Mem_Control_in(Mem_Control), .W_Control_in(W_Control)
     );
     // pragma uvmf custom execute_env_execute_in_bus_bind end


     // pragma uvmf custom execute_env_execute_out_bus_bind begin
    //  execute_out_if execute_env_execute_out_bus();
     bind LC3_inst execute_out_if execute_env_execute_out_bus (.clock(clock), .reset(reset),
                                                             .aluout(aluout), .W_Control_out(W_Control_out), .Mem_Control_out(Mem_Control_out),
                                                             .M_Data(M_Data), .dr(dr), .sr1(sr1), .sr2(sr2), .IR_Exec(IR_Exec), .NZP(NZP),
                                                             .pcout(pcout), .enable_execute(enable_execute)
     );     
     // pragma uvmf custom execute_env_execute_out_bus_bind end


     // pragma uvmf custom writeback_env_wb_in_bus_bind begin
    //  writeback_in_if writeback_env_writeback_in_bus();
     bind LC3_inst writeback_in_if writeback_env_writeback_in_bus (.clock(clock), .reset(reset),
                                                                   .aluout(aluout), .W_control(W_Control_out), .pcout(pcout),
                                                                   .memout(memout), .dr(dr), .sr1(sr1), .sr2(sr2), .enable_writeback(enable_writeback),
                                                                   .npc(npc_out_dec)
      );  
     // pragma uvmf custom writeback_env_wb_in_bus_bind end


     // pragma uvmf custom writeback_env_wb_out_bus_bind begin
      // writeback_out_if writeback_env_writeback_out_bus();
      bind LC3_inst writeback_out_if writeback_env_writeback_out_bus (.clock(clock), .reset(reset), 
                                                                      .psr(psr), .VSR1(VSR1), .VSR2(VSR2), .enable_writeback(enable_writeback)
      );  
     // pragma uvmf custom writeback_env_wb_out_bus_bind end


     // pragma uvmf custom memaccess_env_memaccess_in_bus_bind begin
      // memaccess_in_if memaccess_env_memaccess_in_bus();
      bind LC3_inst memaccess_in_if memaccess_env_memaccess_in_bus (.clock(clock), .reset(reset),
                                                                    .mem_state(mem_state), .M_Control(Mem_Control_out), .M_Data(M_Data),
                                                                    .M_addr(pcout), .DMem_dout(Data_dout)
      );  
     // pragma uvmf custom memaccess_env_memaccess_in_bus_bind end


     // pragma uvmf custom memaccess_env_agent_out_bus_bind begin
      // memaccess_out_if memaccess_env_memaccess_out_bus();
      bind LC3_inst memaccess_out_if memaccess_env_memaccess_out_bus (.clock(clock), .reset(reset),
                                                                      .DMem_addr(Data_addr), .DMem_rd(Data_rd), .DMem_din(Data_din),
                                                                      .memout(memout)
      );  
     // pragma uvmf custom memaccess_env_agent_out_bus_bind end


     // pragma uvmf custom controller_env_controller_in_bus_bind begin
      // controller_in_if controller_env_controller_in_bus();
      bind LC3_inst controller_in_if controller_env_controller_in_bus (.clock(clock), .reset(reset),
                                                                       .complete_data(complete_data), .complete_instr(complete_instr), .IR(IR),
                                                                       .NZP(NZP), .psr(psr), .IR_Exec(IR_Exec), .IMem_dout(Instr_dout)
      );
     // pragma uvmf custom controller_env_controller_in_bus_bind end


     // pragma uvmf custom controller_env_controller_out_bus_bind begin
      // controller_out_if controller_env_controller_out_bus();
      bind LC3_inst controller_out_if controller_env_controller_out_bus (.clock(clock), .reset(reset),
                                                                         .enable_updatePC(enable_updatePC), .enable_fetch(enable_fetch), .enable_decode(enable_decode),
                                                                         .enable_execute(enable_execute), .enable_writeback(enable_writeback), .br_taken(br_taken),
                                                                         .bypass_alu_1(bypass_alu_1), .bypass_alu_2(bypass_alu_2), .bypass_mem_1(bypass_mem_1), 
                                                                         .bypass_mem_2(bypass_mem_2), .mem_state(mem_state)
      );       
     // pragma uvmf custom controller_env_controller_out_bus_bind end
  
  
      imem_if  imem_agent_bus(
     // pragma uvmf custom instr_mem_agent_bus_bind begin
     .clock(clk), .reset(rst), .pc(pc), .instrmem_rd(instrmem_rd), .instr_dout(instr_dout), .complete_instr(complete_instr)
     // pragma uvmf custom instr_mem_agent_bus_bind end
      );

      
      dmem_if  dmem_agent_bus(
     // pragma uvmf custom dat_mem_agent_bus_bind begin
     .clock(clk), .reset(rst), .complete_data(complete_data), .Data_dout(Data_dout), .Data_din(Data_din), .Data_addr(Data_addr), .Data_rd(Data_rd)
     // pragma uvmf custom dat_mem_agent_bus_bind end
     );

  // pragma uvmf custom bfm_connections begin

  // Monitor BFMs
  fetch_in_monitor_bfm  fetch_env_fet_in_mon_bfm(LC3_inst.fetch_env_fet_in_bus.monitor_port);
  fetch_out_monitor_bfm  fetch_env_fet_out_mon_bfm(LC3_inst.fetch_env_fet_out_bus.monitor_port);
  decode_in_monitor_bfm  decode_env_dec_in_mon_bfm(LC3_inst.decode_env_dec_in_bus);
  decode_out_monitor_bfm  decode_env_dec_out_mon_bfm(LC3_inst.decode_env_dec_out_bus.monitor_port);
  execute_in_monitor_bfm  execute_env_execute_in_agent_mon_bfm(LC3_inst.execute_env_execute_in_bus.monitor_port);
  execute_out_monitor_bfm  execute_env_execute_out_agent_mon_bfm(LC3_inst.execute_env_execute_out_bus.monitor_port);
  writeback_in_monitor_bfm  writeback_env_wb_in_mon_bfm(LC3_inst.writeback_env_writeback_in_bus.monitor_port);
  writeback_out_monitor_bfm  writeback_env_wb_out_mon_bfm(LC3_inst.writeback_env_writeback_out_bus.monitor_port);
  memaccess_in_monitor_bfm  memaccess_env_agent_in_mon_bfm(LC3_inst.memaccess_env_memaccess_in_bus.monitor_port);
  memaccess_out_monitor_bfm  memaccess_env_agent_out_mon_bfm(LC3_inst.memaccess_env_memaccess_out_bus.monitor_port);
  controller_in_monitor_bfm  controller_env_controller_in_agent_mon_bfm(LC3_inst.controller_env_controller_in_bus.monitor_port);
  controller_out_monitor_bfm  controller_env_controller_out_agent_mon_bfm(LC3_inst.controller_env_controller_out_bus.monitor_port);
  imem_monitor_bfm  imem_agent_mon_bfm(imem_agent_bus.monitor_port);
  dmem_monitor_bfm  dmem_agent_mon_bfm(dmem_agent_bus.monitor_port);

  // Driver BFMs
  fetch_in_driver_bfm  fetch_env_fet_in_drv_bfm(LC3_inst.fetch_env_fet_in_bus);
  fetch_out_driver_bfm  fetch_env_fet_out_drv_bfm(LC3_inst.fetch_env_fet_out_bus);
  decode_in_driver_bfm  decode_env_dec_in_drv_bfm(LC3_inst.decode_env_dec_in_bus);
  decode_out_driver_bfm  decode_env_dec_out_drv_bfm(LC3_inst.decode_env_dec_out_bus);
  execute_in_driver_bfm  execute_env_execute_in_agent_drv_bfm(LC3_inst.execute_env_execute_in_bus);
  execute_out_driver_bfm  execute_env_execute_out_agent_drv_bfm(LC3_inst.execute_env_execute_out_bus);
  writeback_in_driver_bfm  writeback_env_wb_in_drv_bfm(LC3_inst.writeback_env_writeback_in_bus);
  writeback_out_driver_bfm  writeback_env_wb_out_drv_bfm(LC3_inst.writeback_env_writeback_out_bus);
  memaccess_in_driver_bfm  memaccess_env_agent_in_drv_bfm(LC3_inst.memaccess_env_memaccess_in_bus);
  memaccess_out_driver_bfm  memaccess_env_agent_out_drv_bfm(LC3_inst.memaccess_env_memaccess_out_bus);
  controller_in_driver_bfm  controller_env_controller_in_agent_drv_bfm(LC3_inst.controller_env_controller_in_bus);
  controller_out_driver_bfm  controller_env_controller_out_agent_drv_bfm(LC3_inst.controller_env_controller_out_bus);
  imem_driver_bfm  imem_agent_drv_bfm(imem_agent_bus.responder_port);  
  dmem_driver_bfm  dmem_agent_drv_bfm(dmem_agent_bus);

  // pragma uvmf custom bfm_connections end

  // pragma uvmf custom dut_instantiation begin
  // Instantiate your DUT here
  LC3 LC3_inst(.clock(clk), .reset(rst), 
               .pc(imem_agent_bus.pc), .instrmem_rd(imem_agent_bus.instrmem_rd), .Instr_dout(imem_agent_bus.instr_dout), .complete_instr(imem_agent_bus.complete_instr),
               .Data_addr(dmem_agent_bus.Data_addr), .complete_data(dmem_agent_bus.complete_data), .Data_din(dmem_agent_bus.Data_din), .Data_dout(dmem_agent_bus.Data_dout), .Data_rd(dmem_agent_bus.Data_rd));

  // pragma uvmf custom dut_instantiation end

  initial begin      // tbx vif_binding_block 
    import uvm_pkg::uvm_config_db;
    // The monitor_bfm and driver_bfm for each interface is placed into the uvm_config_db.
    // They are placed into the uvm_config_db using the string names defined in the parameters package.
    // The string names are passed to the agent configurations by test_top through the top level configuration.
    // They are retrieved by the agents configuration class for use by the agent.

  // pragma uvmf custom renamed_config_db_sets begin

    // Monitor BFMs
    uvm_config_db #( virtual fetch_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_fet_in_BFM , fetch_env_fet_in_mon_bfm ); 
    uvm_config_db #( virtual fetch_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_fet_out_BFM , fetch_env_fet_out_mon_bfm ); 
    uvm_config_db #( virtual decode_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_dec_in_BFM , decode_env_dec_in_mon_bfm ); 
    uvm_config_db #( virtual decode_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_dec_out_BFM , decode_env_dec_out_mon_bfm ); 
    uvm_config_db #( virtual execute_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_execute_in_agent_BFM , execute_env_execute_in_agent_mon_bfm ); 
    uvm_config_db #( virtual execute_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_execute_out_agent_BFM , execute_env_execute_out_agent_mon_bfm ); 
    uvm_config_db #( virtual writeback_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_wb_in_BFM , writeback_env_wb_in_mon_bfm ); 
    uvm_config_db #( virtual writeback_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_wb_out_BFM , writeback_env_wb_out_mon_bfm ); 
    uvm_config_db #( virtual memaccess_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_agent_in_BFM , memaccess_env_agent_in_mon_bfm ); 
    uvm_config_db #( virtual memaccess_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_agent_out_BFM , memaccess_env_agent_out_mon_bfm ); 
    uvm_config_db #( virtual controller_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , controller_env_controller_in_agent_BFM , controller_env_controller_in_agent_mon_bfm ); 
    uvm_config_db #( virtual controller_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , controller_env_controller_out_agent_BFM , controller_env_controller_out_agent_mon_bfm ); 
    uvm_config_db #( virtual imem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_agent_BFM , imem_agent_mon_bfm ); 
    uvm_config_db #( virtual dmem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , dmem_agent_BFM , dmem_agent_mon_bfm ); 

    // Driver BFMs
    uvm_config_db #( virtual fetch_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_fet_in_BFM , fetch_env_fet_in_drv_bfm  );
    uvm_config_db #( virtual fetch_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , fetch_env_fet_out_BFM , fetch_env_fet_out_drv_bfm  );
    uvm_config_db #( virtual decode_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_dec_in_BFM , decode_env_dec_in_drv_bfm  );
    uvm_config_db #( virtual decode_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_dec_out_BFM , decode_env_dec_out_drv_bfm  );
    uvm_config_db #( virtual execute_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_execute_in_agent_BFM , execute_env_execute_in_agent_drv_bfm  );
    uvm_config_db #( virtual execute_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_execute_out_agent_BFM , execute_env_execute_out_agent_drv_bfm  );
    uvm_config_db #( virtual writeback_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_wb_in_BFM , writeback_env_wb_in_drv_bfm  );
    uvm_config_db #( virtual writeback_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_wb_out_BFM , writeback_env_wb_out_drv_bfm  );
    uvm_config_db #( virtual memaccess_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_agent_in_BFM , memaccess_env_agent_in_drv_bfm  );
    uvm_config_db #( virtual memaccess_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_agent_out_BFM , memaccess_env_agent_out_drv_bfm  );
    uvm_config_db #( virtual controller_in_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , controller_env_controller_in_agent_BFM , controller_env_controller_in_agent_drv_bfm  );
    uvm_config_db #( virtual controller_out_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , controller_env_controller_out_agent_BFM , controller_env_controller_out_agent_drv_bfm  );
    uvm_config_db #( virtual imem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_agent_BFM , imem_agent_drv_bfm  );
    uvm_config_db #( virtual dmem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , dmem_agent_BFM , dmem_agent_drv_bfm  );
  end

  // pragma uvmf custom renamed_config_db_sets end


endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end

