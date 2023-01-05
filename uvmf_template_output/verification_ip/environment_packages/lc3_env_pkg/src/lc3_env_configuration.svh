//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: THis is the configuration for the lc3 environment.
//  it contains configuration classes for each agent.  It also contains
//  environment level configuration variables.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
class lc3_env_configuration 
extends uvmf_environment_configuration_base;

  `uvm_object_utils( lc3_env_configuration )


//Constraints for the configuration variables:

// Instantiate the register model
  lc3_reg_model  lc3_rm;

  covergroup lc3_configuration_cg;
    // pragma uvmf custom covergroup begin
    option.auto_bin_max=1024;
    // pragma uvmf custom covergroup end
  endgroup

typedef decode_env_configuration decode_env_config_t;
rand decode_env_config_t decode_env_config;

typedef execute_env_configuration execute_env_config_t;
rand execute_env_config_t execute_env_config;

typedef memaccess_env_configuration memaccess_env_config_t;
rand memaccess_env_config_t memaccess_env_config;

typedef writeback_env_configuration writeback_env_config_t;
rand writeback_env_config_t writeback_env_config;


    typedef imem_configuration imem_in_config_t;
    rand imem_in_config_t imem_in_config;

    typedef dmem_configuration dmem_in_config_t;
    rand dmem_in_config_t dmem_in_config;


    string                decode_env_interface_names[];
    uvmf_active_passive_t decode_env_interface_activity[];
    string                execute_env_interface_names[];
    uvmf_active_passive_t execute_env_interface_activity[];
    string                memaccess_env_interface_names[];
    uvmf_active_passive_t memaccess_env_interface_activity[];
    string                writeback_env_interface_names[];
    uvmf_active_passive_t writeback_env_interface_activity[];


  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(lc3_env_configuration)) lc3_vsqr_t;
  lc3_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
// This function constructs the configuration object for each agent in the environment.
//
  function new( string name = "" );
    super.new( name );

   decode_env_config = decode_env_config_t::type_id::create("decode_env_config");
   execute_env_config = execute_env_config_t::type_id::create("execute_env_config");
   memaccess_env_config = memaccess_env_config_t::type_id::create("memaccess_env_config");
   writeback_env_config = writeback_env_config_t::type_id::create("writeback_env_config");

    imem_in_config = imem_in_config_t::type_id::create("imem_in_config");
    dmem_in_config = dmem_in_config_t::type_id::create("dmem_in_config");


    lc3_configuration_cg=new;

  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

// ****************************************************************************
// FUNCTION : set_vsqr()
// This function is used to assign the vsqr handle.
  virtual function void set_vsqr( lc3_vsqr_t vsqr);
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
     
     "\n", imem_in_config.convert2string,
     "\n", dmem_in_config.convert2string,
     "\n", decode_env_config.convert2string,
     "\n", execute_env_config.convert2string,
     "\n", memaccess_env_config.convert2string,
     "\n", writeback_env_config.convert2string

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

  // Interface initialization for sub-environments
    decode_env_interface_names    = new[2];
    decode_env_interface_activity = new[2];

    decode_env_interface_names     = interface_names[0:1];
    decode_env_interface_activity  = interface_activity[0:1];
    execute_env_interface_names    = new[2];
    execute_env_interface_activity = new[2];

    execute_env_interface_names     = interface_names[2:3];
    execute_env_interface_activity  = interface_activity[2:3];
    memaccess_env_interface_names    = new[2];
    memaccess_env_interface_activity = new[2];

    memaccess_env_interface_names     = interface_names[4:5];
    memaccess_env_interface_activity  = interface_activity[4:5];
    writeback_env_interface_names    = new[2];
    writeback_env_interface_activity = new[2];

    writeback_env_interface_names     = interface_names[6:7];
    writeback_env_interface_activity  = interface_activity[6:7];


  // Interface initialization for local agents
     imem_in_config.initialize( interface_activity[8], {environment_path,".imem_in"}, interface_names[8]);
     imem_in_config.initiator_responder = RESPONDER;
     // imem_in_config.has_coverage = 1;
     dmem_in_config.initialize( interface_activity[9], {environment_path,".dmem_in"}, interface_names[9]);
     dmem_in_config.initiator_responder = RESPONDER;
     // dmem_in_config.has_coverage = 1;

    // pragma uvmf custom reg_model_config_initialize begin
    // Register model creation and configuation
    if (register_model == null) begin
      lc3_rm = lc3_reg_model::type_id::create("lc3_rm");
      lc3_rm.build();
      lc3_rm.lock_model();
      enable_reg_adaptation = 0;
      enable_reg_prediction = 0;
    end else begin
      $cast(lc3_rm,register_model);
      enable_reg_prediction = 0;
    end
    // pragma uvmf custom reg_model_config_initialize end

     decode_env_config.initialize( sim_level, {environment_path,".decode_env"}, decode_env_interface_names, null,   decode_env_interface_activity);
     execute_env_config.initialize( sim_level, {environment_path,".execute_env"}, execute_env_interface_names, null,   execute_env_interface_activity);
     memaccess_env_config.initialize( sim_level, {environment_path,".memaccess_env"}, memaccess_env_interface_names, null,   memaccess_env_interface_activity);
     writeback_env_config.initialize( sim_level, {environment_path,".writeback_env"}, writeback_env_interface_names, null,   writeback_env_interface_activity);



  // pragma uvmf custom initialize begin
  // pragma uvmf custom initialize end

  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

