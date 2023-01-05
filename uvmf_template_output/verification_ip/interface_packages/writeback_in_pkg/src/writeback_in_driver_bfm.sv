//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: 
//    This interface performs the writeback_in signal driving.  It is
//     accessed by the uvm writeback_in driver through a virtual interface
//     handle in the writeback_in configuration.  It drives the singals passed
//     in through the port connection named bus of type writeback_in_if.
//
//     Input signals from the writeback_in_if are assigned to an internal input
//     signal with a _i suffix.  The _i signal should be used for sampling.
//
//     The input signal connections are as follows:
//       bus.signal -> signal_i 
//
//     This bfm drives signals with a _o suffix.  These signals
//     are driven onto signals within writeback_in_if based on INITIATOR/RESPONDER and/or
//     ARBITRATION/GRANT status.  
//
//     The output signal connections are as follows:
//        signal_o -> bus.signal
//
//                                                                                           
//      Interface functions and tasks used by UVM components:
//
//             configure:
//                   This function gets configuration attributes from the
//                   UVM driver to set any required BFM configuration
//                   variables such as 'initiator_responder'.                                       
//                                                                                           
//             initiate_and_get_response:
//                   This task is used to perform signaling activity for initiating
//                   a protocol transfer.  The task initiates the transfer, using
//                   input data from the initiator struct.  Then the task captures
//                   response data, placing the data into the response struct.
//                   The response struct is returned to the driver class.
//
//             respond_and_wait_for_next_transfer:
//                   This task is used to complete a current transfer as a responder
//                   and then wait for the initiator to start the next transfer.
//                   The task uses data in the responder struct to drive protocol
//                   signals to complete the transfer.  The task then waits for 
//                   the next transfer.  Once the next transfer begins, data from
//                   the initiator is placed into the initiator struct and sent
//                   to the responder sequence for processing to determine 
//                   what data to respond with.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
import uvmf_base_pkg_hdl::*;
import writeback_in_pkg_hdl::*;
`include "src/writeback_in_macros.svh"

interface writeback_in_driver_bfm 
  (writeback_in_if bus);
  // The following pragma and additional ones in-lined further below are for running this BFM on Veloce
  // pragma attribute writeback_in_driver_bfm partition_interface_xif

`ifndef XRTL
// This code is to aid in debugging parameter mismatches between the BFM and its corresponding agent.
// Enable this debug by setting UVM_VERBOSITY to UVM_DEBUG
// Setting UVM_VERBOSITY to UVM_DEBUG causes all BFM's and all agents to display their parameter settings.
// All of the messages from this feature have a UVM messaging id value of "CFG"
// The transcript or run.log can be parsed to ensure BFM parameter settings match its corresponding agents parameter settings.
import uvm_pkg::*;
`include "uvm_macros.svh"
initial begin : bfm_vs_agent_parameter_debug
  `uvm_info("CFG", 
      $psprintf("The BFM at '%m' has the following parameters: ", ),
      UVM_DEBUG)
