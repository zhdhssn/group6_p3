class decode_in_agent extends uvm_agent;
    `uvm_component_utils(decode_in_agent)

    // instantiate components
    decode_in_monitor monitor; // monitor
    decode_in_driver driver; // driver
    decode_in_sequencer sequencer; // sequencer
    decode_in_config cfg; // agent configuration
	// coverage removed for simplicity

    // Constructor
    function new(string name = "decode_in_agent", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    // Build phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Get configuration from config DB (agent configuration containing BFM handles)
        if (!uvm_config_db#(decode_in_config)::get(this, "", "config", cfg)) begin
            `uvm_fatal("AGENT", "Could not get config from config DB")
        end
        
        // Create passive components (decode_in_monitor.svh)
        monitor = decode_in_monitor::type_id::create("monitor", this); // create monitor
        
        // Create active components if agent is active (decode_in_driver.svh and decode_in_sequencer.svh)
        if (get_is_active() == UVM_ACTIVE) begin
            driver = decode_in_driver::type_id::create("driver", this); // create driver
            sequencer = decode_in_sequencer::type_id::create("sequencer", this); // create sequencer
        end
    endfunction
    
    // Connect phase
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        
        // Connect driver to sequencer if agent is active (decode_in_driver.svh and decode_in_sequencer.svh)
        if (get_is_active() == UVM_ACTIVE) begin
            // Link for transaction flow
            driver.seq_item_port.connect(sequencer.seq_item_export);
        end
    endfunction
    
endclass
