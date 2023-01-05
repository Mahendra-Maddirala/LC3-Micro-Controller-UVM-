//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This interface contains the dmem interface signals.
//      It is instantiated once per dmem bus.  Bus Functional Models, 
//      BFM's named dmem_driver_bfm, are used to drive signals on the bus.
//      BFM's named dmem_monitor_bfm are used to monitor signals on the 
//      bus. This interface signal bundle is passed in the port list of
//      the BFM in order to give the BFM access to the signals in this
//      interface.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// This template can be used to connect a DUT to these signals
//
// .dut_signal_port(dmem_bus.complete_data), // Agent input 
// .dut_signal_port(dmem_bus.Data_dout), // Agent input 
// .dut_signal_port(dmem_bus.Data_din), // Agent output 
// .dut_signal_port(dmem_bus.Data_addr), // Agent output 
// .dut_signal_port(dmem_bus.Data_rd), // Agent output 

import uvmf_base_pkg_hdl::*;
import dmem_pkg_hdl::*;

interface  dmem_if 

  (
  input tri clock, 
  input tri reset,
  inout tri  complete_data,
  inout tri [15:0] Data_dout,
  inout tri [15:0] Data_din,
  inout tri [15:0] Data_addr,
  inout tri  Data_rd
  );

modport monitor_port 
  (
  input clock,
  input reset,
  input complete_data,
  input Data_dout,
  input Data_din,
  input Data_addr,
  input Data_rd
  );

modport initiator_port 
  (
  input clock,
  input reset,
  input complete_data,
  input Data_dout,
  output Data_din,
  output Data_addr,
  output Data_rd
  );

modport responder_port 
  (
  input clock,
  input reset,  
  output complete_data,
  output Data_dout,
  input Data_din,
  input Data_addr,
  input Data_rd
  );
  

// pragma uvmf custom interface_item_additional begin
// pragma uvmf custom interface_item_additional end

endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

