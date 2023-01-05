//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// PACKAGE: This file defines all of the files contained in the
//    interface package that will run on the host simulator.
//
// CONTAINS:
//    - <imem_typedefs_hdl>
//    - <imem_typedefs.svh>
//    - <imem_transaction.svh>

//    - <imem_configuration.svh>
//    - <imem_driver.svh>
//    - <imem_monitor.svh>

//    - <imem_transaction_coverage.svh>
//    - <imem_sequence_base.svh>
//    - <imem_random_sequence.svh>

//    - <imem_responder_sequence.svh>
//    - <imem2reg_adapter.svh>
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
package imem_pkg;
  
   import uvm_pkg::*;
   import uvmf_base_pkg_hdl::*;
   import uvmf_base_pkg::*;
   import imem_pkg_hdl::*;

   `include "uvm_macros.svh"

   // pragma uvmf custom package_imports_additional begin 
   // pragma uvmf custom package_imports_additional end
   `include "src/imem_macros.svh"

   export imem_pkg_hdl::*;
   
 

   // Parameters defined as HVL parameters

   `include "src/imem_typedefs.svh"
   `include "src/imem_transaction.svh"

   `include "src/imem_configuration.svh"
   `include "src/imem_driver.svh"
   `include "src/imem_monitor.svh"

   `include "src/imem_transaction_coverage.svh"
   `include "src/imem_sequence_base.svh"
   `include "src/imem_random_sequence.svh"

   `include "src/imem_responder_sequence.svh"
   `include "src/imem2reg_adapter.svh"

   `include "src/imem_agent.svh"

   // pragma uvmf custom package_item_additional begin
   `include "src/imem_alu_responder_sequence.svh"
   `include "src/imem_mem_responder_sequence.svh"
   `include "src/imem_ctrl_switch_responder_sequence.svh"
   `include "src/imem_raw_responder_sequence.svh"
   `include "src/imem_waw_responder_sequence.svh"
   `include "src/imem_war_responder_sequence.svh"
   `include "src/imem_misc_responder_sequence.svh"
   `include "src/imem_bug_responder_sequence.svh"
   // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

