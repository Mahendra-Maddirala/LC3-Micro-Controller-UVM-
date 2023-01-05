//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//                                          
// DESCRIPTION: This environment contains all agents, predictors and
// scoreboards required for the block level design.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class writeback_environment  extends uvmf_environment_base #(
    .CONFIG_T( writeback_env_configuration 
  ));
  `uvm_component_utils( writeback_environment )





  typedef writeback_in_agent  wb_in_t;
  wb_in_t wb_in;

  typedef writeback_out_agent  wb_out_t;
  wb_out_t wb_out;




  typedef writeback_predictor #(
                .CONFIG_T(CONFIG_T)
                ) wb_pred_t;
  wb_pred_t wb_pred;

  typedef uvmf_in_order_scoreboard #(.T(writeback_out_transaction))  wb_sb_t;
  wb_sb_t wb_sb;



  typedef uvmf_virtual_sequencer_base #(.CONFIG_T(writeback_env_configuration)) writeback_vsqr_t;
  writeback_vsqr_t vsqr;

  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end
 
// ****************************************************************************
// FUNCTION : new()
// This function is the standard SystemVerilog constructor.
//
  function new( string name = "", uvm_component parent = null );
    super.new( name, parent );
  endfunction

// ****************************************************************************
// FUNCTION: build_phase()
// This function builds all components within this environment.
//
  virtual function void build_phase(uvm_phase phase);
// pragma uvmf custom build_phase_pre_super begin
// pragma uvmf custom build_phase_pre_super end
    super.build_phase(phase);
    wb_in = wb_in_t::type_id::create("wb_in",this);
    wb_in.set_config(configuration.wb_in_config);
    wb_out = wb_out_t::type_id::create("wb_out",this);
    wb_out.set_config(configuration.wb_out_config);
    wb_pred = wb_pred_t::type_id::create("wb_pred",this);
    wb_pred.configuration = configuration;
    wb_sb = wb_sb_t::type_id::create("wb_sb",this);

    vsqr = writeback_vsqr_t::type_id::create("vsqr", this);
    vsqr.set_config(configuration);
    configuration.set_vsqr(vsqr);

    // pragma uvmf custom build_phase begin
    // pragma uvmf custom build_phase end
  endfunction

// ****************************************************************************
// FUNCTION: connect_phase()
// This function makes all connections within this environment.  Connections
// typically inclue agent to predictor, predictor to scoreboard and scoreboard
// to agent.
//
  virtual function void connect_phase(uvm_phase phase);
// pragma uvmf custom connect_phase_pre_super begin
// pragma uvmf custom connect_phase_pre_super end
    super.connect_phase(phase);
    wb_in.monitored_ap.connect(wb_pred.wb_in_agent_ae);
    wb_pred.wb_sb_ap.connect(wb_sb.expected_analysis_export);
    wb_out.monitored_ap.connect(wb_sb.actual_analysis_export);
    // pragma uvmf custom reg_model_connect_phase begin
    // pragma uvmf custom reg_model_connect_phase end
  endfunction

// ****************************************************************************
// FUNCTION: end_of_simulation_phase()
// This function is executed just prior to executing run_phase.  This function
// was added to the environment to sample environment configuration settings
// just before the simulation exits time 0.  The configuration structure is 
// randomized in the build phase before the environment structure is constructed.
// Configuration variables can be customized after randomization in the build_phase
// of the extended test.
// If a sequence modifies values in the configuration structure then the sequence is
// responsible for sampling the covergroup in the configuration if required.
//
  virtual function void start_of_simulation_phase(uvm_phase phase);
     configuration.writeback_configuration_cg.sample();
  endfunction

endclass

// pragma uvmf custom external begin
// pragma uvmf custom external end

