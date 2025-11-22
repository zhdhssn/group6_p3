// Compares expected and actual outputs from the decode unit
`uvm_analysis_imp_decl(_expected) // declare analysis import for expected transactions
`uvm_analysis_imp_decl(_actual) // declare analysis import for actual transactions

class decode_scoreboard extends uvm_component;
    `uvm_component_utils(decode_scoreboard) // register scoreboard in UVM factory

	// Queue for expected transactions
	decode_out_transaction expected_q[$]; // queue to store expected transactions

	// Analysis imports for expected and actual streams
	uvm_analysis_imp_expected#(decode_out_transaction, decode_scoreboard) expected_export;
	uvm_analysis_imp_actual#(decode_out_transaction, decode_scoreboard) actual_export;

	// Counters for logging 
	int num_expected;
	int num_compared;
	int num_mismatches;
	
	// Event to signal when all expected transactions have been compared
	event all_transactions_compared;

    // Constructor
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

    // Build phase, creates analysis imports and initializes counters
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		expected_export = new("expected_export", this);
		actual_export = new("actual_export", this);
		num_expected = 0;
		num_compared = 0;
		num_mismatches = 0;
	endfunction

	// Write for expected stream: enqueue and count
	function void write_expected(decode_out_transaction t);
		if (t == null) begin
			`uvm_error(get_type_name(), "Null expected transaction received")
			return;
		end
		expected_q.push_back(t);
		num_expected++;
		`uvm_info(get_type_name(), $sformatf("Expected enqueued. Depth=%0d", expected_q.size()), UVM_HIGH)
	endfunction

	// Write for actual stream: dequeue expected, compare, and report
	function void write_actual(decode_out_transaction actual);
		decode_out_transaction expected;
		if (actual == null) begin
			`uvm_error(get_type_name(), "Null actual transaction received")
			return;
		end
		if (expected_q.size() == 0) begin
			`uvm_error(get_type_name(), "No expected transaction available for comparison")
			return;
		end
		expected = expected_q.pop_front();
		num_compared++;
		if (actual.compare(expected)) begin
			`uvm_info(get_type_name(), $sformatf("Transaction match\nExpected: %s\nActual: %s\n", expected.convert2string(), actual.convert2string()), UVM_MEDIUM)

		end else begin
			`uvm_error(get_type_name(), $sformatf("Transaction mismatch\nExpected: %s\nActual: %s\n", expected.convert2string(), actual.convert2string()) )
			num_mismatches++;
		end
		
		// Signal completion when all expected transactions have been compared, event for testbench to wait for
		if (num_compared == num_expected) begin
			->all_transactions_compared;
		end
	endfunction

    // Report phase, reports the statistics of the comparisons
	function void report_phase(uvm_phase phase);
		super.report_phase(phase);

		`uvm_info(get_type_name(), $sformatf("Expected received=%0d, Compared=%0d, Mismatches=%0d, QueueDepth=%0d", num_expected, num_compared, num_mismatches, expected_q.size()), UVM_LOW)
		
        if (num_mismatches == 0) begin
			`uvm_info(get_type_name(), "All comparisons passed", UVM_LOW)
		end else begin
			`uvm_error(get_type_name(), $sformatf("Found %0d mismatches", num_mismatches))
		end
	endfunction

endclass