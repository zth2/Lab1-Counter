module counter #(
  parameter WIDTH = 8
)(
  // interface signals
  input  logic             clk,      // clock
  input  logic             rst,      // reset
  input  logic             ld,       // load counter from data
  input  logic             step,     // single step signal
  input  logic [WIDTH-1:0] v,        // value to preload
  output logic [WIDTH-1:0] count     // count output
);

always_ff @ (posedge clk) begin
  if (rst) 
    count <= {WIDTH{1'b0}};            // Reset the counter to 0
  else if (ld) 
    count <= v;                        // Load the pre-set value when ld is asserted
  else if (step)
    count <= count + {{WIDTH-1{1'b0}}, 1'b1};  // Increment only when step is active
end

endmodule
