interface decode_in_driver_bfm (decode_in_if.driver_port bus);
    // Import UVM package and macros
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    // Task to drive a transaction using basic types
    // Enable decode controlled here instead of inside transaction because it is a control signal important for timing transactions
    task drive_transaction(logic [15:0] dout_val, logic [15:0] npc_val);
        initialize_signals(); // reset signals to zero values

        @(posedge bus.clock);
        bus.enable_decode = 1'b1;  
        bus.dout = dout_val;
        bus.npc_in = npc_val;
        // Wait for next clock edge to ensure signals are sampled
        @(posedge bus.clock);
        bus.enable_decode = 1'b0;         // Disable decode
        
        `uvm_info("BFM", $sformatf("BFM drove: dout=%h, npc_in=%h", dout_val, npc_val), UVM_HIGH)
    endtask

    // Task to get response (for future use)
    task get_response(output logic [15:0] dout_val, output logic [15:0] npc_val);
        @(posedge bus.clock);
        dout_val = bus.dout;
        npc_val = bus.npc_in;
    endtask

    // Initialization task
    task initialize_signals();
        bus.enable_decode <= 1'b0;
        bus.dout <= 16'h0000;
        bus.npc_in <= 16'h0000;
    endtask
    
endinterface