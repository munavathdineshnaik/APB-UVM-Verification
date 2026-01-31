class apb_base_seq extends uvm_sequence #(apb_transaction);
  `uvm_object_utils(apb_base_seq)

  function new(string name = "apb_base_seq");
    super.new(name);
  endfunction

  virtual task body();
    // Generate 10 random transactions
    repeat(10) begin
      req = apb_transaction::type_id::create("req");
      start_item(req);
      
      // Randomize address and data
      if (!req.randomize()) `uvm_error("SEQ", "Randomization failed")
      
      finish_item(req);
    end
  endtask
endclass
