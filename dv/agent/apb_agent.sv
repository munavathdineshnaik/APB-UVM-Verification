class apb_agent extends uvm_agent;
  `uvm_component_utils(apb_agent)

  apb_driver    driver;
  apb_sequencer sequencer;
  apb_monitor   monitor;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Create monitor always
    monitor = apb_monitor::type_id::create("monitor", this);

    // Create driver and sequencer only if agent is ACTIVE
    if (get_is_active() == UVM_ACTIVE) begin
      driver = apb_driver::type_id::create("driver", this);
      sequencer = apb_sequencer::type_id::create("sequencer", this);
    end
  endfunction

  virtual function void connect_phase(uvm_phase phase);
    if (get_is_active() == UVM_ACTIVE) begin
      // Connect driver to sequencer
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction
endclass
