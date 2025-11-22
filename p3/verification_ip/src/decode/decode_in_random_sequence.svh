// Generates random test stimuli for the decode_in_interface
class decode_in_random_sequence extends decode_in_sequence;
    `uvm_object_utils(decode_in_random_sequence)

    // Constructor
    function new(string name = "decode_in_random_sequence");
        super.new(name);
    endfunction
    

    virtual task body();
        // Only test opcodes supported by the prediction model
        bit [3:0] supported_opcodes[] = {4'h0, 4'h1, 4'h2, 4'h3, 4'h5, 4'h6, 4'h7, 4'h9, 4'hA, 4'hB, 4'hC, 4'hE};
        int num_supported = supported_opcodes.size();
        
        `uvm_info("SEQ", $sformatf("Starting 50 transactions (%0d guaranteed supported opcodes + %0d random supported opcodes)", 
                  num_supported, 50-num_supported), UVM_MEDIUM)
    
        // Generate one transaction for each supported opcode (for thorough coverage)
        foreach (supported_opcodes[i]) begin
            req = decode_in_transaction::type_id::create("req"); // create new transaction
            start_item(req); // blocking until sequencer accepts item and driver is available
            
            // Special case for NOT instruction - bits [5:0] must be 111111, mentioned in disussion board
            if (supported_opcodes[i] == 4'h9) begin
                if (!req.randomize() with {dout[15:12] == 4'h9; dout[5:0] == 6'b111111;}) begin
                    `uvm_error("SEQ", "NOT instruction randomization failed")
                end
            end 
            // for all other opcodes, randomize normally
            else begin
                if (!req.randomize() with {dout[15:12] == supported_opcodes[i];}) begin
                    `uvm_error("SEQ", "Randomization failed")
                end
            end
            
            // Log the generated transaction
            `uvm_info("SEQ", $sformatf("Generated: %s (%s)", req.convert2string(), get_instruction_name(req.dout[15:12])), UVM_MEDIUM)
            
            finish_item(req); // notify sequencer that item has been processed
        end

        // Generate remaining transactions using random (yet supported) opcodes
        repeat(50 - num_supported) begin 
            req = decode_in_transaction::type_id::create("req"); // create new transaction
            start_item(req); // blocking until sequencer accepts item and driver is available
            
            // Special handling for NOT instruction - bits [5:0] must be 111111
            if (!req.randomize() with {
                dout[15:12] inside {supported_opcodes};
                if (dout[15:12] == 4'h9) dout[5:0] == 6'b111111;
            }) begin
                `uvm_error("SEQ", "Randomization failed")
            end
            
            // Log generated transaction
            `uvm_info("SEQ", $sformatf("Generated: %s (%s)", req.convert2string(), get_instruction_name(req.dout[15:12])), UVM_MEDIUM)
            
            finish_item(req); // notify sequencer that item has been processed
        end

        // `uvm_info("SEQ", "50 transactions generated", UVM_MEDIUM)
    endtask


    // Helper function to convert opcode to instruction name for logging
    function string get_instruction_name(bit [3:0] opcode);
        case (opcode)
            4'h0: return "BR";
            4'h1: return "ADD";
            4'h2: return "LD";
            4'h3: return "ST";
            4'h4: return "JSR";
            4'h5: return "AND";
            4'h6: return "LDR";
            4'h7: return "STR";
            4'h8: return "RTI";
            4'h9: return "NOT";
            4'hA: return "LDI";
            4'hB: return "STI";
            4'hC: return "JMP";
            4'hD: return "RESERVED";
            4'hE: return "LEA";
            4'hF: return "TRAP";
            default: return "UNKNOWN";
        endcase
    endfunction

endclass
