class apb_driver extends uvm_driver #(apb_transaction);
  `uvm_component_utils(apb_driver)

  virtual apb_if vif; // Pointer to the interface

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // The main task where driving happens
  virtual task run_phase(uvm_phase phase);
    // Reset signals
    vif.paddr   <= 0;
    vif.psel    <= 0;
    vif.penable <= 0;
    vif.pwrite  <= 0;
    vif.pwdata  <= 0;

    forever begin
      // Get next item from sequencer
      seq_item_port.get_next_item(req);
      drive_transfer(req);
      seq_item_port.item_done();
    end
  endtask

  // Logic to drive APB protocol states
  task drive_transfer(apb_transaction tr);
    @(vif.drv_cb);
    // SETUP Phase
    vif.drv_cb.paddr  <= tr.addr;
    vif.drv_cb.pwrite <= tr.write;
    vif.drv_cb.psel   <= 1;
    if (tr.write) vif.drv_cb.pwdata <= tr.wdata;

    @(vif.drv_cb);
    // ACCESS Phase
    vif.drv_cb.penable <= 1;

    // Wait for Slave to be ready
    wait(vif.drv_cb.pready == 1);

    @(vif.drv_cb);
    vif.drv_cb.psel    <= 0;
    vif.drv_cb.penable <= 0;
  endtask

class_end
