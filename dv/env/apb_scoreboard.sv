class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)

  // Port to receive transactions from monitor
  uvm_analysis_imp #(apb_transaction, apb_scoreboard) item_collected_export;

  // Internal memory model (Associative array)
  logic [31:0] sc_mem [logic [31:0]];

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_export = new("item_collected_export", this);
  endfunction

  // This function is automatically called when monitor sends data
  virtual function void write(apb_transaction tr);
    if (tr.write) begin
      // Store written data in model
      sc_mem[tr.addr] = tr.wdata;
      `uvm_info("SCB", $sformatf("Store: Addr=0x%0h, Data=0x%0h", tr.addr, tr.wdata), UVM_LOW)
    end
    else begin
      // Check read data against model
      if (sc_mem.exists(tr.addr)) begin
        if (sc_mem[tr.addr] == tr.rdata)
          `uvm_info("SCB", $sformatf("PASS: Addr=0x%0h, Data=0x%0h", tr.addr, tr.rdata), UVM_LOW)
        else
          `uvm_error("SCB", $sformatf("FAIL: Addr=0x%0h, Exp=0x%0h, Got=0x%0h", tr.addr, sc_mem[tr.addr], tr.rdata))
      end
    end
  endfunction
endclass
