class decode_out_config extends uvm_object;
    `uvm_object_utils(decode_out_config)

    // Interface identity and agent activity configuration
    string if_name;
    uvm_active_passive_enum is_active = UVM_PASSIVE;

    virtual decode_out_monitor_bfm monitor_bfm;
    virtual decode_out_driver_bfm driver_bfm;

    function new(string name = "decode_out_config");
        super.new(name);
    endfunction

    
    // Initialize the agent configuration
    // - agent_path: hierarchical UVM path to the agent instance
    // - if_name: interface instance name under hdl_top used to fetch BFMs
    // - is_active: whether the agent is active or passive
    function void initialize(string agent_path, string if_name, uvm_active_passive_enum is_active);
        string vif_scope;
        
        this.if_name   = if_name;
        this.is_active = is_active;

        // Fetch BFM handles from hdl_top using the interface instance name
        vif_scope = {"hdl_top.", if_name};

        if (!uvm_config_db#(virtual decode_out_monitor_bfm)::get(null, vif_scope, "monitor_bfm", monitor_bfm)) begin
            `uvm_warning("CONFIG", $sformatf("Could not get monitor_bfm from config DB at scope '%s'", vif_scope))
        end

        if (is_active == UVM_ACTIVE) begin
            if (!uvm_config_db#(virtual decode_out_driver_bfm)::get(null, vif_scope, "driver_bfm", driver_bfm)) begin
                `uvm_warning("CONFIG", $sformatf("Could not get driver_bfm from config DB at scope '%s'", vif_scope))
            end
        end

        // Could drop the config onto the agent scope 
        // Agents can retrieve using: uvm_config_db#(decode_out_config)::get(this, "", "config", cfg)
        uvm_config_db#(decode_out_config)::set(null, {agent_path, ".*"}, "config", this);
    endfunction

    function string convert2string();
        return $sformatf("decode_out_config: monitor_bfm=%p, driver_bfm=%p", monitor_bfm, driver_bfm);
    endfunction
    
    // Agent configuration retrieves BFM handles using uvm_config_db
    function void get_bfm_handles(); // Referenced in decode_in_test.svh
        if (!uvm_config_db#(virtual decode_out_monitor_bfm)::get(null, "*", "monitor_bfm", monitor_bfm)) begin
            `uvm_warning("CONFIG", "Could not get monitor_bfm from config DB")
        end
        if (!uvm_config_db#(virtual decode_out_driver_bfm)::get(null, "*", "driver_bfm", driver_bfm)) begin
            `uvm_warning("CONFIG", "Could not get driver_bfm from config DB, using monitor_bfm")
            // Note: Cannot fallback to monitor_bfm as they are different types
        end
    endfunction
    
endclass