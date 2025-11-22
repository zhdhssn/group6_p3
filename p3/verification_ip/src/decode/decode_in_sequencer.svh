class decode_in_sequencer extends uvm_sequencer#(decode_in_transaction);
    `uvm_component_utils(decode_in_sequencer)

    // Don't need custom arbitration/filtering, so no custom methods
    // Expects transactions (decode_in_transaction.svh) from driver (decode_in_driver.svh)

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

endclass
