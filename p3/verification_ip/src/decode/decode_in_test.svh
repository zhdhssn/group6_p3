// Orchestrates the test execution
class test_top extends uvm_test;
    `uvm_component_utils(test_top) // register test in UVM factory

    decode_environment env; // environment
    decode_env_configuration cfg; // environment configuration

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase, called automatically from UVM testbench
    virtual function void build_phase(uvm_phase phase);
        // Declare arrays for interface names and activity settings (since I used queues in the environment configuration)
        string if_names[$];
        uvm_active_passive_enum activities[$];
        
        // Call super.build_phase to ensure proper initialization
        super.build_phase(phase);
        
        // Create environment configuration
        cfg = decode_env_configuration::type_id::create("cfg");
        
        // Set up interface instances and activities into queues
        if_names.push_back("decode_in_if0");
        if_names.push_back("decode_out_if0");
        activities.push_back(UVM_ACTIVE);
        activities.push_back(UVM_PASSIVE);
        
        // Initialize environment configuration (decode_env_configuration.svh)
        cfg.initialize("uvm_test_top.env", if_names, activities);

        // Create environment (decode_environment.svh)
        env = decode_environment::type_id::create("env", this);
    endfunction

    // connect phase
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
        decode_in_random_sequence seq; // random sequence object to generate test stimuli
        
        phase.raise_objection(this); // Prevent test from completing prematurely
        
        `uvm_info("TEST", "Starting LC3 Decode Input Interface Test", UVM_MEDIUM)
        
        // Allow pipeline to initialize before starting transactions, first two transactions were not matching without this
        #50ns; 
        
        // random sequence
        seq = decode_in_random_sequence::type_id::create("seq");
        seq.start(env.in_agent.sequencer);
        
        @(env.scoreboard.all_transactions_compared); // wait for all transactions to be compared by the scoreboard   
        `uvm_info("TEST", "Test completed successfully", UVM_MEDIUM) // Log test completion
        
        phase.drop_objection(this); // drop flag to allow test to complete
    endtask

endclass

