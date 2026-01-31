module top;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // 1. Clock and Reset generation
  logic clk;
  logic rst_n;

  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100MHz clock
  end

  initial begin
    rst_n = 0;
    #20 rst_n = 1;
  end

  // 2. Instantiate Interface
  apb_if pif(clk, rst_n);

  // 3. Instantiate RTL (DUT)
  apb_slave dut (
    .pclk(pif.clk),
    .presetn(pif.rst_n),
    .paddr(pif.paddr),
    .psel(pif.psel),
    .penable(pif.penable),
    .pwrite(pif.pwrite),
    .pwdata(pif.pwdata),
    .prdata(pif.prdata),
    .pready(pif.pready)
  );

  // 4. Start the test
  initial begin
    // Pass the interface to UVM config_db
    uvm_config_db#(virtual apb_if)::set(null, "*", "vif", pif);
    
    run_test("apb_base_test");
  end

endmodule
