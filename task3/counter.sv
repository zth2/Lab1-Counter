module counter #(
  parameter WIDTH = 8
)(
  // interface signals
  input  logic             clk,      // clock
  input  logic             rst,      // reset
  input  logic             ld,       // load counter from data
  input  logic [WIDTH-1:0] v,        // value to preload
  output logic [WIDTH-1:0] count     // count output
);

always_ff @ (posedge clk) begin
  if (rst) 
    count <= {WIDTH{1'b0}};           // Reset the counter to 0
  else 
    count <= ld ? v : count + {{WIDTH-1{1'b0}}, 1'b1}; // Load or increment the counter
end

endmodule  // This is the correct way to end the module
