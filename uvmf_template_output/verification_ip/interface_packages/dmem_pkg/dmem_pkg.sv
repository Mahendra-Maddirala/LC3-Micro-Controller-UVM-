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
//    - <dmem_typedefs_hdl>
//    - <dmem_typedefs.svh>
//    - <dmem_transaction.svh>

//    - <dmem_configuration.svh>
//    - <dmem_driver.svh>
//    - <dmem_monitor.svh>

//    - <dmem_transaction_coverage.svh>
//    - <dmem_sequence_base.svh>
//    - <dmem_random_sequence.svh>

//    - <dmem_responder_sequence.svh>
//    - <dmem2reg_adapter.svh>
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
package dmem_pkg;
  
   import uvm_pkg::*;
   import uvmf_base_pkg_hdl::*;
   import uvmf_base_pkg::*;
   import dmem_pkg_hdl::*;

   `include "uvm_macros.svh"

   // pragma uvmf custom package_imports_additional begin 
   // pragma uvmf custom package_imports_additional end
   `include "src/dmem_macros.svh"

   export dmem_pkg_hdl::*;
   
 

   // Parameters defined as HVL parameters

   `include "src/dmem_typedefs.svh"
   `include "src/dmem_transaction.svh"

   `include "src/dmem_configuration.svh"
   `include "src/dmem_driver.svh"
   `include "src/dmem_monitor.svh"

   `include "src/dmem_transaction_coverage.svh"
   `include "src/dmem_sequence_base.svh"
   `include "src/dmem_random_sequence.svh"

   `include "src/dmem_responder_sequence.svh"
   `include "src/dmem2reg_adapter.svh"

   `include "src/dmem_agent.svh"

   // pragma uvmf custom package_item_additional begin
   // UVMF_CHANGE_ME : When adding new interface sequences to the src directory
   //    be sure to add the sequence file here so that it will be
   //    compiled as part of the interface package.  Be sure to place
   //    the new sequence after any base sequences of the new sequence.
   // pragma uvmf custom package_item_additional end

endpackage

// pragma uvmf custom external begin
// pragma uvmf custom external end

