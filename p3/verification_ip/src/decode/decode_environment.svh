// Top level container for the connection of all components
class decode_environment extends uvm_env;
    `uvm_component_utils(decode_environment)

    // instantiate components 
    decode_in_agent in_agent; // input agent
    decode_out_agent out_agent; // output agent
    decode_env_configuration cfg; // environment configuration
    decode_scoreboard scoreboard; // scoreboard
    decode_predictor predictor; // predictor

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase); 

        // Retrieve environment configuration (if not already held)
        if (cfg == null) begin
            void'(uvm_config_db#(decode_env_configuration)::get(this, "", "config", cfg));
        end

        // Push agent configs down explicitly to ensure availability (decode_in_config.svh and decode_out_config.svh)
        if (cfg != null) begin
            uvm_config_db#(decode_in_config)::set(this, "in_agent*", "config", cfg.in_agent_cfg); // distribute input agent config to input agent
            uvm_config_db#(decode_out_config)::set(this, "out_agent*", "config", cfg.out_agent_cfg); // distribute output agent config to output agent
        end

        // Create agents, scoreboard, and predictor
        in_agent = decode_in_agent::type_id::create("in_agent", this);
        out_agent = decode_out_agent::type_id::create("out_agent", this);
        scoreboard = decode_scoreboard::type_id::create("scoreboard", this);
        predictor = decode_predictor::type_id::create("predictor", this);
    endfunction

    // Connects decode_in agent to predictor, predictor to scoreboard, and decode_out agent to scoreboard
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        in_agent.monitor.analysis_port.connect(predictor.analysis_export); // connect decode_in agent to predictor
		predictor.ap.connect(scoreboard.expected_export); // connect predictor to scoreboard
        out_agent.monitor.analysis_port.connect(scoreboard.actual_export); // connect decode_out agent to scoreboard
    endfunction
endclass