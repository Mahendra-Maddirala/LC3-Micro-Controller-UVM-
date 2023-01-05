//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This class defines the variables required for an decode_out
//    transaction.  Class variables to be displayed in waveform transaction
//    viewing are added to the transaction viewing stream in the add_to_wave
//    function.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class decode_out_transaction  extends uvmf_transaction_base;

  `uvm_object_utils( decode_out_transaction )

  ir_t IR ;
  e_ctrl_t E_control ;
  npc_t npc_out ;
  m_ctrl_t M_control ;
  w_ctrl_t W_control ;

  //Constraints for the transaction variables:

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  //*******************************************************************
  //*******************************************************************
  // Macros that define structs and associated functions are
  // located in decode_out_macros.svh

  //*******************************************************************
  // Monitor macro used by decode_out_monitor and decode_out_monitor_bfm
  // This struct is defined in decode_out_macros.svh
  `decode_out_MONITOR_STRUCT
    decode_out_monitor_s decode_out_monitor_struct;
  //*******************************************************************
  // FUNCTION: to_monitor_struct()
  // This function packs transaction variables into a decode_out_monitor_s
  // structure.  The function returns the handle to the decode_out_monitor_struct.
  // This function is defined in decode_out_macros.svh
  `decode_out_TO_MONITOR_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_monitor_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in decode_out_macros.svh
  `decode_out_FROM_MONITOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Initiator macro used by decode_out_driver and decode_out_driver_bfm
  // to communicate initiator driven data to decode_out_driver_bfm.
  // This struct is defined in decode_out_macros.svh
  `decode_out_INITIATOR_STRUCT
    decode_out_initiator_s decode_out_initiator_struct;
  //*******************************************************************
  // FUNCTION: to_initiator_struct()
  // This function packs transaction variables into a decode_out_initiator_s
  // structure.  The function returns the handle to the decode_out_initiator_struct.
  // This function is defined in decode_out_macros.svh
  `decode_out_TO_INITIATOR_STRUCT_FUNCTION  
  //*******************************************************************
  // FUNCTION: from_initiator_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in decode_out_macros.svh
  `decode_out_FROM_INITIATOR_STRUCT_FUNCTION 

  //*******************************************************************
  // Responder macro used by decode_out_driver and decode_out_driver_bfm
  // to communicate Responder driven data to decode_out_driver_bfm.
  // This struct is defined in decode_out_macros.svh
  `decode_out_RESPONDER_STRUCT
    decode_out_responder_s decode_out_responder_struct;
  //*******************************************************************
  // FUNCTION: to_responder_struct()
  // This function packs transaction variables into a decode_out_responder_s
  // structure.  The function returns the handle to the decode_out_responder_struct.
  // This function is defined in decode_out_macros.svh
  `decode_out_TO_RESPONDER_STRUCT_FUNCTION 
  //*******************************************************************
  // FUNCTION: from_responder_struct()
  // This function unpacks the struct provided as an argument into transaction 
  // variables of this class.
  // This function is defined in decode_out_macros.svh
  `decode_out_FROM_RESPONDER_STRUCT_FUNCTION 
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
    return $sformatf("IR:0x%x E_control:0x%x npc_out:0x%x M_control:0x%x W_control:0x%x ",IR,E_control,npc_out,M_control,W_control);
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
    decode_out_transaction  RHS;
    if (!$cast(RHS,rhs)) return 0;
    // pragma uvmf custom do_compare begin
    // UVMF_CHANGE_ME : Eliminate comparison of variables not to be used for compare
    return (super.do_compare(rhs,comparer)
            &&(this.IR == RHS.IR)
            &&(this.E_control == RHS.E_control)
            &&(this.npc_out == RHS.npc_out)
            &&(this.M_control == RHS.M_control)
            &&(this.W_control == RHS.W_control)
            );
    // pragma uvmf custom do_compare end
  endfunction

  //*******************************************************************
  // FUNCTION: do_copy()
  // This function is automatically called when the .copy() function
  // is called on this class.
  //
  virtual function void do_copy (uvm_object rhs);
    decode_out_transaction  RHS;
    assert($cast(RHS,rhs));
    // pragma uvmf custom do_copy begin
    super.do_copy(rhs);
    this.IR = RHS.IR;
    this.E_control = RHS.E_control;
    this.npc_out = RHS.npc_out;
    this.M_control = RHS.M_control;
    this.W_control = RHS.W_control;
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
      transaction_view_h = $begin_transaction(transaction_viewing_stream_h,"decode_out_transaction",start_time);
    end
    super.add_to_wave(transaction_view_h);
    // pragma uvmf custom add_to_wave begin
    // UVMF_CHANGE_ME : Color can be applied to transaction entries based on content, example below
    // case()
    //   1 : $add_color(transaction_view_h,"red");
    //   default : $add_color(transaction_view_h,"grey");
    // endcase
    // UVMF_CHANGE_ME : Eliminate transaction variables not wanted in transaction viewing in the waveform viewer
    $add_attribute(transaction_view_h,IR,"IR");
    $add_attribute(transaction_view_h,E_control,"E_control");
    $add_attribute(transaction_view_h,npc_out,"npc_out");
    $add_attribute(transaction_view_h,M_control,"M_control");
    $add_attribute(transaction_view_h,W_control,"W_control");
    // pragma uvmf custom add_to_wave end
    $end_transaction(transaction_view_h,end_time);
    $free_transaction(transaction_view_h);
    `endif // QUESTA
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

