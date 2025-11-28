//----------------------------------------------------------------------
// Extending imem_transaction and adding constraints specific to ALU
//----------------------------------------------------------------------

class imem_alu_transaction extends imem_transaction;
  `uvm_object_utils(imem_alu_transaction)

  function new(string name = "imem_alu_transaction");
    super.new(name);
  endfunction

  constraint c_complete_instr { complete_instr == 1; }

  constraint c_alu_opcodes {
    Instr_dout[15:12] inside {4'b0001, 4'b0101, 4'b1001};
  }

  constraint c_reg_fields {
    Instr_dout[11:9] inside {[0:7]};
    Instr_dout[8:6]  inside {[0:7]};
    Instr_dout[2:0]  inside {[0:7]};
  }

  constraint c_add_and_modes {
    if (Instr_dout[15:12] inside {4'b0001, 4'b0101}) {
      Instr_dout[5] dist { 1 := 50, 0 := 50 };

      if (Instr_dout[5] == 1)
        Instr_dout[4:0] inside {[0:31]};   // imm5 range
    }
  }

  constraint c_not_format {
    if (Instr_dout[15:12] == 4'b1001)
      Instr_dout[5:0] == 6'b111111;
  }

endclass
