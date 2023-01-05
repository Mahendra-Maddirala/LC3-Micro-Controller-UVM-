//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
// This sequences randomizes the dmem transaction and sends it 
// to the UVM driver.
//
// This sequence constructs and randomizes a dmem_transaction.
// 
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class dmem_random_sequence 
  extends dmem_sequence_base ;

  `uvm_object_utils( dmem_random_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  //*****************************************************************
  function new(string name = "");
    super.new(name);
  endfunction: new

  // ****************************************************************************
  // TASK : body()
  // This task is automatically executed when this sequence is started using the 
  // start(sequencerHandle) task.
  //
  task body();
  
      // Construct the transaction
      req=dmem_transaction::type_id::create("req");
      start_item(req);
      // Randomize the transaction
      if(!req.randomize()) `uvm_fatal("SEQ", "dmem_random_sequence::body()-dmem_transaction randomization failed")
      // Send the transaction to the dmem_driver_bfm via the sequencer and dmem_driver.
      finish_item(req);
      `uvm_info("SEQ", {"Response:",req.convert2string()},UVM_MEDIUM)

  endtask

endclass: dmem_random_sequence

// pragma uvmf custom external begin
// pragma uvmf custom external end

