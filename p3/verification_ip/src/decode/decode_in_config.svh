// Manages BFM handles and input agent configuration
class decode_in_config extends uvm_object;
    `uvm_object_utils(decode_in_config)

    string if_name; // interface instance name, used in initialize function
    uvm_active_passive_enum is_active = UVM_PASSIVE; // agent activity configuration, used in initialize function

    // virtual because they are interface handles (decode_in_monitor_bfm.svh and decode_in_driver_bfm.svh)
    // actual BFM instances are instantiated in hdl_top.sv
    virtual decode_in_monitor_bfm monitor_bfm; // monitor BFM
    virtual decode_in_driver_bfm driver_bfm; // driver BFM

    // Constructor
    function new(string name = "decode_in_config");
        super.new(name);
    endfunction

    // Initialize the agent configuration
    // - agent_path: hierarchical UVM path to the agent instance
    // - if_name: interface instance name under hdl_top used to fetch BFMs
    // - is_active: whether the agent is active or passive
    function void initialize(string agent_path, string if_name, uvm_active_passive_enum is_active);
        string vif_scope; // interface scope
        
        this.if_name   = if_name; // set interface instance name
        this.is_active = is_active; // set agent activity configuration

        // Fetch BFM handles from hdl_top using the provided interface name
        vif_scope = {"hdl_top.", if_name};

        // Get monitor BFM handle from config DB
        if (!uvm_config_db#(virtual decode_in_monitor_bfm)::get(null, vif_scope, "monitor_bfm", monitor_bfm)) begin
            `uvm_warning("CONFIG", $sformatf("Could not get monitor_bfm from config DB at scope '%s'", vif_scope))
        end

        // Get driver BFM handle from config DB if agent is active (decode_in_driver.svh)
        if (is_active == UVM_ACTIVE) begin
            if (!uvm_config_db#(virtual decode_in_driver_bfm)::get(null, vif_scope, "driver_bfm", driver_bfm)) begin
                `uvm_warning("CONFIG", $sformatf("Could not get driver_bfm from config DB at scope '%s'", vif_scope))
            end
        end

        // Set config on agent scope so agents can retrieve it using: uvm_config_db#(decode_in_config)::get(this, "", "config", cfg)
        uvm_config_db#(decode_in_config)::set(null, {agent_path, ".*"}, "config", this);
    endfunction

    // Helper method
    function string convert2string();
        return $sformatf("decode_in_config: monitor_bfm=%p, driver_bfm=%p", monitor_bfm, driver_bfm);
    endfunction
    
    // Agent configuration retrieves BFM handles using uvm_config_db
    function void get_bfm_handles(); // Referenced in decode_in_test.svh
        if (!uvm_config_db#(virtual decode_in_monitor_bfm)::get(null, "*", "monitor_bfm", monitor_bfm)) begin
            `uvm_warning("CONFIG", "Could not get monitor_bfm from config DB")
        end

        if (!uvm_config_db#(virtual decode_in_driver_bfm)::get(null, "*", "driver_bfm", driver_bfm)) begin
            `uvm_warning("CONFIG", "Could not get driver_bfm from config DB, using monitor_bfm")
            // Note: Cannot fallback to monitor_bfm as they are different types
        end
    endfunction
    
endclass