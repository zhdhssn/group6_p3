class decode_in_monitor extends uvm_monitor;
    `uvm_component_utils(decode_in_monitor) // macro to register the monitor with the UVM factory

    uvm_analysis_port#(decode_in_transaction) analysis_port; // analysis port to send transactions to scoreboard
    virtual decode_in_monitor_bfm monitor_bfm; // monitor BFM
    decode_in_config cfg; // agent configuration

    decode_in_transaction trans; // transaction to store sampled values

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_port = new("analysis_port", this); // create analysis port
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase); // call superclass build_phase

        // Get configuration from config DB (agent configuration containing BFM handles)
        if (!uvm_config_db#(decode_in_config)::get(this, "", "config", cfg)) begin
            `uvm_fatal("MON", "Could not get config from config DB") // fatal error if monitor config is not found
        end
        
        // Get monitor BFM handle from agent configuration
        monitor_bfm = cfg.monitor_bfm;
        if (monitor_bfm == null) begin
            `uvm_fatal("MON", "Monitor BFM handle is null in configuration") // fatal error if monitor BFM handle isn't found
        end
        
        trans = decode_in_transaction::type_id::create("trans"); // create transaction to store sampled values
    endfunction

    // Run phase
    virtual task run_phase(uvm_phase phase);
        // decode_in_transaction trans;
        logic [15:0] dout_val, npc_val;
        
        forever begin
            // Wait for a valid transaction using BFM method (decode_in_monitor_bfm.svh)
            monitor_bfm.wait_for_transaction();
            
            // Sample the transaction using BFM method (decode_in_monitor_bfm.svh)
            monitor_bfm.sample_transaction(dout_val, npc_val);
            
            // Store sampled values as class transaction variable defined in build_phase
            // trans = decode_in_transaction::type_id::create("trans"); // already created in build_phase
            trans.dout = dout_val; 
            trans.npc_in = npc_val; 
            
            // Broadcast transaction to scoreboard (decode_in_scoreboard.svh)
            analysis_port.write(trans);
        end
    endtask


endclass