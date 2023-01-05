//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class can be used to provide stimulus when an interface
//              has been configured to run in a raw_responder mode. It
//              will never finish by default, always going back to the driver
//              and driver BFM for the next transaction with which to respond.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class imem_raw_responder_sequence 
  extends imem_responder_sequence ;

  `uvm_object_utils( imem_raw_responder_sequence )

  // pragma uvmf custom class_item_additional begin
  int count = -1;
  bit sr1_rd_dep = 0;
  bit [2:0]saved_dr = 3'b0;
  // pragma uvmf custom class_item_additional end

  function new(string name = "imem_raw_responder_sequence");
    super.new(name);
  endfunction

  task body();
    req=imem_transaction::type_id::create("req");
    repeat(1000) begin
      start_item(req);
      if(count == 0) assert(req.randomize() with {opcode == BR; n == 1'b1 ; z == 1'b1 ; p == 1'b1;});
      else if(count >= 1  && count < 9 )assert(req.randomize() with {opcode == LD ; dr == count-1; });
      else if(count >= 9 && count < 17) assert(req.randomize() with {opcode == ST ; sr1 == count - 9;});
      else begin
         if(count % 2 == 0)begin
            assert(req.randomize() with {opcode inside {ADD,AND,NOT,LD,LDR,LDI,LEA};});
            saved_dr = req.dr;
         end
         else begin
            sr1_rd_dep = $urandom_range(0,1);
            if(sr1_rd_dep) assert(req.randomize() with {opcode inside {ADD,AND,NOT,ST,STR,STI,LDR}; sr1 == saved_dr;baser == saved_dr;});
            else begin
               assert(req.randomize() with {opcode inside {ADD,AND,NOT,ST,STR,STI,LDR}; sr2 == saved_dr;baser == saved_dr;});
            end
         end
      end
      finish_item(req);
      // pragma uvmf custom body begin
      // UVMF_CHANGE_ME : Do something here with the resulting req item.  The
      // finish_item() call above will block until the req transaction is ready
      // to be handled by the raw_responder sequence.
      // If this was an item that required a response, the expectation is
      // that the response should be populated within this transaction now.
      `uvm_info("SEQ",$sformatf("Processed txn: %s",req.convert2string()),UVM_HIGH)
      count  = count + 1;
      // pragma uvmf custom body end
    end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

