class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)

  virtual apb_if vif;
  uvm_analysis_port #(apb_transaction) item_collected_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
    item_collected_port = new("item_collected_port", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    forever begin
      apb_transaction tr;
      tr = apb_transaction::type_id::create("tr");

      // Wait for the Access phase of a transfer
      @(posedge vif.mon_cb.penable);
      wait(vif.mon_cb.pready == 1);

      // Sample data from wires
      tr.addr  = vif.mon_cb.paddr;
      tr.write = vif.mon_cb.pwrite;
      
      if (tr.write) 
        tr.wdata = vif.mon_cb.pwdata;
      else 
        tr.rdata = vif.mon_cb.prdata;

      // Send transaction to scoreboard
      item_collected_port.write(tr);
      
      // Wait for transaction to finish
      @(vif.mon_cb);
    end
  endtask
endclass
