interface apb_if(input logic clk, input logic rst_n);
  
  // Standard APB signals
  logic [31:0] paddr;
  logic        psel;
  logic        penable;
  logic        pwrite;
  logic [31:0] pwdata;
  logic [31:0] prdata;
  logic        pready;

  // Driver clocking block
  clocking drv_cb @(posedge clk);
    default input #1ns output #1ns;
    output paddr, psel, penable, pwrite, pwdata;
    input  pready, prdata;
  endclocking

  // Monitor clocking block
  clocking mon_cb @(posedge clk);
    default input #1ns output #1ns;
    input paddr, psel, penable, pwrite, pwdata, pready, prdata;
  endclocking

endinterface
