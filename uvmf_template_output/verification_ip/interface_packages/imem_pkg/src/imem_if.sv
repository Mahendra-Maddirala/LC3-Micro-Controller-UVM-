//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the imem interface signals.
//      It is instantiated once per imem bus.  Bus Functional Models, 
//      BFM's named imem_driver_bfm, are used to drive signals on the bus.
//      BFM's named imem_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(imem_bus.pc), // Agent output 
// .dut_signal_port(imem_bus.instrmem_rd), // Agent output 
// .dut_signal_port(imem_bus.instr_dout), // Agent input 
// .dut_signal_port(imem_bus.complete_instr), // Agent input 

import uvmf_base_pkg_hdl::*;
import imem_pkg_hdl::*;

interface  imem_if 

  (
  input tri clock, 
  input tri reset,
  inout tri [15:0] pc,
  inout tri  instrmem_rd,
  inout tri [15:0] instr_dout,
  inout tri  complete_instr
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input pc,
  input instrmem_rd,
  input instr_dout,
  input complete_instr
  );

modport initiator_port 
  (
  input clock,
  input reset,
  output pc,
  output instrmem_rd,
  input instr_dout,
  input complete_instr
  );

modport responder_port 
  (
  input clock,
  input reset,  
  input pc,
  input instrmem_rd,
  output instr_dout,
  output complete_instr
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

