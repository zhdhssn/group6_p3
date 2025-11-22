// Observes output signals from decode unit, converts basic types to transaction class
class decode_out_monitor extends uvm_monitor;
    `uvm_component_utils(decode_out_monitor)

    uvm_analysis_port#(decode_out_transaction) analysis_port; // analysis port to send transactions to scoreboard
    virtual decode_out_monitor_bfm monitor_bfm;  // monitor BFM instance
    decode_out_config cfg; // agent configuration

    decode_out_transaction trans; // transaction to store sampled values

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(decode_out_config)::get(this, "", "config", cfg)) begin
            `uvm_fatal("MON", "Could not get config from config DB")
        end
        
        // Get monitor BFM handle from agent configuration
        monitor_bfm = cfg.monitor_bfm;
        if (monitor_bfm == null) begin
            `uvm_fatal("MON", "Monitor BFM handle is null in configuration")
        end
        
        trans = decode_out_transaction::type_id::create("trans");
    endfunction

    // Run phase, monitors DUT outputs and broadcasts transactions to scoreboard
    virtual task run_phase(uvm_phase phase);
        // decode_out_transaction trans;
        logic [15:0] IR_dout_val, npc_out_val;
        logic [1:0]  W_Control_val;
        logic        Mem_Control_val;
        logic [5:0]  E_Control_val;
        
        forever begin
            // Wait for a valid transaction using BFM method
            monitor_bfm.wait_for_transaction();
            
            // Sample the transaction using BFM method
            monitor_bfm.sample_transaction(IR_dout_val, npc_out_val, W_Control_val, Mem_Control_val, E_Control_val);
            
            // trans = decode_out_transaction::type_id::create("trans"); // redundant as already created in build_phase
            trans.IR_dout = IR_dout_val;
            trans.npc_out = npc_out_val;
            trans.W_Control = W_Control_val;
            trans.Mem_Control = Mem_Control_val;
            trans.E_Control = E_Control_val;
            
            analysis_port.write(trans); // send transaction to scoreboard
        end
    endtask


endclass