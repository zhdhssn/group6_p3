class decode_in_transaction extends uvm_sequence_item;
    `uvm_object_utils(decode_in_transaction)

    // rand bit enable_decode;
    rand bit [15:0] dout;
    rand bit [15:0] npc_in;
    
    // Constraint for valid LC3 opcodes (bits 15:12)
    constraint valid_opcodes {
        dout[15:12] inside {4'h0, 4'h1, 4'h2, 4'h3, 4'h4, 4'h5, 4'h6, 4'h7, 4'h8, 4'h9, 4'hA, 4'hB, 4'hC, 4'hD, 4'hE, 4'hF};
    }
    
    // Constraint for NPC values
    constraint c_npc_in {
        npc_in inside {[16'h0000:16'hFFFF]};
    }

    // Constructor
    function new(string name = "decode_in_transaction");
        super.new(name);
    endfunction

    // Helper function to convert transaction to string
    function string convert2string();
        return $sformatf("dout: %h, npc_in: %h", dout, npc_in);
    endfunction

    
endclass