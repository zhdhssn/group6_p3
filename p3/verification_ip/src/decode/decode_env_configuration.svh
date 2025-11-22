class decode_env_configuration extends uvm_object;
    `uvm_object_utils(decode_env_configuration) // register class in UVM factory

    decode_in_config in_agent_cfg; // input agent configuration
    decode_out_config out_agent_cfg; // output agent configuration

    // Initialize environment configuration (based off lectures)
    // - parent_path: UVM path to environment instance (e.g., "uvm_test_top.env.")
    // - if_names: interface instance names under hdl_top for input and output agents
    // - activity_settings: activity for agent
    function void initialize(string parent_path, string if_names[], uvm_active_passive_enum activity_settings[]);
        string in_agent_path; // input agent path
        string out_agent_path; // output agent path

        string in_if_name = if_names[0]; // get input interface name from queue
        string out_if_name = if_names[1]; // get output interface name from queue

        uvm_active_passive_enum in_is_active = activity_settings[0]; // get input activity setting from queue
        uvm_active_passive_enum out_is_active = activity_settings[1]; // get output activity setting from queue

        // Construct input and output agent configurations
        if (in_agent_cfg == null) begin
            in_agent_cfg = decode_in_config::type_id::create("in_agent_cfg");
        end
        if (out_agent_cfg == null) begin
            out_agent_cfg = decode_out_config::type_id::create("out_agent_cfg");
        end

        in_agent_path = {parent_path, "in_agent"}; // build hierarchical agent path to place config for input agent to consume
        out_agent_path = {parent_path, "out_agent"}; // build hierarchical agent path to place config for output agent to consume

        // Initialize the input and output agent configurations (decode_in_config.svh and decode_out_config.svh)
        in_agent_cfg.initialize(in_agent_path, in_if_name, in_is_active);
        out_agent_cfg.initialize(out_agent_path, out_if_name, out_is_active);

        // Publish env configuration and agent configs for retrieval (decode_in_config.svh and decode_out_config.svh)
        uvm_config_db#(decode_env_configuration)::set(null, parent_path, "config", this);
        uvm_config_db#(decode_in_config)::set(null, {in_agent_path, "*"}, "config", in_agent_cfg);
        uvm_config_db#(decode_out_config)::set(null, {out_agent_path, "*"}, "config", out_agent_cfg);
    endfunction

    // Constructor
    function new(string name = "decode_env_configuration");
        super.new(name);
    endfunction

endclass