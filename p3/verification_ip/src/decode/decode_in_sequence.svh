// Foundation for all input test sequences
class decode_in_sequence extends uvm_sequence#(decode_in_transaction); // sequence of decode_in_transaction items
    `uvm_object_utils(decode_in_sequence)
    typedef decode_in_transaction REQ;

    // Constructor
    function new(string name = "decode_in_sequence");
        super.new(name);
    endfunction

endclass