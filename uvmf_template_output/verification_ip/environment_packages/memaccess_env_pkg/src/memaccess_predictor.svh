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
//   from_in_agent receives transactions of type  memaccess_in_transaction
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//  pred_to_scrbd broadcasts transactions of type memaccess_out_transaction
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class memaccess_predictor #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( memaccess_predictor #(
                              CONFIG_T,
                              BASE_T
                              ))


  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_from_in_agent #(memaccess_in_transaction, memaccess_predictor #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) from_in_agent;

  
  // Instantiate the analysis ports
  uvm_analysis_port #(memaccess_out_transaction) pred_to_scrbd;


  // Transaction variable for predicted values to be sent out pred_to_scrbd
  // Once a transaction is sent through an analysis_port, another transaction should
  // be constructed for the next predicted transaction. 
  typedef memaccess_out_transaction pred_to_scrbd_output_transaction_t;
  pred_to_scrbd_output_transaction_t pred_to_scrbd_output_transaction;
  // Code for sending output transaction out through pred_to_scrbd
  // pred_to_scrbd.write(pred_to_scrbd_output_transaction);

  // Define transaction handles for debug visibility 
  memaccess_in_transaction from_in_agent_debug;


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

    from_in_agent = new("from_in_agent", this);
    pred_to_scrbd =new("pred_to_scrbd", this );
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // FUNCTION: write_from_in_agent
  // Transactions received through from_in_agent initiate the execution of this function.
  // This function performs prediction of DUT output values based on DUT input, configuration and state
  virtual function void write_from_in_agent(memaccess_in_transaction t);
    // pragma uvmf custom from_in_agent_predictor begin
    bit memaccess_pred;
    from_in_agent_debug = t;
    `uvm_info("PRED", "Transaction Received through from_in_agent", UVM_MEDIUM)
    `uvm_info("PRED", {"            Data: ",t.convert2string()}, UVM_FULL)
    // Construct one of each output transaction type.
    pred_to_scrbd_output_transaction = pred_to_scrbd_output_transaction_t::type_id::create("pred_to_scrbd_output_transaction");
    //  UVMF_CHANGE_ME: Implement predictor model here.  
    memaccess_pred = mem_access_model(t.M_Data, t.M_addr, t.M_Control, t.mem_state, t.DMem_dout, pred_to_scrbd_output_transaction.DMem_addr, pred_to_scrbd_output_transaction.DMem_din, pred_to_scrbd_output_transaction.memout, pred_to_scrbd_output_transaction.DMem_rd);
 
    // Code for sending output transaction out through pred_to_scrbd
    // Please note that each broadcasted transaction should be a different object than previously 
    // broadcasted transactions.  Creation of a different object is done by constructing the transaction 
    // using either new() or create().  Broadcasting a transaction object more than once to either the 
    // same subscriber or multiple subscribers will result in unexpected and incorrect behavior.
    pred_to_scrbd.write(pred_to_scrbd_output_transaction);
    // pragma uvmf custom from_in_agent_predictor end
  endfunction


endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

