//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: THis is the configuration for the writeback environment.
//  it contains configuration classes for each agent.  It also contains
//  environment level configuration variables.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class writeback_env_configuration 
extends uvmf_environment_configuration_base;

  `uvm_object_utils( writeback_env_configuration )


//Constraints for the configuration variables:


  covergroup writeback_configuration_cg;
    // pragma uvmf custom covergroup begin
    option.auto_bin_max=1024;
    // pragma uvmf custom covergroup end
  endgroup


    typedef writeback_in_configuration wb_in_config_t;
    rand wb_in_config_t wb_in_config;

    typedef writeback_out_configuration wb_out_config_t;
    rand wb_out_config_t wb_out_config;




  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(writeback_env_configuration)) writeback_vsqr_t;
  writeback_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
// This function constructs the configuration object for each agent in the environment.
//
  function new( string name = "" );
    super.new( name );


    wb_in_config = wb_in_config_t::type_id::create("wb_in_config");
    wb_out_config = wb_out_config_t::type_id::create("wb_out_config");


    writeback_configuration_cg=new;

  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

// ****************************************************************************
// FUNCTION : set_vsqr()
// This function is used to assign the vsqr handle.
  virtual function void set_vsqr( writeback_vsqr_t vsqr);
     this.vsqr = vsqr;
  endfunction : set_vsqr

// ****************************************************************************
// FUNCTION: post_randomize()
// This function is automatically called after the randomize() function 
// is executed.
//
  function void post_randomize();
    super.post_randomize();
    // pragma uvmf custom post_randomize begin
    // pragma uvmf custom post_randomize end
  endfunction
  
// ****************************************************************************
// FUNCTION: convert2string()
// This function converts all variables in this class to a single string for
// logfile reporting. This function concatenates the convert2string result for
// each agent configuration in this configuration class.
//
  virtual function string convert2string();
    // pragma uvmf custom convert2string begin
    return {
     
     "\n", wb_in_config.convert2string,
     "\n", wb_out_config.convert2string


       };
    // pragma uvmf custom convert2string end
  endfunction
// ****************************************************************************
// FUNCTION: initialize();
// This function configures each interface agents configuration class.  The 
// sim level determines the active/passive state of the agent.  The environment_path
// identifies the hierarchy down to and including the instantiation name of the
// environment for this configuration class.  Each instance of the environment 
// has its own configuration class.  The string interface names are used by 
// the agent configurations to identify the virtual interface handle to pull from
// the uvm_config_db.  
//
  function void initialize(uvmf_sim_level_t sim_level, 
                                      string environment_path,
                                      string interface_names[],
                                      uvm_reg_block register_model = null,
                                      uvmf_active_passive_t interface_activity[] = {}
                                     );

    super.initialize(sim_level, environment_path, interface_names, register_model, interface_activity);



  // Interface initialization for local agents
     wb_in_config.initialize( interface_activity[0], {environment_path,".wb_in"}, interface_names[0]);
     wb_in_config.initiator_responder = INITIATOR;
     // wb_in_config.has_coverage = 1;
     wb_out_config.initialize( interface_activity[1], {environment_path,".wb_out"}, interface_names[1]);
     wb_out_config.initiator_responder = INITIATOR;
     // wb_out_config.has_coverage = 1;


  endfunction


  // pragma uvmf custom initialize begin
  function void send_last_trans_again();
        wb_out_config.send_last_trans_again();
  endfunction
  // pragma uvmf custom initialize end


endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

