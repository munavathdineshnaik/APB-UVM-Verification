class apb_transaction extends uvm_sequence_item;
  
  // Randomized fields for stimulus
  rand logic [31:0] addr;
  rand logic [31:0] wdata;
  rand logic        write;
  logic [31:0]      rdata; 

  // Register with UVM factory
  `uvm_object_utils_begin(apb_transaction)
    `uvm_field_int(addr,  UVM_ALL_ON)
    `uvm_field_int(wdata, UVM_ALL_ON)
    `uvm_field_int(write, UVM_ALL_ON)
    `uvm_field_int(rdata, UVM_ALL_ON)
  `uvm_object_utils_end

  // Simple constraint to keep address within memory range
  constraint addr_range { addr >= 0; addr <= 1024; }

  function new(string name = "apb_transaction");
    super.new(name);
  endfunction

endclass
