//---------------------------------------------------------------------
// ALU-only IMEM transaction
// Extends imem_transaction and constrains only ALU operations
//---------------------------------------------------------------------

class imem_alu_transaction extends imem_transaction;
  `uvm_object_utils(imem_alu_transaction)

  function new(string name="imem_alu_transaction");
    super.new(name);
  endfunction

  // ALU instructions always complete in your test
  constraint c_complete_instr {
    complete_instr == 1;
  }

  // Allowed ALU opcodes: ADD (0001), AND (0101), NOT (1001)
  constraint c_opcodes {
    Instr_dout[15:12] inside {
      4'b0001,   // ADD
      4'b0101,   // AND
      4'b1001    // NOT
    };
  }

  // Registers must be valid (0–7)
  constraint c_registers {
    Instr_dout[11:9] inside {[0:7]}; // DR
    Instr_dout[8:6]  inside {[0:7]}; // SR1
  }

  // ADD, AND → may use SR2 or IMM5
  constraint c_add_and {
    if (Instr_dout[15:12] inside {4'b0001, 4'b0101}) {
      // mode bit random: 0 = SR2, 1 = IMM5
      Instr_dout[5] dist { 1 := 50, 0 := 50 };

      if (Instr_dout[5] == 0)
        Instr_dout[2:0] inside {[0:7]};   // SR2 valid

      if (Instr_dout[5] == 1)
        Instr_dout[4:0] inside {[0:31]};  // imm5 = signed 5-bit
    }
  }

  // NOT instruction → bits [5:0] are 111111
  constraint c_not {
    if (Instr_dout[15:12] == 4'b1001)
      Instr_dout[5:0] == 6'b111111;
  }

endclass


