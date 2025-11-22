interface decode_in_monitor_bfm (decode_in_if.monitor_port bus);
    // Import UVM package and macros
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
// Tasks used in decode_in_monitor.svh

    // Task to sample a transaction using basic types (dout and npc_in)
    task sample_transaction(output logic [15:0] dout_val, output logic [15:0] npc_val);
        // Wait for next clock edge to ensure signals are sampled
        @(posedge bus.clock);
        dout_val = bus.dout;
        npc_val = bus.npc_in;
        
        `uvm_info("MON_BFM", $sformatf("BFM sampled: dout=%h, npc_in=%h", dout_val, npc_val), UVM_HIGH)
    endtask

    // Task to check for valid transaction
    task wait_for_transaction();
        @(posedge bus.clock);
        // Wait for enable_decode to be high for valid transaction
        while (bus.enable_decode !== 1'b1) begin
            @(posedge bus.clock);
        end
    endtask
    
endinterface
