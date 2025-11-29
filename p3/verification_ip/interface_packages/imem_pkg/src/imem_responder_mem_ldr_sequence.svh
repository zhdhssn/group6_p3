//Harry: Deterministic responder sequence that feeds LDR instructions for load testing
class imem_responder_mem_ldr_sequence extends imem_responder_sequence;

  `uvm_object_utils(imem_responder_mem_ldr_sequence)

  localparam bit [15:0] BASE_PC = 16'h3000;

  // Pre-built instruction stream that exercises multiple LDR combinations.
  bit [15:0] ldr_program[$];

  function new(string name = "imem_responder_mem_ldr_sequence");
    super.new(name);
  endfunction

  // Helper to assemble an LDR instruction: opcode[15:12]=0110.
  protected function bit [15:0] build_ldr(bit [2:0] dr, bit [2:0] baser, bit signed [5:0] offset6);
    return {4'b0110, dr, baser, offset6[5:0]};
  endfunction

  protected function void build_program();
    ldr_program.delete();
    // Load sequence touches multiple destination/base registers and offsets.
    ldr_program.push_back(build_ldr(3'd0, 3'd1, 6'sd0));  // LDR R0, R1, #0
    ldr_program.push_back(build_ldr(3'd2, 3'd1, 6'sd1));  // LDR R2, R1, #1
    ldr_program.push_back(build_ldr(3'd3, 3'd2, 6'sd2));  // LDR R3, R2, #2
    ldr_program.push_back(build_ldr(3'd4, 3'd3, -6'sd1)); // LDR R4, R3, #-1
    ldr_program.push_back(build_ldr(3'd5, 3'd4, 6'sd4));  // LDR R5, R4, #4
  endfunction

  protected task drive_instr(bit [15:0] instr, bit [15:0] pc_value);
    start_item(req);
    req.PC            = pc_value;
    req.Instr_dout    = instr;
    req.complete_instr = 1'b1;
    finish_item(req);
    `uvm_info("LDR_SEQ", $sformatf("Issued LDR 0x%04h at PC 0x%04h", instr, pc_value), UVM_MEDIUM)
  endtask

  virtual task body();
    req = imem_transaction::type_id::create("req");
    build_program();

    foreach (ldr_program[idx]) begin
      drive_instr(ldr_program[idx], BASE_PC + idx);
    end

    // Keep responding with the last instruction so the fetch stage always receives data.
    forever begin
      drive_instr(ldr_program[$high(ldr_program)], BASE_PC + ldr_program.size());
    end
  endtask

endclass