end
`endif

  // Config value to determine if this is an initiator or a responder 
  uvmf_initiator_responder_t initiator_responder;
  // Custom configuration variables.  
  // These are set using the configure function which is called during the UVM connect_phase

  tri clock_i;
  tri reset_i;

  // Signal list (all signals are capable of being inputs and outputs for the sake
  // of supporting both INITIATOR and RESPONDER mode operation. Expectation is that 
  // directionality in the config file was from the point-of-view of the INITIATOR

  // INITIATOR mode input signals

  // INITIATOR mode output signals
  tri [15:0] npc_i;
  reg [15:0] npc_o = 'bz;
  tri [1:0] W_control_in_i;
  reg [1:0] W_control_in_o = 'bz;
  tri [15:0] aluout_i;
  reg [15:0] aluout_o = 'bz;
  tri [15:0] pcout_i;
  reg [15:0] pcout_o = 'bz;
  tri [15:0] memout_i;
  reg [15:0] memout_o = 'bz;
  tri  enable_writeback_i;
  reg  enable_writeback_o = 'bz;
  tri [2:0] sr1_i;
  reg [2:0] sr1_o = 'bz;
  tri [2:0] sr2_i;
  reg [2:0] sr2_o = 'bz;
  tri [2:0] dr_i;
  reg [2:0] dr_o = 'bz;

  // Bi-directional signals
  

  assign clock_i = bus.clock;
  assign reset_i = bus.reset;

  // These are signals marked as 'input' by the config file, but the signals will be
  // driven by this BFM if put into RESPONDER mode (flipping all signal directions around)


  // These are signals marked as 'output' by the config file, but the outputs will
  // not be driven by this BFM unless placed in INITIATOR mode.
  assign bus.npc = (initiator_responder == INITIATOR) ? npc_o : 'bz;
  assign npc_i = bus.npc;
  assign bus.W_control_in = (initiator_responder == INITIATOR) ? W_control_in_o : 'bz;
  assign W_control_in_i = bus.W_control_in;
  assign bus.aluout = (initiator_responder == INITIATOR) ? aluout_o : 'bz;
  assign aluout_i = bus.aluout;
  assign bus.pcout = (initiator_responder == INITIATOR) ? pcout_o : 'bz;
  assign pcout_i = bus.pcout;
  assign bus.memout = (initiator_responder == INITIATOR) ? memout_o : 'bz;
  assign memout_i = bus.memout;
  assign bus.enable_writeback = (initiator_responder == INITIATOR) ? enable_writeback_o : 'bz;
  assign enable_writeback_i = bus.enable_writeback;
  assign bus.sr1 = (initiator_responder == INITIATOR) ? sr1_o : 'bz;
  assign sr1_i = bus.sr1;
  assign bus.sr2 = (initiator_responder == INITIATOR) ? sr2_o : 'bz;
  assign sr2_i = bus.sr2;
  assign bus.dr = (initiator_responder == INITIATOR) ? dr_o : 'bz;
  assign dr_i = bus.dr;

  // Proxy handle to UVM driver
  writeback_in_pkg::writeback_in_driver   proxy;
  // pragma tbx oneway proxy.my_function_name_in_uvm_driver                 

  // ****************************************************************************
  // **************************************************************************** 
  // Macros that define structs located in writeback_in_macros.svh
  // ****************************************************************************
  // Struct for passing configuration data from writeback_in_driver to this BFM
  // ****************************************************************************
  `writeback_in_CONFIGURATION_STRUCT
  // ****************************************************************************
  // Structs for INITIATOR and RESPONDER data flow
  //*******************************************************************
  // Initiator macro used by writeback_in_driver and writeback_in_driver_bfm
  // to communicate initiator driven data to writeback_in_driver_bfm.           
  `writeback_in_INITIATOR_STRUCT
    writeback_in_initiator_s initiator_struct;
  // Responder macro used by writeback_in_driver and writeback_in_driver_bfm
  // to communicate Responder driven data to writeback_in_driver_bfm.
  `writeback_in_RESPONDER_STRUCT
    writeback_in_responder_s responder_struct;

  // ****************************************************************************
// pragma uvmf custom reset_condition_and_response begin
  // Always block used to return signals to reset value upon assertion of reset
  always @( posedge reset_i )
     begin
       // RESPONDER mode output signals
       // INITIATOR mode output signals
       npc_o <= 'bz;
       W_control_in_o <= 'bz;
       aluout_o <= 'bz;
       pcout_o <= 'bz;
       memout_o <= 'bz;
       enable_writeback_o <= 'bz;
       sr1_o <= 'bz;
       sr2_o <= 'bz;
       dr_o <= 'bz;
       // Bi-directional signals
 
     end    
// pragma uvmf custom reset_condition_and_response end

  // pragma uvmf custom interface_item_additional begin
  // pragma uvmf custom interface_item_additional end

  //******************************************************************
  // The configure() function is used to pass agent configuration
  // variables to the driver BFM.  It is called by the driver within
  // the agent at the beginning of the simulation.  It may be called 
  // during the simulation if agent configuration variables are updated
  // and the driver BFM needs to be aware of the new configuration 
  // variables.
  //

  function void configure(writeback_in_configuration_s writeback_in_configuration_arg); // pragma tbx xtf  
    initiator_responder = writeback_in_configuration_arg.initiator_responder;
  // pragma uvmf custom configure begin
  // pragma uvmf custom configure end
  endfunction                                                                             

// pragma uvmf custom initiate_and_get_response begin
// ****************************************************************************
// UVMF_CHANGE_ME
// This task is used by an initator.  The task first initiates a transfer then
// waits for the responder to complete the transfer.
    task initiate_and_get_response( 
       // This argument passes transaction variables used by an initiator
       // to perform the initial part of a protocol transfer.  The values
       // come from a sequence item created in a sequence.
       input writeback_in_initiator_s writeback_in_initiator_struct, 
       // This argument is used to send data received from the responder
       // back to the sequence item.  The sequence item is returned to the sequence.
       output writeback_in_responder_s writeback_in_responder_struct 
       );// pragma tbx xtf  
       // 
       // Members within the writeback_in_initiator_struct:
       //   npc_t npc ;
       //   bit [1:0] W_control_in ;
       //   aluout_t aluout ;
       //   pcout_t pcout ;
       //   memout_t memout ;
       //   bit enable_writeback ;
       //   reg_t sr1 ;
       //   reg_t sr2 ;
       //   reg_t dr ;
       // Members within the writeback_in_responder_struct:
       //   npc_t npc ;
       //   bit [1:0] W_control_in ;
       //   aluout_t aluout ;
       //   pcout_t pcout ;
       //   memout_t memout ;
       //   bit enable_writeback ;
       //   reg_t sr1 ;
       //   reg_t sr2 ;
       //   reg_t dr ;
       initiator_struct = writeback_in_initiator_struct;
       //
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge clock_i);
       //    
       //    How to assign a responder struct member, named xyz, from a signal.   
       //    All available initiator input and inout signals listed.
       //    Initiator input signals
       //    Initiator inout signals
       //    How to assign a signal from an initiator struct member named xyz.   
       //    All available initiator output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Initiator output signals
       //      npc_o <= writeback_in_initiator_struct.xyz;  //    [15:0] 
       //      W_control_in_o <= writeback_in_initiator_struct.xyz;  //    [1:0] 
       //      aluout_o <= writeback_in_initiator_struct.xyz;  //    [15:0] 
       //      pcout_o <= writeback_in_initiator_struct.xyz;  //    [15:0] 
       //      memout_o <= writeback_in_initiator_struct.xyz;  //    [15:0] 
       //      enable_writeback_o <= writeback_in_initiator_struct.xyz;  //     
       //      sr1_o <= writeback_in_initiator_struct.xyz;  //    [2:0] 
       //      sr2_o <= writeback_in_initiator_struct.xyz;  //    [2:0] 
       //      dr_o <= writeback_in_initiator_struct.xyz;  //    [2:0] 
       //    Initiator inout signals
    // Initiate a transfer using the data received.
    @(posedge clock_i);
    @(posedge clock_i);
    // Wait for the responder to complete the transfer then place the responder data into 
    // writeback_in_responder_struct.
    @(posedge clock_i);
    @(posedge clock_i);
    responder_struct = writeback_in_responder_struct;
  endtask        
