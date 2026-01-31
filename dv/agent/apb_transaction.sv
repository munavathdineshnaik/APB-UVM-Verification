// File: dv/agent/apb_transaction.sv
`ifndef APB_TRANSACTION_SV
`define APB_TRANSACTION_SV

class apb_transaction extends uvm_sequence_item;
  
  // 1. Define the signals as random variables
  rand logic [31:0] paddr;    // Address
  rand logic [31:0] pwdata;   // Data to write
  rand logic        pwrite;   // 1=Write, 0=Read
  logic [31:0]      prdata;   // Data read from Slave (not random)

  // 2. Boilerplate for UVM automation
  `uvm_object_utils_begin(apb_transaction)
    `uvm_field_int(paddr,  UVM_ALL_ON)
    `uvm_field_int(pwdata, UVM_ALL_ON)
    `uvm_field_int(pwrite, UVM_ALL_ON)
    `uvm_field_int(prdata, UVM_ALL_ON)
  `uvm_object_utils_end

  // 3. Constraints (Interviewers love these!)
  constraint addr_alignment { paddr[1:0] == 2'b00; } // 4-byte aligned
  constraint data_limit     { pwdata < 32'hFFFF_FFFF; }

  function new(string name = "apb_transaction");
    super.new(name);
  endfunction

endclass

`endif
