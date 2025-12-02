//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class records imem transaction information using
//       a covergroup named imem_transaction_cg.  An instance of this
//       coverage component is instantiated in the uvmf_parameterized_agent
//       if the has_coverage flag is set.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_transaction_coverage  extends uvm_subscriber #(.T(imem_transaction ));

  `uvm_component_utils( imem_transaction_coverage )

  T coverage_trans;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  T t_cov, prev_t_cov;
  bit first = 1'b1;
  bit alu, ld, str, flow_switch;

  // ****************************************************************************
  covergroup imem_transaction_cg;
    // pragma uvmf custom covergroup begin
    // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
    option.auto_bin_max = 1024;
    option.per_instance = 1;

    cp_opcode: coverpoint t_cov.instruction[15:12] {
      bins add_type = {ADD};
      bins and_type = {AND};
      bins not_type = {NOT};
      bins ld_type = {LD};
      bins ldr_type = {LDR};
      bins ldi_type = {LDI};
      bins lea_type = {LEA};
      bins st_type = {ST};
      bins str_type = {STR};
      bins sti_type = {STI};
      bins br_type = {BR};
      bins jmp_type = {JMP};
    }

    cp_prevopcode: coverpoint {first, prev_t_cov.instruction[15:12]} {
      bins add_type = {0, ADD};
      bins and_type = {0, AND};
      bins not_type = {0, NOT};
      bins ld_type = {0, LD};
      bins ldr_type = {0, LDR};
      bins ldi_type = {0, LDI};
      bins lea_type = {0, LEA};
      bins st_type = {0, ST};
      bins str_type = {0, STR};
      bins sti_type = {0, STI};
      bins br_type = {0, BR};
      bins jmp_type = {0, JMP};
    }

    cross_opcode_prev_opcode: cross cp_opcode, cp_prevopcode;

    cp_alu_ops: coverpoint t_cov.instruction[15:12] {
      bins alu_add_type = {ADD};
      bins alu_and_type = {AND};
      bins alu_not_type = {NOT};
    }

    cp_ld_ops: coverpoint t_cov.instruction[15:12] {
      bins mem_ld_type = {LD};
      bins mem_ldr_type = {LDR};
      bins mem_ldi_type = {LDI};
      bins mem_lea_type = {LEA};
    }

    cp_str_ops: coverpoint t_cov.instruction[15:12] {
      bins mem_st_type = {ST};
      bins mem_str_type = {STR};
      bins mem_sti_type = {STI};
    }

    cp_flow_switch_ops: coverpoint t_cov.instruction[15:12] {
      bins flow_switch_br_type = {BR};
      bins flow_switch_jmp_type = {JMP};
    }

    cp_dest: coverpoint (t_cov.instruction[11:9]) {
      bins dest_addr[] = {[3'h0:3'h7]};
    }

    cross_alu_dest: cross cp_alu_ops, cp_dest;
    cross_ld_dest: cross cp_ld_ops, cp_dest;

    cp_alu_sr1: coverpoint (t_cov.instruction[8:6]) iff(alu == 1'b1) {
      bins alu_sr1[] = {[3'h0:3'h7]};
    }

    cp_str_sr: coverpoint(t_cov.instruction[11:9]) iff(str == 1'b1) {
      bins str_sr[] = {[3'h0:3'h7]};
    }

    cp_br_nzp: coverpoint (t_cov.instruction[11:9]) iff(t_cov.instruction[15:12] == BR) {
      bins br_nzp[] = {[3'h1:3'h7]};
    }

    cp_add: coverpoint (t_cov.instruction[15:12]) {
      bins add_operation = {ADD};
    }

    cp_and: coverpoint (t_cov.instruction[15:12]) {
      bins and_operation = {AND};
    }

    cp_imm_bit: coverpoint (t_cov.instruction[5]) {
      bins imm_zero_one[] = {[1'b0:1'b1]};
    }

    cross_add_imm_bit: cross cp_add, cp_imm_bit;
    cross_and_imm_bit: cross cp_and, cp_imm_bit;

    cp_add_imm_val: coverpoint (t_cov.instruction[4:0]) 
      iff(t_cov.instruction[15:12] == ADD && t_cov.instruction[5] == 1'b1) {
      bins add_imm_zero = {5'b0};
      bins add_imm_one = {5'b1};
      bins add_imm_two = {5'b00010};
      bins add_imm_three = {5'b00011};
      bins add_imm_four = {5'b00100};
      bins add_imm_five = {5'b00101};
      bins add_imm_six = {5'b00110};
      bins add_imm_seven = {5'b00111};
      bins add_imm_eight = {5'b01000};
      bins add_imm_nine = {5'b01001};
      bins add_imm_ten = {5'b01010};
      bins add_imm_eleven = {5'b01011};
      bins add_imm_twelve = {5'b01100};
      bins add_imm_thirteen = {5'b01101};
      bins add_imm_fourteen = {5'b01110};
      bins add_imm_fifteen = {5'b01111};
      bins add_imm_sixteen = {5'b10000};
      bins add_imm_seventeen = {5'b10001};
      bins add_imm_eighteen = {5'b10010};
      bins add_imm_nineteen = {5'b10011};
      bins add_imm_twenty = {5'b10100};
      bins add_imm_twenty_one = {5'b10101};
      bins add_imm_twenty_two = {5'b10110};
      bins add_imm_twenty_three = {5'b10111};
      bins add_imm_twenty_four = {5'b11000};
      bins add_imm_twenty_five = {5'b11001};
      bins add_imm_twenty_six = {5'b11010};
      bins add_imm_twenty_seven = {5'b11011};
      bins add_imm_twenty_eight = {5'b11100};
      bins add_imm_twenty_nine = {5'b11101};
      bins add_imm_thirty = {5'b11110};
      bins add_imm_thirty_one = {5'b11111};
    }

    cp_and_imm_val: coverpoint (t_cov.instruction[4:0]) 
      iff(t_cov.instruction[15:12] == AND && t_cov.instruction[5] == 1'b1) {
      bins and_imm_zero = {5'b0};
      bins and_imm_one = {5'b1};
      bins and_imm_two = {5'b00010};
      bins and_imm_three = {5'b00011};
      bins and_imm_four = {5'b00100};
      bins and_imm_five = {5'b00101};
      bins and_imm_six = {5'b00110};
      bins and_imm_seven = {5'b00111};
      bins and_imm_eight = {5'b01000};
      bins and_imm_nine = {5'b01001};
      bins and_imm_ten = {5'b01010};
      bins and_imm_eleven = {5'b01011};
      bins and_imm_twelve = {5'b01100};
      bins and_imm_thirteen = {5'b01101};
      bins and_imm_fourteen = {5'b01110};
      bins and_imm_fifteen = {5'b01111};
      bins and_imm_sixteen = {5'b10000};
      bins and_imm_seventeen = {5'b10001};
      bins and_imm_eighteen = {5'b10010};
      bins and_imm_nineteen = {5'b10011};
      bins and_imm_twenty = {5'b10100};
      bins and_imm_twenty_one = {5'b10101};
      bins and_imm_twenty_two = {5'b10110};
      bins and_imm_twenty_three = {5'b10111};
      bins and_imm_twenty_four = {5'b11000};
      bins and_imm_twenty_five = {5'b11001};
      bins and_imm_twenty_six = {5'b11010};
      bins and_imm_twenty_seven = {5'b11011};
      bins and_imm_twenty_eight = {5'b11100};
      bins and_imm_twenty_nine = {5'b11101};
      bins and_imm_thirty = {5'b11110};
      bins and_imm_thirty_one = {5'b11111};
    }

    cp_add_sr2_val: coverpoint (t_cov.instruction[2:0]) 
      iff(t_cov.instruction[15:12] == ADD && t_cov.instruction[5] == 1'b0) {
      bins add_sr2_val[] = {[3'h0:3'h7]};
    }

    cp_and_sr2_val: coverpoint (t_cov.instruction[2:0]) 
      iff(t_cov.instruction[15:12] == AND && t_cov.instruction[5] == 1'b0) {
      bins and_sr2_val[] = {[3'h0:3'h7]};
    }

    cp_pcoffset9: coverpoint (t_cov.instruction[8:0]) 
      iff(t_cov.instruction[15:12] == LD || 
          t_cov.instruction[15:12] == LDI || 
          t_cov.instruction[15:12] == LEA || 
          t_cov.instruction[15:12] == ST || 
          t_cov.instruction[15:12] == STI || 
          t_cov.instruction[15:12] == BR) {
      bins offset9_zero = {9'b0};
      bins offset9_one = {9'b1};
      bins offset9_two = {9'b000000010};
      bins offset9_three = {9'b000000011};
      bins offset9_four = {9'b000000100};
      bins offset9_five = {9'b000000101};
      bins offset9_six = {9'b000000110};
      bins offset9_seven = {9'b000000111};
      bins offset9_eight = {9'b000001000};
      bins offset9_nine = {9'b000001001};
      bins offset9_ten = {9'b000001010};
      bins offset9_eleven = {9'b000001011};
      bins offset9_twelve = {9'b000001100};
      bins offset9_thirteen = {9'b000001101};
      bins offset9_fourteen = {9'b000001110};
      bins offset9_fifteen = {9'b000001111};
      bins offset9_small = {[9'b000010000:9'b000111111]};
      bins offset9_medium = {[9'b001000000:9'b011111111]};
      bins offset9_large = {[9'b100000000:9'b111111111]};
    }

    cp_pcoffset6: coverpoint (t_cov.instruction[5:0]) 
      iff(t_cov.instruction[15:12] == LDR || t_cov.instruction[15:12] == STR) {
      bins offset6_zero = {6'b0};
      bins offset6_one = {6'b1};
      bins offset6_two = {6'b000010};
      bins offset6_three = {6'b000011};
      bins offset6_four = {6'b000100};
      bins offset6_five = {6'b000101};
      bins offset6_six = {6'b000110};
      bins offset6_seven = {6'b000111};
      bins offset6_eight = {6'b001000};
      bins offset6_nine = {6'b001001};
      bins offset6_ten = {6'b001010};
      bins offset6_eleven = {6'b001011};
      bins offset6_twelve = {6'b001100};
      bins offset6_thirteen = {6'b001101};
      bins offset6_fourteen = {6'b001110};
      bins offset6_fifteen = {6'b001111};
      bins offset6_medium = {[6'b010000:6'b011111]};
      bins offset6_large = {[6'b100000:6'b111111]};
    }

    cp_baser_val: coverpoint (t_cov.instruction[8:6]) 
      iff(t_cov.instruction[15:12] == LDR || 
          t_cov.instruction[15:12] == STR || 
          t_cov.instruction[15:12] == JMP) {
      bins baser[] = {[3'h0:3'h7]};
    }

    cp_baser_instr: coverpoint(t_cov.instruction[15:12]) {
      bins baser_instr[] = {LDR, STR, JMP};
    }

    cp_offset6_instr: coverpoint (t_cov.instruction[15:12]) {
      bins offset6_instr[] = {LDR, STR};
    }

    cp_offset9_instr: coverpoint (t_cov.instruction[15:12]) {
      bins offset9_instr[] = {LD, LDI, LEA, ST, STI, BR};
    }

    cross_baser_instr: cross cp_baser_instr, cp_baser_val;
    cross_offset9_instr: cross cp_offset9_instr, cp_pcoffset9;
    cross_offset6_instr: cross cp_offset6_instr, cp_pcoffset6;

    // Register dependency coverage - when source and destination are the same
    cp_alu_dr_sr1_match: coverpoint (t_cov.instruction[11:9] == t_cov.instruction[8:6]) 
      iff((t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND || 
           t_cov.instruction[15:12] == NOT) && alu == 1'b1) {
      bins dr_equals_sr1 = {1'b1};
      bins dr_not_equals_sr1 = {1'b0};
    }

    // Offset boundary coverage for 9-bit offsets
    cp_offset9_boundary: coverpoint (t_cov.instruction[8:0]) 
      iff(t_cov.instruction[15:12] == LD || 
          t_cov.instruction[15:12] == LDI || 
          t_cov.instruction[15:12] == LEA || 
          t_cov.instruction[15:12] == ST || 
          t_cov.instruction[15:12] == STI || 
          t_cov.instruction[15:12] == BR) {
      bins offset_zero = {9'd0};
      bins offset_max = {9'd511};
      bins offset_min_neg = {9'd256};
      bins offset_positive = {[9'd1:9'd255]};
      bins offset_negative = {[9'd256:9'd511]};
    }

    // Offset boundary coverage for 6-bit offsets
    cp_offset6_boundary: coverpoint (t_cov.instruction[5:0]) 
      iff(t_cov.instruction[15:12] == LDR || t_cov.instruction[15:12] == STR) {
      bins offset_zero = {6'd0};
      bins offset_max = {6'd63};
      bins offset_positive = {[6'd1:6'd31]};
      bins offset_negative = {[6'd32:6'd63]};
    }

    // Instruction type transition coverage
    cp_instruction_category: coverpoint t_cov.instruction[15:12] {
      bins alu_cat[] = {ADD, AND, NOT};
      bins load_cat[] = {LD, LDR, LDI, LEA};
      bins store_cat[] = {ST, STR, STI};
      bins control_cat[] = {BR, JMP};
    }

    cp_prev_instruction_category: coverpoint prev_t_cov.instruction[15:12] {
      bins alu_cat[] = {ADD, AND, NOT};
      bins load_cat[] = {LD, LDR, LDI, LEA};
      bins store_cat[] = {ST, STR, STI};
      bins control_cat[] = {BR, JMP};
      bins first_inst = {4'b0000} iff(first == 1'b1);
    }

    cross_category_transition: cross cp_instruction_category, cp_prev_instruction_category;

    // Additional cross coverage for offset boundaries with instruction types
    cross_offset9_boundary_instr: cross cp_offset9_instr, cp_offset9_boundary;

    // Cross coverage for register dependencies with opcodes
    cross_alu_dr_sr1_opcode: cross cp_alu_ops, cp_alu_dr_sr1_match;

    // Cross coverage for offset6 boundaries with instruction types
    cross_offset6_boundary_instr: cross cp_offset6_instr, cp_offset6_boundary;
  endgroup

  // ****************************************************************************
  covergroup add_and_ops_cg;
    cp_imm_alu_ops: coverpoint t_cov.instruction[15:12] {
      bins add_type = {ADD};
      bins and_type = {AND};
    }

    cp_imm_alu_ops_imm_bit: coverpoint t_cov.instruction[5] 
      iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
      bins imm = {1'b1};
    }

    cp_reg_alu_ops_imm_bit: coverpoint t_cov.instruction[5] 
      iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
      bins register = {1'b0};
    }

    cp_alu_ops_dr: coverpoint t_cov.instruction[11:9] 
      iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
      bins dst[] = {[3'h0:3'h7]};
    }

    cp_imm_alu_ops_sr1: coverpoint t_cov.instruction[8:6] 
      iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
      bins src[] = {[3'h0:3'h7]};
    }

    cp_imm_alu_ops_sr2: coverpoint t_cov.instruction[2:0] 
      iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
      bins src[] = {[3'h0:3'h7]};
    }

    cp_reg_alu_ops_padding: coverpoint t_cov.instruction[4:3] 
      iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
      bins padding = {2'b00};
    }

    cp_imm_alu_ops_imm_val: coverpoint t_cov.instruction[4:0] 
      iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
      bins imm_val_zero = {5'd0};
      bins imm_val_one = {5'd1};
      bins imm_val_two = {5'd2};
      bins imm_val_three = {5'd3};
      bins imm_val_four = {5'd4};
      bins imm_val_five = {5'd5};
      bins imm_val_six = {5'd6};
      bins imm_val_seven = {5'd7};
      bins imm_val_eight = {5'd8};
      bins imm_val_nine = {5'd9};
      bins imm_val_ten = {5'd10};
      bins imm_val_eleven = {5'd11};
      bins imm_val_twelve = {5'd12};
      bins imm_val_thirteen = {5'd13};
      bins imm_val_fourteen = {5'd14};
      bins imm_val_fifteen = {5'd15};
      bins imm_val_sixteen = {5'd16};
      bins imm_val_seventeen = {5'd17};
      bins imm_val_eighteen = {5'd18};
      bins imm_val_nineteen = {5'd19};
      bins imm_val_twenty = {5'd20};
      bins imm_val_twenty_one = {5'd21};
      bins imm_val_twenty_two = {5'd22};
      bins imm_val_twenty_three = {5'd23};
      bins imm_val_twenty_four = {5'd24};
      bins imm_val_twenty_five = {5'd25};
      bins imm_val_twenty_six = {5'd26};
      bins imm_val_twenty_seven = {5'd27};
      bins imm_val_twenty_eight = {5'd28};
      bins imm_val_twenty_nine = {5'd29};
      bins imm_val_thirty = {5'd30};
      bins imm_val_thirty_one = {5'd31};
    }

    // Cross coverage for immediate mode operations
    // Total: 4096 possible combinations (2048 each for ADD & AND)
    cross_imm_alu_ops: cross cp_imm_alu_ops, cp_alu_ops_dr, cp_imm_alu_ops_sr1, 
                               cp_imm_alu_ops_imm_bit, cp_imm_alu_ops_imm_val;

    // Cross coverage for register mode operations
    // Total: 1024 possible combinations (512 each for ADD & AND)
    cross_reg_alu_ops: cross cp_imm_alu_ops, cp_alu_ops_dr, cp_imm_alu_ops_sr1, 
                               cp_reg_alu_ops_imm_bit, cp_reg_alu_ops_padding, cp_imm_alu_ops_sr2;

    // Register dependency coverage for ADD/AND
    cp_add_and_dr_sr1: coverpoint (t_cov.instruction[11:9] == t_cov.instruction[8:6]) 
      iff(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) {
      bins same_reg = {1'b1};
      bins diff_reg = {1'b0};
    }

    cp_add_and_dr_sr2: coverpoint (t_cov.instruction[11:9] == t_cov.instruction[2:0]) 
      iff((t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) && 
          t_cov.instruction[5] == 1'b0) {
      bins same_reg = {1'b1};
      bins diff_reg = {1'b0};
    }

    cp_add_and_sr1_sr2: coverpoint (t_cov.instruction[8:6] == t_cov.instruction[2:0]) 
      iff((t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) && 
          t_cov.instruction[5] == 1'b0) {
      bins same_reg = {1'b1};
      bins diff_reg = {1'b0};
    }

    // Immediate value boundary coverage
    cp_imm_val_boundary: coverpoint (t_cov.instruction[4:0]) 
      iff((t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND) && 
          t_cov.instruction[5] == 1'b1) {
      bins imm_zero = {5'd0};
      bins imm_max = {5'd31};
      bins imm_min_neg = {5'd16};
      bins imm_positive = {[5'd1:5'd15]};
      bins imm_negative = {[5'd16:5'd31]};
    }

    // Additional cross coverage for register combinations
    cross_add_and_reg_combos: cross cp_imm_alu_ops, cp_alu_ops_dr, cp_imm_alu_ops_sr1, 
                                        cp_add_and_dr_sr1;

    // Cross coverage for immediate vs register mode with register dependencies
    cross_add_and_mode_dep: cross cp_imm_alu_ops, cp_imm_alu_ops_imm_bit, 
                                       cp_add_and_dr_sr1;
  endgroup

  // ****************************************************************************
  covergroup not_cg;
    cp_not_op: coverpoint t_cov.instruction[15:12] {
      bins not_type = {NOT};
    }

    cp_not_op_dr: coverpoint t_cov.instruction[11:9] iff(t_cov.instruction[15:12] == NOT) {
      bins dst[] = {[3'h0:3'h7]};
    }

    cp_not_op_sr1: coverpoint t_cov.instruction[8:6] iff(t_cov.instruction[15:12] == NOT) {
      bins src[] = {[3'h0:3'h7]};
    }

    cp_not_op_padding: coverpoint t_cov.instruction[5:0] iff(t_cov.instruction[15:12] == NOT) {
      bins padding = {6'd63};
    }

    // Cross coverage: 64 possible NOT operations
    cross_not_ops: cross cp_not_op, cp_not_op_dr, cp_not_op_sr1, cp_not_op_padding;

    // Register dependency coverage for NOT
    cp_not_dr_sr1_match: coverpoint (t_cov.instruction[11:9] == t_cov.instruction[8:6]) 
      iff(t_cov.instruction[15:12] == NOT) {
      bins same_reg = {1'b1};
      bins diff_reg = {1'b0};
    }

    // Additional cross coverage for NOT with register dependency
    cross_not_reg_dep: cross cp_not_op, cp_not_op_dr, cp_not_op_sr1, cp_not_dr_sr1_match;
  endgroup

  // ****************************************************************************
  covergroup loads_cg;
    cp_ld_ldi_lea_ops: coverpoint t_cov.instruction[15:12] {
      bins ld_type = {LD};
      bins ldi_type = {LDI};
      bins lea_type = {LEA};
    }

    cp_ldr_op: coverpoint t_cov.instruction[15:12] {
      bins ldr_type = {LDR};
    }

    cp_loads_dr: coverpoint t_cov.instruction[11:9] 
      iff(t_cov.instruction[15:12] == LD || 
          t_cov.instruction[15:12] == LDI || 
          t_cov.instruction[15:12] == LEA || 
          t_cov.instruction[15:12] == LDR) {
      bins dr[] = {[3'd0:3'd7]};
    }

    cp_ldr_base_r: coverpoint t_cov.instruction[8:6] iff(t_cov.instruction[15:12] == LDR) {
      bins base_r[] = {[3'd0:3'd7]};
    }

    cp_pc_offset_9: coverpoint t_cov.instruction[8:0] 
      iff(t_cov.instruction[15:12] == LD || 
          t_cov.instruction[15:12] == LDI || 
          t_cov.instruction[15:12] == LEA) {
      bins pc_offset_zero = {9'd0};
      bins pc_offset_one = {9'd1};
      bins pc_offset_two = {9'd2};
      bins pc_offset_three = {9'd3};
      bins pc_offset_four = {9'd4};
      bins pc_offset_five = {9'd5};
      bins pc_offset_small = {[9'd6:9'd15]};
      bins pc_offset_medium = {[9'd16:9'd63]};
      bins pc_offset_large = {[9'd64:9'd255]};
      bins pc_offset_max = {9'd511};
      bins pc_offset_neg_small = {[9'd256:9'd383]};
      bins pc_offset_neg_medium = {[9'd384:9'd447]};
      bins pc_offset_neg_large = {[9'd448:9'd510]};
    }

    cp_pc_offset_6: coverpoint t_cov.instruction[5:0] iff(t_cov.instruction[15:12] == LDR) {
      bins pc_offset_zero = {6'd0};
      bins pc_offset_one = {6'd1};
      bins pc_offset_two = {6'd2};
      bins pc_offset_three = {6'd3};
      bins pc_offset_four = {6'd4};
      bins pc_offset_five = {6'd5};
      bins pc_offset_small = {[6'd6:6'd15]};
      bins pc_offset_medium = {[6'd16:6'd31]};
      bins pc_offset_large = {[6'd32:6'd47]};
      bins pc_offset_max = {6'd63};
      bins pc_offset_neg_small = {[6'd48:6'd55]};
      bins pc_offset_neg_medium = {[6'd56:6'd62]};
    }

    // Cross coverage for LD, LDI, LEA: 12288 possible combinations
    // (4096 each opcode)
    cross_ld_ldi_lea_ops: cross cp_ld_ldi_lea_ops, cp_loads_dr, cp_pc_offset_9;

    // Cross coverage for LDR: 4096 possible combinations
    cross_ldr_ops: cross cp_ldr_op, cp_loads_dr, cp_ldr_base_r, cp_pc_offset_6;

    // LEA specific coverage (doesn't access memory, just computes address)
    cp_lea_specific: coverpoint t_cov.instruction[15:12] {
      bins lea_only = {LEA};
    }

    cp_lea_offset_boundary: coverpoint (t_cov.instruction[8:0]) 
      iff(t_cov.instruction[15:12] == LEA) {
      bins lea_offset_zero = {9'd0};
      bins lea_offset_one = {9'd1};
      bins lea_offset_two = {9'd2};
      bins lea_offset_three = {9'd3};
      bins lea_offset_four = {9'd4};
      bins lea_offset_five = {9'd5};
      bins lea_offset_small = {[9'd6:9'd15]};
      bins lea_offset_medium = {[9'd16:9'd63]};
      bins lea_offset_large = {[9'd64:9'd255]};
      bins lea_offset_max = {9'd511};
      bins lea_offset_neg_small = {[9'd256:9'd383]};
      bins lea_offset_neg_medium = {[9'd384:9'd447]};
      bins lea_offset_neg_large = {[9'd448:9'd510]};
    }

    // Register dependency for loads
    cp_load_dr_base_match: coverpoint (t_cov.instruction[11:9] == t_cov.instruction[8:6]) 
      iff(t_cov.instruction[15:12] == LDR) {
      bins same_reg = {1'b1};
      bins diff_reg = {1'b0};
    }

    // Additional cross coverage for LDR with register dependency
    cross_ldr_reg_dep: cross cp_ldr_op, cp_loads_dr, cp_ldr_base_r, cp_load_dr_base_match;

    // Cross coverage for LEA with offset ranges
    cross_lea_offset_ranges: cross cp_lea_specific, cp_loads_dr, cp_lea_offset_boundary;
  endgroup

  // ****************************************************************************
  covergroup stores_cg;
    cp_st_sti_ops: coverpoint t_cov.instruction[15:12] {
      bins st_type = {ST};
      bins sti_type = {STI};
    }

    cp_str_op: coverpoint t_cov.instruction[15:12] {
      bins str_type = {STR};
    }

    cp_stores_sr: coverpoint t_cov.instruction[11:9] 
      iff(t_cov.instruction[15:12] == ST || 
          t_cov.instruction[15:12] == STI || 
          t_cov.instruction[15:12] == STR) {
      bins sr[] = {[3'd0:3'd7]};
    }

    cp_str_base_r: coverpoint t_cov.instruction[8:6] iff(t_cov.instruction[15:12] == STR) {
      bins base_r[] = {[3'd0:3'd7]};
    }

    cp_st_sti_offset_9: coverpoint t_cov.instruction[8:0] 
      iff(t_cov.instruction[15:12] == ST || t_cov.instruction[15:12] == STI) {
      bins pc_offset_zero = {9'd0};
      bins pc_offset_one = {9'd1};
      bins pc_offset_two = {9'd2};
      bins pc_offset_three = {9'd3};
      bins pc_offset_four = {9'd4};
      bins pc_offset_five = {9'd5};
      bins pc_offset_small = {[9'd6:9'd15]};
      bins pc_offset_medium = {[9'd16:9'd63]};
      bins pc_offset_large = {[9'd64:9'd255]};
      bins pc_offset_max = {9'd511};
      bins pc_offset_neg_small = {[9'd256:9'd383]};
      bins pc_offset_neg_medium = {[9'd384:9'd447]};
      bins pc_offset_neg_large = {[9'd448:9'd510]};
    }

    cp_str_offset_6: coverpoint t_cov.instruction[5:0] iff(t_cov.instruction[15:12] == STR) {
      bins pc_offset_zero = {6'd0};
      bins pc_offset_one = {6'd1};
      bins pc_offset_two = {6'd2};
      bins pc_offset_three = {6'd3};
      bins pc_offset_four = {6'd4};
      bins pc_offset_five = {6'd5};
      bins pc_offset_small = {[6'd6:6'd15]};
      bins pc_offset_medium = {[6'd16:6'd31]};
      bins pc_offset_large = {[6'd32:6'd47]};
      bins pc_offset_max = {6'd63};
      bins pc_offset_neg_small = {[6'd48:6'd55]};
      bins pc_offset_neg_medium = {[6'd56:6'd62]};
    }

    // Cross coverage for ST, STI: 8192 possible combinations
    // (4096 each opcode)
    cross_st_sti_ops: cross cp_st_sti_ops, cp_stores_sr, cp_st_sti_offset_9;

    // Cross coverage for STR: 4096 possible combinations
    cross_str_ops: cross cp_str_op, cp_stores_sr, cp_str_base_r, cp_str_offset_6;

    // Store offset boundary coverage
    cp_store_offset9_boundary: coverpoint (t_cov.instruction[8:0]) 
      iff(t_cov.instruction[15:12] == ST || t_cov.instruction[15:12] == STI) {
      bins store_offset_zero = {9'd0};
      bins store_offset_one = {9'd1};
      bins store_offset_two = {9'd2};
      bins store_offset_three = {9'd3};
      bins store_offset_four = {9'd4};
      bins store_offset_five = {9'd5};
      bins store_offset_small = {[9'd6:9'd15]};
      bins store_offset_medium = {[9'd16:9'd63]};
      bins store_offset_large = {[9'd64:9'd255]};
      bins store_offset_max = {9'd511};
      bins store_offset_neg_small = {[9'd256:9'd383]};
      bins store_offset_neg_medium = {[9'd384:9'd447]};
      bins store_offset_neg_large = {[9'd448:9'd510]};
    }

    // Register dependency for stores
    cp_store_sr_base_match: coverpoint (t_cov.instruction[11:9] == t_cov.instruction[8:6]) 
      iff(t_cov.instruction[15:12] == STR) {
      bins same_reg = {1'b1};
      bins diff_reg = {1'b0};
    }

    // Additional cross coverage for STR with register dependency
    cross_str_reg_dep: cross cp_str_op, cp_stores_sr, cp_str_base_r, cp_store_sr_base_match;

    // Cross coverage for ST/STI with offset ranges
    cross_st_sti_offset_ranges: cross cp_st_sti_ops, cp_stores_sr, cp_store_offset9_boundary;
  endgroup

  // ****************************************************************************
  covergroup control_cg;
    cp_br_op: coverpoint t_cov.instruction[15:12] {
      bins br_type = {BR};
    }

    cp_jmp_op: coverpoint t_cov.instruction[15:12] {
      bins br_type = {JMP};
    }

    cp_nzp: coverpoint t_cov.instruction[11:9] iff(t_cov.instruction[15:12] == BR) {
      bins BRZ = {3'b010};
      bins BRNP = {3'b101};
      bins BRP = {3'b001};
      bins BRZP = {3'b011};
      bins BRN = {3'b100};
      bins BRNZ = {3'b110};
      bins BRNZP = {3'b111};
    }

    cp_jmp_padding_3: coverpoint t_cov.instruction[11:9] iff(t_cov.instruction[15:12] == JMP) {
      bins padding = {3'b000};
    }

    cp_br_pc_offset_9: coverpoint t_cov.instruction[8:0] iff(t_cov.instruction[15:12] == BR) {
      bins pc_offset_zero = {9'd0};
      bins pc_offset_one = {9'd1};
      bins pc_offset_two = {9'd2};
      bins pc_offset_three = {9'd3};
      bins pc_offset_four = {9'd4};
      bins pc_offset_five = {9'd5};
      bins pc_offset_small = {[9'd6:9'd15]};
      bins pc_offset_medium = {[9'd16:9'd63]};
      bins pc_offset_large = {[9'd64:9'd255]};
      bins pc_offset_max = {9'd511};
      bins pc_offset_neg_small = {[9'd256:9'd383]};
      bins pc_offset_neg_medium = {[9'd384:9'd447]};
      bins pc_offset_neg_large = {[9'd448:9'd510]};
    }

    cp_jmp_base_r: coverpoint t_cov.instruction[8:6] iff(t_cov.instruction[15:12] == JMP) {
      bins base_r[] = {[3'd0:3'd7]};
    }

    cp_jmp_padding_6: coverpoint t_cov.instruction[5:0] iff(t_cov.instruction[15:12] == JMP) {
      bins padding = {6'b000000};
    }

    // Cross coverage for BR: 3584 possible combinations
    cross_br_ops: cross cp_br_op, cp_nzp, cp_br_pc_offset_9;

    // Cross coverage for JMP: 8 possible combinations
    cross_jmp_ops: cross cp_jmp_op, cp_jmp_padding_3, cp_jmp_base_r, cp_jmp_padding_6;

    // BR offset boundary coverage
    cp_br_offset_boundary: coverpoint (t_cov.instruction[8:0]) 
      iff(t_cov.instruction[15:12] == BR) {
      bins br_offset_zero = {9'd0};
      bins br_offset_one = {9'd1};
      bins br_offset_two = {9'd2};
      bins br_offset_three = {9'd3};
      bins br_offset_four = {9'd4};
      bins br_offset_five = {9'd5};
      bins br_offset_small = {[9'd6:9'd15]};
      bins br_offset_medium = {[9'd16:9'd63]};
      bins br_offset_large = {[9'd64:9'd255]};
      bins br_offset_max = {9'd511};
      bins br_offset_neg_small = {[9'd256:9'd383]};
      bins br_offset_neg_medium = {[9'd384:9'd447]};
      bins br_offset_neg_large = {[9'd448:9'd510]};
    }

    // BR condition coverage - individual flags
    cp_br_n_flag: coverpoint t_cov.instruction[11] iff(t_cov.instruction[15:12] == BR) {
      bins n_set = {1'b1};
      bins n_clear = {1'b0};
    }

    cp_br_z_flag: coverpoint t_cov.instruction[10] iff(t_cov.instruction[15:12] == BR) {
      bins z_set = {1'b1};
      bins z_clear = {1'b0};
    }

    cp_br_p_flag: coverpoint t_cov.instruction[9] iff(t_cov.instruction[15:12] == BR) {
      bins p_set = {1'b1};
      bins p_clear = {1'b0};
    }

    // Additional cross coverage for BR with individual flags
    cross_br_flags: cross cp_br_op, cp_br_n_flag, cp_br_z_flag, cp_br_p_flag;

    // Cross coverage for BR with offset ranges
    cross_br_offset_ranges: cross cp_br_op, cp_nzp, cp_br_offset_boundary;
  endgroup

  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new(string name = "", uvm_component parent = null);
    super.new(name, parent);
    imem_transaction_cg = new;
    add_and_ops_cg = new;
    not_cg = new;
    loads_cg = new;
    stores_cg = new;
    control_cg = new;
  endfunction

  // ****************************************************************************
  // FUNCTION : build_phase()
  // This function is the standard UVM build_phase.
  //
  function void build_phase(uvm_phase phase);
    imem_transaction_cg.set_inst_name($sformatf("imem_transaction_cg_%s", get_full_name()));
    add_and_ops_cg.set_inst_name($sformatf("add_and_ops_cg%s", get_full_name()));
    not_cg.set_inst_name($sformatf("not_cg%s", get_full_name()));
    loads_cg.set_inst_name($sformatf("loads_cg%s", get_full_name()));
    stores_cg.set_inst_name($sformatf("stores_cg%s", get_full_name()));
    control_cg.set_inst_name($sformatf("control_cg%s", get_full_name()));
  endfunction

  // ****************************************************************************
  // FUNCTION: write (T t)
  // This function is automatically executed when a transaction arrives on the
  // analysis_export.  It copies values from the variables in the transaction 
  // to local variables used to collect functional coverage.  
  //
  virtual function void write(T t);
    `uvm_info("IMEM_COV", "Received transaction", UVM_HIGH);
    coverage_trans = t;
    t_cov = t;

    // Classify instruction type
    if((t_cov.instruction[15:12] == ADD) || 
       (t_cov.instruction[15:12] == AND) || 
       (t_cov.instruction[15:12] == NOT)) begin
      alu = 1;
    end

    if((t_cov.instruction[15:12] == LD) || 
       (t_cov.instruction[15:12] == LDR) || 
       (t_cov.instruction[15:12] == LDI) || 
       (t_cov.instruction[15:12] == LEA)) begin
      ld = 1;
    end

    if((t_cov.instruction[15:12] == ST) || 
       (t_cov.instruction[15:12] == STR) || 
       (t_cov.instruction[15:12] == STI)) begin
      str = 1;
    end

    if((t_cov.instruction[15:12] == BR) || 
       (t_cov.instruction[15:12] == JMP)) begin
      flow_switch = 1;
    end

    if(first == 1'b1) begin
      prev_t_cov = t;
    end

    // Sample all coverage groups
    imem_transaction_cg.sample();
    add_and_ops_cg.sample();
    not_cg.sample();
    loads_cg.sample();
    stores_cg.sample();
    control_cg.sample();

    // Update state for next transaction
    prev_t_cov = t;
    first = 1'b0;
    alu = 0;
    ld = 0;
    str = 0;
    flow_switch = 0;
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end
