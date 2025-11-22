// Passive agent that only monitors output signals from the decode unit
class decode_out_agent extends uvm_agent;
    `uvm_component_utils(decode_out_agent) // register agent in UVM factory

    decode_out_monitor monitor; // monitor instance
    decode_out_config cfg; // agent configuration

    // Constructor
    function new(string name = "decode_out_agent", uvm_component parent);
        super.new(name, parent);
    endfunction
    
    // Build phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Get configuration from config DB
        if (!uvm_config_db#(decode_out_config)::get(this, "", "config", cfg)) begin
            `uvm_fatal("AGENT", "Could not get config from config DB")
        end
        
        // Create components
        monitor = decode_out_monitor::type_id::create("monitor", this);
        
    endfunction
    
    // Connect phase
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction
    
endclass
