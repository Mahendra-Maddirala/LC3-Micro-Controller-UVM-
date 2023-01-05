//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an dmem
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class dmem_transaction  extends uvmf_transaction_base;

  `uvm_object_utils( dmem_transaction )

  bit complete_data ;
  rand int wait_complete ;
  rand bit [15:0] Data_dout ;
  bit [15:0] Data_din ;
  bit [15:0] Data_addr ;
  bit Data_rd ;

  //Constraints for the transaction variables:
  constraint wait_complete_c { wait_complete >= 0 ; wait_complete < 6;}
  constraint wait_complete_2_c { wait_complete dist {0:=90,1:=40,2:=25,3:=15,4:=10,5:=10};}
  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in dmem_macros.svh

  //*******************************************************************
  // Monitor macro used by dmem_monitor and dmem_monitor_bfm
  // This struct is defined in dmem_macros.svh
  `dmem_MONITOR_STRUCT
    dmem_monitor_s dmem_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a dmem_monitor_s
  // structure.  The function returns the handle to the dmem_monitor_struct.
  // This function is defined in dmem_macros.svh
  `dmem_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in dmem_macros.svh
  `dmem_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by dmem_driver and dmem_driver_bfm
  // to communicate initiator driven data to dmem_driver_bfm.
  // This struct is defined in dmem_macros.svh
  `dmem_INITIATOR_STRUCT
    dmem_initiator_s dmem_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a dmem_initiator_s
  // structure.  The function returns the handle to the dmem_initiator_struct.
  // This function is defined in dmem_macros.svh
  `dmem_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in dmem_macros.svh
  `dmem_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by dmem_driver and dmem_driver_bfm
  // to communicate Responder driven data to dmem_driver_bfm.
  // This struct is defined in dmem_macros.svh
  `dmem_RESPONDER_STRUCT
    dmem_responder_s dmem_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a dmem_responder_s
  // structure.  The function returns the handle to the dmem_responder_struct.
  // This function is defined in dmem_macros.svh
  `dmem_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in dmem_macros.svh
  `dmem_FROM_RESPONDER_STRUCT_FUNCTION 
  // ****************************************************************************
  // FUNCTION : new()
  // This function is the standard SystemVerilog constructor.
  //
  function new( string name = "" );
    super.new( name );
  endfunction

  // ****************************************************************************
  // FUNCTION: convert2string()
  // This function converts all variables in this class to a single string for 
  // logfile reporting.
  //
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    // UVMF_CHANGE_ME : Customize format if desired.
    return $sformatf("complete_data:0x%x wait_complete:0x%x Data_dout:0x%x Data_din:0x%x Data_addr:0x%x Data_rd:0x%x ",complete_data,wait_complete,Data_dout,Data_din,Data_addr,Data_rd);
    // pragma uvmf custom convert2string end
  endfunction

  //*******************************************************************
  // FUNCTION: do_print()
  // This function is automatically called when the .print() function
  // is called on this class.
  //
  virtual function void do_print(uvm_printer printer);
    // pragma uvmf custom do_print begin
    // UVMF_CHANGE_ME : Current contents of do_print allows for the use of UVM 1.1d, 1.2 or P1800.2.
    // Update based on your own printing preference according to your preferred UVM version
    $display(convert2string());
    // pragma uvmf custom do_print end
  endfunction

  //*******************************************************************
  // FUNCTION: do_compare()
  // This function is automatically called when the .compare() function
  // is called on this class.
  //
  virtual function bit do_compare (uvm_object rhs, uvm_comparer comparer);
    dmem_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    dmem_transaction  RHS;
    assert($cast(RHS,rhs));
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.complete_data = RHS.complete_data;
    this.wait_complete = RHS.wait_complete;
    this.Data_dout = RHS.Data_dout;
    this.Data_din = RHS.Data_din;
    this.Data_addr = RHS.Data_addr;
    this.Data_rd = RHS.Data_rd;
    // pragma uvmf custom do_copy end
  endfunction

  // ****************************************************************************
  // FUNCTION: add_to_wave()
  // This function is used to display variables in this class in the waveform 
  // viewer.  The start_time and end_time variables must be set before this 
  // function is called.  If the start_time and end_time variables are not set
  // the transaction will be hidden at 0ns on the waveform display.
  // 
  virtual function void add_to_wave(int transaction_viewing_stream_h);
    `ifdef QUESTA
    if (transaction_view_h == 0) begin
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"dmem_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,complete_data,"complete_data");
    $add_attribute(transaction_view_h,wait_complete,"wait_complete");
    $add_attribute(transaction_view_h,Data_dout,"Data_dout");
    $add_attribute(transaction_view_h,Data_din,"Data_din");
    $add_attribute(transaction_view_h,Data_addr,"Data_addr");
    $add_attribute(transaction_view_h,Data_rd,"Data_rd");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

