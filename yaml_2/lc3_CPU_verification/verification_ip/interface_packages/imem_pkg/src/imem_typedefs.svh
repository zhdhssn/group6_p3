//----------------------------------------------------------------------
// Created with uvmf_gen version 2023.4_2
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This file contains defines and typedefs to be compiled for use in
// the simulation running on the host server when using Veloce.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//


// pragma uvmf custom additional begin
//Harry: LC3 opcode enumeration for readability within IMEM sequences
typedef enum bit [3:0] {
  ADD = 4'b0001,
  AND = 4'b0101,
  NOT = 4'b1001,
  LD  = 4'b0010,
  LDR = 4'b0110,
  LDI = 4'b1010,
  LEA = 4'b1110,
  ST  = 4'b0011,
  STR = 4'b0111,
  STI = 4'b1011,
  BR  = 4'b0000,
  JMP = 4'b1100
} lc3_opcode_e;
// pragma uvmf custom additional end

