// Observes output signals from the decode unit
interface decode_out_if (
    input tri clock,
    input tri reset,
    input bit enable_decode
);

    // Output signals
    logic [15:0] IR_dout; // instruction output
    logic [15:0] npc_out; // next program counter output
    logic [1:0] W_Control; // write control
    logic Mem_Control; // memory control
    logic [5:0] E_Control; // execution control

    // Monitor port
    modport monitor_port (
        input clock,
        input reset,
        input enable_decode,
        input IR_dout,
        input npc_out,
        input W_Control,
        input Mem_Control,
        input E_Control
    );

    // Driver port, allows for driving the output signals but only monitor port is allowed to observe them
    // Output signals are driven by the DUT (Decode Unit)
    // modport driver_port (
    //     input clock,
    //     input reset,
    //     input enable_decode,
    //     output IR_dout,
    //     output npc_out,
    //     output W_Control,
    //     output Mem_Control,
    //     output E_Control
    // );

endinterface