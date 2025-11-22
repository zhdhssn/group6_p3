// Generates expected outputs with the reference model from the lc3_prediction_pkg
class decode_predictor extends uvm_subscriber#(decode_in_transaction);
    `uvm_component_utils(decode_predictor) // register predictor in UVM factory

	uvm_analysis_port#(decode_out_transaction) ap; // analysis port to send transactions to scoreboard

    // Constructor
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Build phase
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ap = new("ap", this);
	endfunction
    
    // Write phase, generates expected outputs with the reference model from the lc3_prediction_pkg
	virtual function void write(decode_in_transaction t);
		// Import the prediction package locally to access decode_model

		bit [15:0] ir; // instruction output
		bit [15:0] npc_out; // next program counter output
		bit [5:0] e_control; // execution control
		bit [1:0] w_control; // write control
		bit       mem_control; // memory control
        decode_out_transaction predicted;

        // Golden reference model from the lc3_prediction_pkg
		void'(lc3_prediction_pkg::decode_model(t.dout, t.npc_in, ir, npc_out, e_control, w_control, mem_control));
		
		predicted = decode_out_transaction::type_id::create("predicted"); // create a new transaction to store the predicted values
		predicted.IR_dout    = ir; // set the instruction output
		predicted.npc_out    = npc_out; // set the next program counter output
		predicted.E_Control  = e_control; // set the execution control
		predicted.W_Control  = w_control; // set the write control
		predicted.Mem_Control = mem_control; // set the memory control

		ap.write(predicted); // send the predicted transaction to the scoreboard
    endfunction
    
    
    

endclass 