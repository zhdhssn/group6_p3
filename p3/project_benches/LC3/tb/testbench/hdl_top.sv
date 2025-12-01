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
    #100ns;
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
    #200ns;
    rst =  0; 
  end
// pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin

  //Fetch block
  wire            br_taken_fetch_input;
  wire [15:0]     taddr_fetch_input;
  wire            enable_updatePC_fetch_input;
  wire            enable_fetch_fetch_input;
  wire            instrmem_rd_fetch_output;
  wire [15:0]     pc_fetch_output;
  wire [15:0]     npc_fetch_output;

  //Decode block
   wire [15:0] Instr_dout_decode_input;
   wire [15:0] npc_in_decode_input;
   wire [2:0]  psr_decode_input;
   wire        enable_decode_decode_input;
   wire [15:0] IR_decode_output;
   wire [15:0] npc_out_decode_output;
   wire [5:0]  E_control_decode_output;
   wire [1:0]  W_Control_decode_output;
   wire        Mem_control_decode_output;

//Execute Block
   wire [5:0]  E_control_ex_input;
   wire [15:0] IR_ex_input;
   wire [15:0] npc_in_ex_input;
   wire        bypass_alu_1_ex_input, bypass_alu_2_ex_input;
   wire        bypass_mem_1_ex_input, bypass_mem_2_ex_input;
   wire [15:0] VSR1_ex_input, VSR2_ex_input;
   wire [1:0]  W_Control_in_ex_input;
   wire        Mem_Control_in_ex_input;
   wire        enable_execute_ex_input;
   wire [15:0] Mem_Bypass_Val_ex_input;

   wire [1:0] W_Control_out_ex_output;
   wire       Mem_Control_out_ex_output;
   wire [15:0] aluout_ex_output;
   wire [15:0] pcout_ex_output;
   wire [2:0]  dr_ex_output, sr1_ex_output, sr2_ex_output;
   wire [15:0] IR_Exec_ex_output;
   wire [2:0]  NZP_ex_output;
   wire [15:0] M_Data_ex_output;

// Writeback Block 
   wire [15:0] npc_wb_input;
   wire [1:0]  W_Control_in_wb_input;
   wire [15:0] aluout_wb_input;
   wire [15:0] pcout_wb_input;
   wire [15:0] memout_wb_input;
   wire        enable_writeback_wb_input;
   wire [2:0]  sr1_wb_input, sr2_wb_input, dr_wb_input;
   wire [15:0] VSR1_wb_output, VSR2_wb_output;
   wire [2:0]  psr_wb_output;

//MemAccess Block
   wire [15:0] M_Data_memacc_input;
   wire [15:0] M_Addr_memacc_input;
   wire        M_Control_memacc_input;
   wire [1:0]  mem_state_memacc_input;
   wire [15:0] DMem_out_memacc_input;
   wire [15:0] DMem_addr_memacc_output;
   wire [15:0] DMem_din_memacc_output;
   wire        DMem_rd_memacc_output;
   wire [15:0] memout_memacc_output;

