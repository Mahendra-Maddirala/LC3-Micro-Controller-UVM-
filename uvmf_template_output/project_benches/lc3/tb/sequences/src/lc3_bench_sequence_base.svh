//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// Description: This file contains the top level and utility sequences
//     used by test_top. It can be extended to create derivative top
//     level sequences.
//
//----------------------------------------------------------------------
//
//----------------------------------------------------------------------
//


typedef lc3_env_configuration  lc3_env_configuration_t;

class lc3_bench_sequence_base extends uvmf_sequence_base #(uvm_sequence_item);

  `uvm_object_utils( lc3_bench_sequence_base );

  // pragma uvmf custom sequences begin

typedef lc3_env_sequence_base #(
        .CONFIG_T(lc3_env_configuration_t)
        )
        lc3_env_sequence_base_t;
rand lc3_env_sequence_base_t lc3_env_seq;



  // UVMF_CHANGE_ME : Instantiate, construct, and start sequences as needed to create stimulus scenarios.
  // Instantiate sequences here
  typedef imem_responder_sequence  imem_in_responder_seq_t;
  imem_in_responder_seq_t imem_in_responder_seq;
  typedef dmem_responder_sequence  dmem_in_responder_seq_t;
  dmem_in_responder_seq_t dmem_in_responder_seq;
  // pragma uvmf custom sequences end

  // Sequencer handles for each active interface in the environment
  typedef imem_transaction  imem_in_transaction_t;
  uvm_sequencer #(imem_in_transaction_t)  imem_in_sequencer; 
  typedef dmem_transaction  dmem_in_transaction_t;
  uvm_sequencer #(dmem_in_transaction_t)  dmem_in_sequencer; 


  // Top level environment configuration handle
  lc3_env_configuration_t top_configuration;

  // Configuration handles to access interface BFM's
  decode_in_configuration  decode_env_dec_in_config;
  decode_out_configuration  decode_env_dec_out_config;
  execute_in_configuration  execute_env_execute_in_agent_config;
  execute_out_configuration  execute_env_execute_out_agent_config;
  memaccess_in_configuration  memaccess_env_agent_in_config;
  memaccess_out_configuration  memaccess_env_agent_out_config;
  writeback_in_configuration  writeback_env_wb_in_config;
  writeback_out_configuration  writeback_env_wb_out_config;
  imem_configuration  imem_in_config;
  dmem_configuration  dmem_in_config;
  // Local handle to register model for convenience
  lc3_reg_model reg_model;
  uvm_status_e status;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

  // ****************************************************************************
  function new( string name = "" );
    super.new( name );
    // Retrieve the configuration handles from the uvm_config_db

    // Retrieve top level configuration handle
    if ( !uvm_config_db#(lc3_env_configuration_t)::get(null,UVMF_CONFIGURATIONS, "TOP_ENV_CONFIG",top_configuration) ) begin
      `uvm_info("CFG", "*** FATAL *** uvm_config_db::get can not find TOP_ENV_CONFIG.  Are you using an older UVMF release than what was used to generate this bench?",UVM_NONE);
      `uvm_fatal("CFG", "uvm_config_db#(lc3_env_configuration_t)::get cannot find resource TOP_ENV_CONFIG");
    end

    // Retrieve config handles for all agents
    if( !uvm_config_db #( decode_in_configuration )::get( null , UVMF_CONFIGURATIONS , decode_env_dec_in_BFM , decode_env_dec_in_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( decode_in_configuration )::get cannot find resource decode_env_dec_in_BFM" )
    if( !uvm_config_db #( decode_out_configuration )::get( null , UVMF_CONFIGURATIONS , decode_env_dec_out_BFM , decode_env_dec_out_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( decode_out_configuration )::get cannot find resource decode_env_dec_out_BFM" )
    if( !uvm_config_db #( execute_in_configuration )::get( null , UVMF_CONFIGURATIONS , execute_env_execute_in_agent_BFM , execute_env_execute_in_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( execute_in_configuration )::get cannot find resource execute_env_execute_in_agent_BFM" )
    if( !uvm_config_db #( execute_out_configuration )::get( null , UVMF_CONFIGURATIONS , execute_env_execute_out_agent_BFM , execute_env_execute_out_agent_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( execute_out_configuration )::get cannot find resource execute_env_execute_out_agent_BFM" )
    if( !uvm_config_db #( memaccess_in_configuration )::get( null , UVMF_CONFIGURATIONS , memaccess_env_agent_in_BFM , memaccess_env_agent_in_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( memaccess_in_configuration )::get cannot find resource memaccess_env_agent_in_BFM" )
    if( !uvm_config_db #( memaccess_out_configuration )::get( null , UVMF_CONFIGURATIONS , memaccess_env_agent_out_BFM , memaccess_env_agent_out_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( memaccess_out_configuration )::get cannot find resource memaccess_env_agent_out_BFM" )
    if( !uvm_config_db #( writeback_in_configuration )::get( null , UVMF_CONFIGURATIONS , writeback_env_wb_in_BFM , writeback_env_wb_in_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( writeback_in_configuration )::get cannot find resource writeback_env_wb_in_BFM" )
    if( !uvm_config_db #( writeback_out_configuration )::get( null , UVMF_CONFIGURATIONS , writeback_env_wb_out_BFM , writeback_env_wb_out_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( writeback_out_configuration )::get cannot find resource writeback_env_wb_out_BFM" )
    if( !uvm_config_db #( imem_configuration )::get( null , UVMF_CONFIGURATIONS , imem_in_BFM , imem_in_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( imem_configuration )::get cannot find resource imem_in_BFM" )
    if( !uvm_config_db #( dmem_configuration )::get( null , UVMF_CONFIGURATIONS , dmem_in_BFM , dmem_in_config ) ) 
      `uvm_fatal("CFG" , "uvm_config_db #( dmem_configuration )::get cannot find resource dmem_in_BFM" )

    // Assign the sequencer handles from the handles within agent configurations
    imem_in_sequencer = imem_in_config.get_sequencer();
    dmem_in_sequencer = dmem_in_config.get_sequencer();

    reg_model = top_configuration.lc3_rm;


    // pragma uvmf custom new begin
    // pragma uvmf custom new end

  endfunction

  // ****************************************************************************
  virtual task body();
    // pragma uvmf custom body begin

    // Construct sequences here

    lc3_env_seq = lc3_env_sequence_base_t::type_id::create("lc3_env_seq");

    imem_in_responder_seq  = imem_in_responder_seq_t::type_id::create("imem_in_responder_seq");
    dmem_in_responder_seq  = dmem_in_responder_seq_t::type_id::create("dmem_in_responder_seq");
    fork
      decode_env_dec_in_config.wait_for_reset();
      decode_env_dec_out_config.wait_for_reset();
      execute_env_execute_in_agent_config.wait_for_reset();
      execute_env_execute_out_agent_config.wait_for_reset();
      memaccess_env_agent_in_config.wait_for_reset();
      memaccess_env_agent_out_config.wait_for_reset();
      writeback_env_wb_in_config.wait_for_reset();
      writeback_env_wb_out_config.wait_for_reset();
      imem_in_config.wait_for_reset();
      dmem_in_config.wait_for_reset();
    join
    reg_model.reset();
    // Start RESPONDER sequences here
    fork
      imem_in_responder_seq.start(imem_in_sequencer);
      dmem_in_responder_seq.start(dmem_in_sequencer);
    join_any

    //lc3_env_seq.start(top_configuration.vsqr);

    // UVMF_CHANGE_ME : Extend the simulation XXX number of clocks after 
    // the last sequence to allow for the last sequence item to flow 
    // through the design.
    fork
      decode_env_dec_in_config.wait_for_num_clocks(40);
      decode_env_dec_out_config.wait_for_num_clocks(40);
      execute_env_execute_in_agent_config.wait_for_num_clocks(40);
      execute_env_execute_out_agent_config.wait_for_num_clocks(40);
      memaccess_env_agent_in_config.wait_for_num_clocks(40);
      memaccess_env_agent_out_config.wait_for_num_clocks(40);
      writeback_env_wb_in_config.wait_for_num_clocks(40);
      writeback_env_wb_out_config.wait_for_num_clocks(40);
      imem_in_config.wait_for_num_clocks(40);
      dmem_in_config.wait_for_num_clocks(40);
    join

    // pragma uvmf custom body end
  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

