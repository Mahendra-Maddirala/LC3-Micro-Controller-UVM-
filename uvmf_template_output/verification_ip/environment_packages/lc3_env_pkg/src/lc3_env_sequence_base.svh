//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This file contains environment level sequences that will
//    be reused from block to top level simulations.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class lc3_env_sequence_base #( 
      type CONFIG_T
      ) extends uvmf_virtual_sequence_base #(.CONFIG_T(CONFIG_T));


  `uvm_object_param_utils( lc3_env_sequence_base #(
                           CONFIG_T
                           ) );

  // Handle to the environments register model
// This handle needs to be set before use.
  lc3_reg_model  reg_model;

// This lc3_env_sequence_base contains a handle to a lc3_env_configuration object 
// named configuration.  This configuration variable contains a handle to each 
// sequencer within each agent within this environment and any sub-environments.
// The configuration object handle is automatically assigned in the pre_body in the
// base class of this sequence.  The configuration handle is retrieved from the
// virtual sequencer that this sequence is started on.
// Available sequencer handles within the environment configuration:

  // Initiator agent sequencers in lc3_environment:

  // Responder agent sequencers in lc3_environment:
    // configuration.imem_in_config.sequencer
    // configuration.dmem_in_config.sequencer

  // Virtual sequencers in sub-environments located in sub-environment configuration
    // configuration.decode_env_config.vsqr
    // configuration.execute_env_config.vsqr
    // configuration.memaccess_env_config.vsqr
    // configuration.writeback_env_config.vsqr




typedef decode_env_sequence_base #(
        .CONFIG_T(decode_env_configuration)
        ) 
        decode_env_sequence_base_t;
rand decode_env_sequence_base_t decode_env_seq;

typedef execute_env_sequence_base #(
        .CONFIG_T(execute_env_configuration)
        ) 
        execute_env_sequence_base_t;
rand execute_env_sequence_base_t execute_env_seq;

typedef memaccess_env_sequence_base #(
        .CONFIG_T(memaccess_env_configuration)
        ) 
        memaccess_env_sequence_base_t;
rand memaccess_env_sequence_base_t memaccess_env_seq;

typedef writeback_env_sequence_base #(
        .CONFIG_T(writeback_env_configuration)
        ) 
        writeback_env_sequence_base_t;
rand writeback_env_sequence_base_t writeback_env_seq;



  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
  
  function new(string name = "" );
    super.new(name);

    decode_env_seq = decode_env_sequence_base_t::type_id::create("decode_env_seq");
    execute_env_seq = execute_env_sequence_base_t::type_id::create("execute_env_seq");
    memaccess_env_seq = memaccess_env_sequence_base_t::type_id::create("memaccess_env_seq");
    writeback_env_seq = writeback_env_sequence_base_t::type_id::create("writeback_env_seq");

  endfunction

  virtual task body();


    decode_env_seq.start(configuration.decode_env_config.vsqr);
    execute_env_seq.start(configuration.execute_env_config.vsqr);
    memaccess_env_seq.start(configuration.memaccess_env_config.vsqr);
    writeback_env_seq.start(configuration.writeback_env_config.vsqr);

  endtask

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

