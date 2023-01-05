//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//
// DESCRIPTION: This analysis component contains analysis_exports for receiving
//   data and analysis_ports for sending data.
// 
//   This analysis component has the following analysis_exports that receive the 
//   listed transaction type.
//   
//   wb_in_agent_ae receives transactions of type  writeback_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  wb_sb_ap broadcasts transactions of type writeback_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class writeback_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( writeback_predictor #(
                              CONFIG_T,
                              BASE_T
                              ))


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_wb_in_agent_ae #(writeback_in_transaction, writeback_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) wb_in_agent_ae;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(writeback_out_transaction) wb_sb_ap;


  // Transaction variable for predicted values to be sent out wb_sb_ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef writeback_out_transaction wb_sb_ap_output_transaction_t;
  wb_sb_ap_output_transaction_t wb_sb_ap_output_transaction,wb_sb_ap_prev_output_transaction;;
  // Code for sending output transaction out through wb_sb_ap
  // wb_sb_ap.write(wb_sb_ap_output_transaction);

  // Define transaction handles for debug visibility 
  writeback_in_transaction wb_in_agent_ae_debug;


  // pragma uvmf custom class_item_additional begin
  int count = 0;
  bit [2:0]saved_psr = 3'b0;
  // pragma uvmf custom class_item_additional end

  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
     wb_sb_ap_prev_output_transaction = wb_sb_ap_output_transaction_t::type_id::create("wb_sb_ap_prev_output_transaction");
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);

    wb_in_agent_ae = new("wb_in_agent_ae", this);
    wb_sb_ap =new("wb_sb_ap", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_wb_in_agent_ae
  // Transactions received through wb_in_agent_ae initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_wb_in_agent_ae(writeback_in_transaction t);
    // pragma uvmf custom wb_in_agent_ae_predictor begin
    bit writeback_pred;
    wb_in_agent_ae_debug = t;
    `uvm_info("PRED", "Transaction Received through wb_in_agent_ae", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    wb_sb_ap_output_transaction = wb_sb_ap_output_transaction_t::type_id::create("wb_sb_ap_output_transaction");
    //if(count == 0) wb_sb_ap.write(wb_sb_ap_output_transaction); 
    writeback_pred = lc3_prediction_pkg::writeback_model (
                                                t.aluout,
                                                t.W_control_in,
                                                t.npc,
                                                t.pcout,
                                                t.memout,
                                                t.enable_writeback,
                                                t.sr1,
                                                t.sr2,
                                                t.dr,
                                                wb_sb_ap_output_transaction.VSR1,
                                                wb_sb_ap_output_transaction.VSR2,
                                                saved_psr
                                              ); 
    wb_sb_ap_output_transaction.psr = wb_sb_ap_prev_output_transaction.psr ;
    wb_sb_ap.write(wb_sb_ap_output_transaction);
    //count = count + 1;
    wb_sb_ap_prev_output_transaction.psr          = saved_psr ;
    // pragma uvmf custom wb_in_agent_ae_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

