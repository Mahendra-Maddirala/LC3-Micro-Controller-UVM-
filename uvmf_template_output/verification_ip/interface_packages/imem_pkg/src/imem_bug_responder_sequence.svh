//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class can be used to provide stimulus when an interface
//              has been configured to run in a bug_responder mode. It
//              will never finish by default, always going back to the driver
//              and driver BFM for the next transaction with which to respond.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_bug_responder_sequence 
  extends imem_responder_sequence ;

  `uvm_object_utils( imem_bug_responder_sequence )

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_bug_responder_sequence");
    super.new(name);
  endfunction

  task body();
    int count = -1;
    req=imem_transaction::type_id::create("req");
    repeat(250) begin           
      start_item(req);
      if(count >=0 && count < 8)assert(req.randomize() with {opcode == LD ; dr == count; });
      else if(count >= 8 && count < 16) assert(req.randomize() with {opcode == ST ; sr1 == count - 8;});
      else assert(req.randomize() with {opcode inside {ADD,AND,NOT};});
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the bug_responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      count++;
      // pragma uvmf custom body end
    end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

