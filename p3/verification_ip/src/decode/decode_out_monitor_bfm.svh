// Observes output signals from the decode unit, tasks called from decode_out_monitor.svh
interface decode_out_monitor_bfm (decode_out_if.monitor_port bus);
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // Task to sample a transaction using basic types
    task sample_transaction(
        output logic [15:0] IR_dout_val,
        output logic [15:0] npc_out_val,
        output logic [1:0]  W_Control_val,
        output logic        Mem_Control_val,
        output logic [5:0]  E_Control_val
    );
        @(posedge bus.clock);
        IR_dout_val = bus.IR_dout;
        npc_out_val = bus.npc_out;
        W_Control_val = bus.W_Control;
        Mem_Control_val = bus.Mem_Control;
        E_Control_val = bus.E_Control;
        
        `uvm_info("MON_BFM", $sformatf("BFM sampled: IR_dout=%h, npc_out=%h, W=%0h, M=%0h, E=%0h", IR_dout_val, npc_out_val, W_Control_val, Mem_Control_val, E_Control_val), UVM_HIGH)
    endtask

    // Task to check for valid transaction
    task wait_for_transaction();
        @(posedge bus.clock);
        // Wait for enable_decode to be high for valid transaction (as with decode_in_monitor_bfm.svh)
        while (bus.enable_decode !== 1'b1) begin
            @(posedge bus.clock);
        end
    endtask
    
endinterface
