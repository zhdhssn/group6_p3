// Decoded instruction with all output signals
class decode_out_transaction extends uvm_sequence_item;
    `uvm_object_utils(decode_out_transaction)

    // Input signals
    rand bit [15:0] IR_dout;
    rand bit [15:0] npc_out;
    rand bit [1:0] W_Control;
    rand bit Mem_Control;
    rand bit [5:0] E_Control;
    
    // Constraint for valid LC3 opcodes (bits 15:12) and NPC values
    constraint valid_opcodes {
        IR_dout[15:12] inside {4'h0, 4'h1, 4'h2, 4'h3, 4'h4, 4'h5, 4'h6, 4'h7, 4'h8, 4'h9, 4'hA, 4'hB, 4'hC, 4'hD, 4'hE, 4'hF};
    }
    constraint c_npc_out {
        npc_out inside {[16'h0000:16'hFFFF]};
    }

    // Constructor
    function new(string name = "decode_out_transaction");
        super.new(name);
    endfunction
    
    function string convert2string();
        return $sformatf("IR_dout: %h (%s), npc_out: %h, W_Control: %h, Mem_Control: %h, E_Control: %h", 
                        IR_dout, get_opcode_name(), npc_out, W_Control, Mem_Control, E_Control);
    endfunction
    
    // Compare this transaction with another transaction
    function bit compare(decode_out_transaction rhs);
        if (rhs == null) begin
            `uvm_error("COMPARE", "Cannot compare with null object")
            return 0;
        end
        
        // Compare all fields
        compare = (this.IR_dout == rhs.IR_dout) &&
                  (this.npc_out == rhs.npc_out) &&
                  (this.W_Control == rhs.W_Control) &&
                  (this.Mem_Control == rhs.Mem_Control) &&
                  (this.E_Control == rhs.E_Control);
                  
        // If mismatch, print detailed comparison with opcode names
        if (!compare) begin
            `uvm_info("COMPARE", $sformatf("MISMATCH for %s:\n  Expected: %s\n  Actual:   %s", 
                      this.get_opcode_name(), rhs.convert2string(), this.convert2string()), UVM_MEDIUM)
        end
    endfunction

    // Helper function to get opcode name for logging
    function string get_opcode_name();
        opcodes_t opcode;
        opcode = opcodes_t'(IR_dout[15:12]);
        return opcode.name();
    endfunction
    
    // Helper function to get opcode enum value for comparison
    function opcodes_t get_opcode();
        return opcodes_t'(IR_dout[15:12]);
    endfunction
    
endclass