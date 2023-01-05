//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// PACKAGE: This file defines all of the files contained in the
//    environment package that will run on the host simulator.
//
// CONTAINS:
//     - <lc3_configuration.svh>
//     - <lc3_environment.svh>
//     - <lc3_env_sequence_base.svh>
//     - <imem_coverage.svh>
//     - <dmem_coverage.svh>
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
package lc3_env_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import uvmf_base_pkg::*;
  import imem_pkg::*;
  import imem_pkg_hdl::*;
  import dmem_pkg::*;
  import dmem_pkg_hdl::*;
  import lc3_reg_pkg::*;
  import decode_env_pkg::*;
  import execute_env_pkg::*;
  import memaccess_env_pkg::*;
  import writeback_env_pkg::*;
 
  `uvm_analysis_imp_decl(_imem_cov_ae)
  `uvm_analysis_imp_decl(_dmem_cov_ae)

  // pragma uvmf custom package_imports_additional begin
  // pragma uvmf custom package_imports_additional end

  // Parameters defined as HVL parameters

  `include "src/lc3_env_typedefs.svh"
  `include "src/lc3_env_configuration.svh"
  `include "src/imem_coverage.svh"
  `include "src/dmem_coverage.svh"
  `include "src/lc3_environment.svh"
  `include "src/lc3_env_sequence_base.svh"

  // pragma uvmf custom package_item_additional begin
  // UVMF_CHANGE_ME : When adding new environment level sequences to the src directory
  //    be sure to add the sequence file here so that it will be
  //    compiled as part of the environment package.  Be sure to place
  //    the new sequence after any base sequence of the new sequence.
  // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

