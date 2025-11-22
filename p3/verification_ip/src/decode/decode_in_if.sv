interface  decode_in_if 
  (
  input tri clock,
  input tri reset
);

  // Input signals
  logic enable_decode;  // Master enable
  logic [15:0] dout;    // IMem_dout
  logic [15:0] npc_in;  // PC + 1

  // Monitor port
  modport monitor_port (
    input clock,
    input reset,
    input enable_decode,
    input dout,
    input npc_in

  );

  // Driver port
  modport driver_port (
    input clock,      
    input reset,      
    output enable_decode,
    output dout,
    output npc_in
  );


endinterface