// pragma uvmf custom initiate_and_get_response end

// pragma uvmf custom respond_and_wait_for_next_transfer begin
// ****************************************************************************
// The first_transfer variable is used to prevent completing a transfer in the 
// first call to this task.  For the first call to this task, there is not
// current transfer to complete.
bit first_transfer=1;

// UVMF_CHANGE_ME
// This task is used by a responder.  The task first completes the current 
// transfer in progress then waits for the initiator to start the next transfer.
  task respond_and_wait_for_next_transfer( 
       // This argument is used to send data received from the initiator
       // back to the sequence item.  The sequence determines how to respond.
       output writeback_in_initiator_s writeback_in_initiator_struct, 
       // This argument passes transaction variables used by a responder
       // to complete a protocol transfer.  The values come from a sequence item.       
       input writeback_in_responder_s writeback_in_responder_struct 
       );// pragma tbx xtf   
  // Variables within the writeback_in_initiator_struct:
  //   npc_t npc ;
  //   bit [1:0] W_control_in ;
  //   aluout_t aluout ;
  //   pcout_t pcout ;
  //   memout_t memout ;
  //   bit enable_writeback ;
  //   reg_t sr1 ;
  //   reg_t sr2 ;
  //   reg_t dr ;
  // Variables within the writeback_in_responder_struct:
  //   npc_t npc ;
  //   bit [1:0] W_control_in ;
  //   aluout_t aluout ;
  //   pcout_t pcout ;
  //   memout_t memout ;
  //   bit enable_writeback ;
  //   reg_t sr1 ;
  //   reg_t sr2 ;
  //   reg_t dr ;
       // Reference code;
       //    How to wait for signal value
       //      while (control_signal == 1'b1) @(posedge clock_i);
       //    
       //    How to assign a responder struct member, named xyz, from a signal.   
       //    All available responder input and inout signals listed.
       //    Responder input signals
       //      writeback_in_responder_struct.xyz = npc_i;  //    [15:0] 
       //      writeback_in_responder_struct.xyz = W_control_in_i;  //    [1:0] 
       //      writeback_in_responder_struct.xyz = aluout_i;  //    [15:0] 
       //      writeback_in_responder_struct.xyz = pcout_i;  //    [15:0] 
       //      writeback_in_responder_struct.xyz = memout_i;  //    [15:0] 
       //      writeback_in_responder_struct.xyz = enable_writeback_i;  //     
       //      writeback_in_responder_struct.xyz = sr1_i;  //    [2:0] 
       //      writeback_in_responder_struct.xyz = sr2_i;  //    [2:0] 
       //      writeback_in_responder_struct.xyz = dr_i;  //    [2:0] 
       //    Responder inout signals
       //    How to assign a signal, named xyz, from an initiator struct member.   
       //    All available responder output and inout signals listed.
       //    Notice the _o.  Those are storage variables that allow for procedural assignment.
       //    Responder output signals
       //    Responder inout signals
    
  @(posedge clock_i);
  if (!first_transfer) begin
    // Perform transfer response here.   
    // Reply using data recieved in the writeback_in_responder_struct.
    @(posedge clock_i);
    // Reply using data recieved in the transaction handle.
    @(posedge clock_i);
  end
    // Wait for next transfer then gather info from intiator about the transfer.
    // Place the data into the writeback_in_initiator_struct.
    @(posedge clock_i);
    @(posedge clock_i);
    first_transfer = 0;
  endtask
// pragma uvmf custom respond_and_wait_for_next_transfer end

 
endinterface

// pragma uvmf custom external begin
// pragma uvmf custom external end