//Controller Block
   wire [15:0] IR_ctrl_input;             
   wire        complete_data_ctrl_input;  
   wire        complete_instr_ctrl_input; 
   wire [2:0]  NZP_ctrl_input;            
   wire [2:0]  psr_ctrl_input;            
   wire [15:0] IR_Exec_ctrl_input;        
   wire [15:0] Instr_dout_ctrl_input;
   wire        enable_updatePC_ctrl_output;
   wire        enable_fetch_ctrl_output;    
   wire        enable_decode_ctrl_output;   
   wire        enable_execute_ctrl_output;  
   wire        enable_writeback_ctrl_output;
   wire        br_taken_ctrl_output;        
   wire        bypass_alu_1_ctrl_output;    
   wire        bypass_alu_2_ctrl_output;    
   wire        bypass_mem_1_ctrl_output;    
   wire        bypass_mem_2_ctrl_output;    
   wire [1:0]  mem_state_ctrl_output;     

   //Imem
   wire        instrmem_rd;
   wire [15:0] pc;
   wire [15:0] Instr_dout;
   wire        complete_instr;
   // wire        I_macc;

  //Dmem
   wire [15:0] Data_din;
   wire        Data_rd;
   wire [15:0] Data_addr;
   wire        complete_data;
   wire [15:0] Data_dout;
   // wire        D_macc;

  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.
  fetch_in_if  fetch_env_fetch_in_agent_bus(
     // pragma uvmf custom fetch_env_fetch_in_agent_bus_connections begin
     .clock(clk), .reset(rst),
     .enable_fetch(enable_fetch_fetch_input),
     .enable_updatePC(enable_updatePC_fetch_input),
     .br_taken(br_taken_fetch_input),
     .taddr(taddr_fetch_input)
     // pragma uvmf custom fetch_env_fetch_in_agent_bus_connections end
     );
  fetch_out_if  fetch_env_fetch_out_agent_bus(
     // pragma uvmf custom fetch_env_fetch_out_agent_bus_connections begin
     .clock(clk), .reset(rst),
     .npc(npc_fetch_output),
     .pc(pc_fetch_output),
     .instrmem_rd(instrmem_rd_fetch_output),
     .enable_updatePC(enable_updatePC_fetch_input),
     .enable_fetch(enable_fetch_fetch_input)
     // pragma uvmf custom fetch_env_fetch_out_agent_bus_connections end
     );
  decode_in_if  decode_env_dec_in_agent_bus(
     // pragma uvmf custom decode_env_dec_in_agent_bus_connections begin
     .clock(clk), .reset(rst),
     .instr_dout(Instr_dout_decode_input),
     .npc_in(npc_in_decode_input),
     .enable_decode(enable_decode_decode_input),//Harry enable decode stage
     .psr(psr_decode_input)
     // pragma uvmf custom decode_env_dec_in_agent_bus_connections end
     );
  decode_out_if  decode_env_dec_out_agent_bus(
     // pragma uvmf custom decode_env_dec_out_agent_bus_connections begin
     .clock(clk), .reset(rst),
     .mem_control(Mem_control_decode_output),
     .e_control(E_control_decode_output),
     .w_control(W_Control_decode_output),
     .ir(IR_decode_output),
   //   .npc_out(npc_out_dec),
     .npc_out(npc_out_decode_output), //Harry fixed port mismatch issue
     .enable_decode(enable_decode_decode_in)
     // pragma uvmf custom decode_env_dec_out_agent_bus_connections end
     );
  execute_in_if  execute_env_exe_in_agent_bus(
     // pragma uvmf custom execute_env_exe_in_agent_bus_connections begin
     .clock(clk), .reset(rst),
     .ir(IR_ex_input),
   //   .npc_in(npc_out_dec),
     .npc_in(npc_in_ex_input), //Harry fixed port mismatch issue
     .bypass_alu_1(bypass_alu_1_ex_input),
     .bypass_alu_2(bypass_alu_2_ex_input),
     .bypass_mem_1(bypass_mem_1_ex_input),
     .bypass_mem_2(bypass_mem_2_ex_input),
     .vsr1(VSR1_ex_input),
     .vsr2(VSR2_ex_input),
     .w_control_in(W_Control_in_ex_input),
     .e_control(E_control_ex_input), //Harry added missing e_control port connection, notice there is no "_in" suffix for the e_control
     .mem_control_in(Mem_Control_in_ex_input),
     .enable_execute(enable_execute_ex_input),
     .mem_bypass_val(Mem_Bypass_Val_ex_input)
     // pragma uvmf custom execute_env_exe_in_agent_bus_connections end
     );
  execute_out_if  execute_env_exe_out_agent_bus(
     // pragma uvmf custom execute_env_exe_out_agent_bus_connections begin
     .clock(clk), .reset(rst),
     .w_control_out(W_Control_decode_output),
     .mem_control_out(Mem_Control_out_ex_output),
     .aluout(aluout_ex_output),
     .pcout(pcout_ex_output),
     .dr(dr_ex_output),
     .sr1(sr1_ex_output),
     .sr2(sr2_ex_output),
     .ir_exec(IR_Exec_ex_output),
     .nzp(NZP_ex_output),
     .m_data(M_Data_ex_output),
     .enable_execute(enable_execute_ex_input)
     // pragma uvmf custom execute_env_exe_out_agent_bus_connections end
     );
  memaccess_in_if  memaccess_env_memaccess_in_agt_bus(
     // pragma uvmf custom memaccess_env_memaccess_in_agt_bus_connections begin
     .clock(clk), .reset(rst),
     .M_Data(M_Data_memacc_input),
     .M_Addr(M_Addr_memacc_input),
     .M_Control(M_Control_memacc_input),
     .mem_state(mem_state_memacc_input),
     .DMem_dout(DMem_out_memacc_input)
     // pragma uvmf custom memaccess_env_memaccess_in_agt_bus_connections end
     );
  memaccess_out_if  memaccess_env_memaccess_out_agt_bus(
     // pragma uvmf custom memaccess_env_memaccess_out_agt_bus_connections begin
     .clock(clk), .reset(rst),
     .DMem_addr(DMem_addr_memacc_output),
     .DMem_din(DMem_din_memacc_output),
     .DMem_rd(DMem_rd_memacc_output),
     .memout(memout_memacc_output)
   //   .mem_state(dut.MemAccess.mem_state) //Harry added missing mem_state port connection
     // pragma uvmf custom memaccess_env_memaccess_out_agt_bus_connections end
     );
  writeback_in_if  writeback_env_writeback_in_agent_bus(
     // pragma uvmf custom writeback_env_writeback_in_agent_bus_connections begin
     .clock(clk), .reset(rst),
     .enable_writeback(enable_writeback_wb_input),
     .W_Control(W_Control_in_wb_input),
     .aluout(aluout_wb_input),
     .memout(memout_wb_input),
     .pcout(pcout_wb_input),
     .sr1(sr1_wb_input),
     .sr2(sr2_wb_input),
     .dr(dr_wb_input)
     // pragma uvmf custom writeback_env_writeback_in_agent_bus_connections end
     );
  writeback_out_if  writeback_env_writeback_out_agent_bus(
     // pragma uvmf custom writeback_env_writeback_out_agent_bus_connections begin
     .clock(clk), .reset(rst),
     .psr(psr_wb_output),
     .vsr1(VSR1_wb_output),
     .vsr2(VSR2_wb_output)
     // pragma uvmf custom writeback_env_writeback_out_agent_bus_connections end
     );
  controller_in_if  controller_env_controller_in_agent_bus(
     // pragma uvmf custom controller_env_controller_in_agent_bus_connections begin
     .clock(clk), .reset(rst),
     .complete_data(complete_data_ctrl_input),
     .complete_instr(complete_instr_ctrl_input),
     .IR(IR_ctrl_input),
     .NZP(NZP_ctrl_input),
     .psr(psr_ctrl_input),
     .IR_Exec(IR_Exec_ctrl_input),
     .IMem_dout(Instr_dout_ctrl_input)
     // pragma uvmf custom controller_env_controller_in_agent_bus_connections end
     );
  controller_out_if  controller_env_controller_out_agent_bus(
     // pragma uvmf custom controller_env_controller_out_agent_bus_connections begin
     .clock(clk), .reset(rst),
     .enable_updatePC(enable_updatePC_ctrl_output),
     .enable_fetch(enable_fetch_ctrl_output),
     .enable_decode(enable_decode_ctrl_output),
     .enable_execute(enable_execute_ctrl_output),
     .enable_writeback(enable_writeback_ctrl_output),
     .br_taken(br_taken_ctrl_output),
     .bypass_alu_1(bypass_alu_1_ctrl_output),
     .bypass_alu_2(bypass_alu_2_ctrl_output),
     .bypass_mem_1(bypass_mem_1_ctrl_output),
     .bypass_mem_2(bypass_mem_2_ctrl_output),
     .mem_state(mem_state_ctrl_output)
     // pragma uvmf custom controller_env_controller_out_agent_bus_connections end
     );
  imem_if  imem_agent_bus(
     // pragma uvmf custom imem_agent_bus_connections begin
     .clock(clk), .reset(rst),
      .PC(pc), 
      .instrmem_rd(instrmem_rd),
      .Instr_dout(Instr_dout),
      .complete_instr(complete_instr)
      // .I_macc(I_macc)
     // pragma uvmf custom imem_agent_bus_connections end
     );
  dmem_if  dmem_agent_bus(
     // pragma uvmf custom dmem_agent_bus_connections begin
     .clock(clk), .reset(rst),
     .Data_addr(Data_addr),
     .Data_rd(Data_rd),
     .Data_din(Data_din),
     .Data_dout(Data_dout),
     .complete_data(complete_data)
   //   .D_macc(D_macc)
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
  imem_monitor_bfm  imem_agent_mon_bfm(imem_agent_bus);
  dmem_monitor_bfm  dmem_agent_mon_bfm(dmem_agent_bus);
  imem_driver_bfm  imem_agent_drv_bfm(imem_agent_bus);
  dmem_driver_bfm  dmem_agent_drv_bfm(dmem_agent_bus);

  // pragma uvmf custom dut_instantiation begin
LC3 dut (
  // Clock and reset signals
  .clock(clk),
  .reset(rst),
  
  // Instruction memory interface (imem_agent)
  .pc(pc),
  .instrmem_rd(instrmem_rd),
  
  // Instruction memory response (from controller_in, which receives from imem)
  //   .Instr_dout(controller_env_controller_in_agent_bus.IMem_dout),
  //   .complete_instr(controller_env_controller_in_agent_bus.complete_instr),
  //Harry change the code above to the following:
											  
  .Instr_dout(Instr_dout),              
  .complete_instr(complete_instr),  
  
  // Data memory interface (dmem_agent)
  .Data_addr(Data_addr),
  .Data_din(Data_din),
  .Data_rd(Data_rd),
  
  // Data memory response (dmem_agent)
  .Data_dout(Data_dout),

  //.complete_data(controller_env_controller_in_agent_bus.complete_data)
  //Harry change the code above to the following:
  .complete_data(complete_data)
);


//Fetch:
assign br_taken_fetch_input = dut.Fetch.br_taken;
assign enable_updatePC_fetch_input = dut.Fetch.enable_updatePC;
assign enable_fetch_fetch_input = dut.Fetch.enable_fetch;
assign taddr_fetch_input = dut.Fetch.taddr;
assign instrmem_rd_fetch_output = dut.Fetch.instrmem_rd;
assign pc_fetch_output = dut.Fetch.pc;
assign npc_fetch_output = dut.Fetch.npc_out;

//Decode:
assign Instr_dout_decode_input = dut.Dec.dout;
assign npc_in_decode_input = dut.Dec.npc_in;
assign psr_decode_input = dut.WB.psr;
assign enable_decode_decode_input = dut.Dec.enable_decode;
assign IR_decode_output = dut.Dec.IR;
assign npc_out_decode_output = dut.Dec.npc_out;
assign E_control_decode_output = dut.Dec.E_Control;
assign W_Control_decode_output = dut.Dec.W_Control;
assign Mem_control_decode_output = dut.Dec.Mem_Control;


//Execute
 assign E_control_ex_input = dut.Ex.E_Control;
 assign IR_ex_input = dut.Ex.IR;
 assign npc_in_ex_input = dut.Ex.npc;
 assign bypass_alu_1_ex_input = dut.Ex.bypass_alu_1;
 assign bypass_alu_2_ex_input = dut.Ex.bypass_alu_2;
 assign bypass_mem_1_ex_input = dut.Ex.bypass_mem_1;
 assign bypass_mem_2_ex_input = dut.Ex.bypass_mem_2;
 assign VSR1_ex_input = dut.Ex.VSR1;
 assign VSR2_ex_input = dut.Ex.VSR2;
 assign W_Control_in_ex_input = dut.Ex.W_Control_in;
 assign Mem_Control_in_ex_input = dut.Ex.Mem_Control_in;
 assign enable_execute_ex_input = dut.Ex.enable_execute;
 assign Mem_Bypass_Val_ex_input = dut.Ex.Mem_Bypass_Val;
 assign W_Control_out_ex_output = dut.Ex.W_Control_out;
 assign Mem_Control_out_ex_output = dut.Ex.Mem_Control_out;
 assign aluout_ex_output = dut.Ex.aluout;
 assign pcout_ex_output = dut.Ex.pcout;
 assign dr_ex_output = dut.Ex.dr;
 assign sr1_ex_output = dut.Ex.sr1; 
 assign sr2_ex_output = dut.Ex.sr2;
 assign IR_Exec_ex_output = dut.Ex.IR_Exec;
 assign NZP_ex_output = dut.Ex.NZP;
 assign M_Data_ex_output = dut.Ex.M_Data;

 //Writeback 

assign W_Control_in_wb_input = dut.WB.W_Control;
assign aluout_wb_input = dut.WB.aluout;
assign pcout_wb_input = dut.WB.pcout;
assign memout_wb_input = dut.WB.memout;
assign enable_writeback_wb_input = dut.WB.enable_writeback;
assign sr1_wb_input = dut.WB.sr1;
assign sr2_wb_input = dut.WB.sr2;
assign dr_wb_input = dut.WB.dr;
assign VSR1_wb_output = dut.WB.d1;
assign VSR2_wb_output = dut.WB.d2;
assign psr_wb_output = dut.WB.psr;

//MemAccess
 assign M_Data_memacc_input = dut.MemAccess.M_Data;
 assign M_Addr_memacc_input = dut.MemAccess.M_Addr ;
 assign M_Control_memacc_input = dut.MemAccess.M_Control ;
 assign mem_state_memacc_input = dut.MemAccess.mem_state;
 assign DMem_out_memacc_input = dut.MemAccess.Data_dout;
 assign DMem_addr_memacc_output = dut.MemAccess.Data_addr;
 assign DMem_din_memacc_output = dut.MemAccess.Data_din;
 assign DMem_rd_memacc_output = dut.MemAccess.Data_rd;
 assign memout_memacc_output = dut.MemAccess.memout;

 //Controller 
 assign IR_ctrl_input = dut.Ctrl.IR;             
 assign complete_data_ctrl_input = dut.Ctrl.complete_data;  
 assign complete_instr_ctrl_input = dut.Ctrl.complete_instr; 
 assign NZP_ctrl_input = dut.Ctrl.NZP;            
 assign psr_ctrl_input = dut.Ctrl.psr;            
 assign IR_Exec_ctrl_input =  dut.Ctrl.IR_Exec;        
 assign Instr_dout_ctrl_input = dut.Ctrl.Instr_dout;
 assign enable_updatePC_ctrl_output = dut.Ctrl.enable_updatePC;
 assign enable_fetch_ctrl_output = dut.Ctrl.enable_fetch;    
 assign enable_decode_ctrl_output = dut.Ctrl.enable_decode;   
 assign enable_execute_ctrl_output = dut.Ctrl.enable_execute;  
 assign enable_writeback_ctrl_output = dut.Ctrl.enable_writeback;
 assign br_taken_ctrl_output = dut.Ctrl.br_taken;        
 assign bypass_alu_1_ctrl_output = dut.Ctrl.bypass_alu_1;     
 assign bypass_alu_2_ctrl_output = dut.Ctrl.bypass_alu_2;    
 assign bypass_mem_1_ctrl_output = dut.Ctrl.bypass_mem_1;    
 assign bypass_mem_2_ctrl_output = dut.Ctrl.bypass_mem_2;    
 assign mem_state_ctrl_output = dut.Ctrl.mem_state;     

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
    uvm_config_db #( virtual imem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_agent_BFM , imem_agent_mon_bfm ); 
    uvm_config_db #( virtual dmem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , dmem_agent_BFM , dmem_agent_mon_bfm ); 
    uvm_config_db #( virtual imem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_agent_BFM , imem_agent_drv_bfm  );
    uvm_config_db #( virtual dmem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , dmem_agent_BFM , dmem_agent_drv_bfm  );
  end

endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end

