class apb_base_test extends uvm_test;
  `uvm_component_utils(apb_base_test)

  apb_env env;

  function new(string name = "apb_base_test", uvm_component parent);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = apb_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);
    apb_base_seq seq;
    phase.raise_objection(this); // Start the test
    
    seq = apb_base_seq::type_id::create("seq");
    seq.start(env.agent.sequencer); // Run sequence on sequencer
    
    #100ns; // Small delay before finishing
    phase.drop_objection(this); // End the test
  endtask
endclass
