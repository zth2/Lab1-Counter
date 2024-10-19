module top #(
  parameter WIDTH = 8
)(
  // interface signals
  input  logic             clk,      // clock
  input  logic             rst,      // reset
  input  logic             ld,       // load signal
  input  logic [WIDTH-1:0] v,        // value to preload
  output logic [11:0]      bcd       // BCD output
);

  logic  [WIDTH-1:0]       count;    // interconnect wire

// Instantiate the counter module
counter myCounter (
  .clk   (clk),
  .rst   (rst),
  .ld    (ld),    // Load signal (formerly 'en')
  .v     (v),     // Preload value
  .count (count)
);

// Instantiate the binary-to-BCD decoder
bin2bcd myDecoder (
  .x   (count),
  .BCD (bcd)
);

endmodule
