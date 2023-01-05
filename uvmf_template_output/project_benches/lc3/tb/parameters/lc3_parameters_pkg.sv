//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// DESCRIPTION: This package contains test level parameters
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//


package lc3_parameters_pkg;

  import uvmf_base_pkg_hdl::*;

  // pragma uvmf custom package_imports_additional begin 
  // pragma uvmf custom package_imports_additional end


  // These parameters are used to uniquely identify each interface.  The monitor_bfm and
  // driver_bfm are placed into and retrieved from the uvm_config_db using these string 
  // names as the field_name. The parameter is also used to enable transaction viewing 
  // from the command line for selected interfaces using the UVM command line processing.
  parameter string decode_env_dec_in_BFM  = "decode_env_dec_in_BFM"; /* [0] */
  parameter string decode_env_dec_out_BFM  = "decode_env_dec_out_BFM"; /* [1] */
  parameter string execute_env_execute_in_agent_BFM  = "execute_env_execute_in_agent_BFM"; /* [2] */
  parameter string execute_env_execute_out_agent_BFM  = "execute_env_execute_out_agent_BFM"; /* [3] */
  parameter string memaccess_env_agent_in_BFM  = "memaccess_env_agent_in_BFM"; /* [4] */
  parameter string memaccess_env_agent_out_BFM  = "memaccess_env_agent_out_BFM"; /* [5] */
  parameter string writeback_env_wb_in_BFM  = "writeback_env_wb_in_BFM"; /* [6] */
  parameter string writeback_env_wb_out_BFM  = "writeback_env_wb_out_BFM"; /* [7] */
  parameter string imem_in_BFM  = "imem_in_BFM"; /* [8] */
  parameter string dmem_in_BFM  = "dmem_in_BFM"; /* [9] */

  // pragma uvmf custom package_item_additional begin
  // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

