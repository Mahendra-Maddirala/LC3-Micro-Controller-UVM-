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
//   dec_in_agent_ae receives transactions of type  decode_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  dec_sb_ap broadcasts transactions of type decode_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class decode_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( decode_predictor #(
                              CONFIG_T,
                              BASE_T
                              ))


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_dec_in_agent_ae #(decode_in_transaction, decode_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) dec_in_agent_ae;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(decode_out_transaction) dec_sb_ap;


  // Transaction variable for predicted values to be sent out dec_sb_ap
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef decode_out_transaction dec_sb_ap_output_transaction_t;
  dec_sb_ap_output_transaction_t dec_sb_ap_output_transaction;
  // Code for sending output transaction out through dec_sb_ap
  // dec_sb_ap.write(dec_sb_ap_output_transaction);

  // Define transaction handles for debug visibility 
  decode_in_transaction dec_in_agent_ae_debug;


  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);

    dec_in_agent_ae = new("dec_in_agent_ae", this);
    dec_sb_ap =new("dec_sb_ap", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_dec_in_agent_ae
  // Transactions received through dec_in_agent_ae initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_dec_in_agent_ae(decode_in_transaction t);
    // pragma uvmf custom dec_in_agent_ae_predictor begin
    bit decode_pred;
    dec_in_agent_ae_debug = t;
    `uvm_info("PRED", "Transaction Received through dec_in_agent_ae", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    dec_sb_ap_output_transaction = dec_sb_ap_output_transaction_t::type_id::create("dec_sb_ap_output_transaction");
    //  UVMF_CHANGE_ME: Implement predictor model here.  
    decode_pred = lc3_prediction_pkg::decode_model(t.instruction,t.npc_in,dec_sb_ap_output_transaction.IR,dec_sb_ap_output_transaction.npc_out,dec_sb_ap_output_transaction.E_control,dec_sb_ap_output_transaction.W_control,dec_sb_ap_output_transaction.M_control);
 
    // Code for sending output transaction out through dec_sb_ap
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    dec_sb_ap.write(dec_sb_ap_output_transaction);
    // pragma uvmf custom dec_in_agent_ae_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

