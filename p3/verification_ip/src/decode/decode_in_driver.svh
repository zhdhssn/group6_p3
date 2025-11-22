class decode_in_driver extends uvm_driver#(decode_in_transaction);
    `uvm_component_utils(decode_in_driver)

    // instantiate driver BFM
    virtual decode_in_driver_bfm driver_bfm;
    decode_in_config cfg;

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        // Get configuration from config DB (agent configuration containing BFM handles)
        if (!uvm_config_db#(decode_in_config)::get(this, "", "config", cfg)) begin
            `uvm_fatal("DRV", "Could not get config from config DB") // fatal error if driver config is not found
        end

        // Get driver BFM handle from agent configuration
        driver_bfm = cfg.driver_bfm;
        if (driver_bfm == null) begin
            `uvm_fatal("DRV", "Driver BFM handle is null in configuration") // fatal error if driver BFM handle is null
        end
    endfunction

    virtual task run_phase(uvm_phase phase);     
        // Initialize signals using BFM method
        driver_bfm.initialize_signals();
        
        forever begin
            // Blocks until next item until sequencer has a new item (decode_in_sequencer.svh)
            seq_item_port.get_next_item(req);
            `uvm_info("DRV", $sformatf("Driving transaction: %s", req.convert2string()), UVM_HIGH) // print transaction
            
            // Drive the transaction using BFM method (decode_in_driver_bfm.svh)
            drive_transaction(req);

            // Signals to sequencer that item is done (decode_in_sequencer.svh)
            seq_item_port.item_done();
        end
    endtask

    // Task to drive the transaction using BFM method
    virtual task drive_transaction(decode_in_transaction req);
        // Use BFM method to drive the transaction
        driver_bfm.drive_transaction(req.dout, req.npc_in);
    endtask

endclass
