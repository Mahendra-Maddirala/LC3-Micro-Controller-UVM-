//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class can be used to provide stimulus when an interface
//              has been configured to run in a responder mode. It
//              will never finish by default, always going back to the driver
//              and driver BFM for the next transaction with which to respond.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class dmem_responder_sequence 
  extends dmem_sequence_base ;

  `uvm_object_utils( dmem_responder_sequence )

  // pragma uvmf custom class_item_additional begin
  int force_data;
  int count = 0;
  bit [15:0]init_data = 16'hffff;
  // pragma uvmf custom class_item_additional end

  function new(string name = "dmem_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req=dmem_transaction::type_id::create("req");
    forever begin
      start_item(req);
      force_data = $urandom;
      if(count >= 1 && count < 9)begin
         assert(req.randomize() with {Data_dout == init_data;});
         init_data = init_data + 16'b1;
      end
      else if(force_data % 10 == 0)assert(req.randomize() with {Data_dout == 16'b0;});
      else if(force_data % 9 == 0) assert(req.randomize() with {Data_dout == 16'b1;});
      else assert(req.randomize());
      finish_item(req);
      count = count+1;
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      // pragma uvmf custom body end
    end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

