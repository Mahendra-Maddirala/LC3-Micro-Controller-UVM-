//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the dmem package.
//   These macros include packed struct definitions.  These structs are
//   used to pass data between classes, hvl, and BFM's, hdl.  Use of 
//   structs are more efficient and simpler to modify.
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_struct
//      and from_struct methods defined in the macros below that are used in  
//      the dmem_configuration class.
//
  `define dmem_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } dmem_configuration_s;

  `define dmem_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function dmem_configuration_s to_struct();\
    dmem_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( dmem_configuration_struct );\
  endfunction

  `define dmem_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(dmem_configuration_s dmem_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = dmem_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the dmem_transaction class.
//
  `define dmem_MONITOR_STRUCT typedef struct packed  { \
  bit complete_data ; \
  int wait_complete ; \
  bit [15:0] Data_dout ; \
  bit [15:0] Data_din ; \
  bit [15:0] Data_addr ; \
  bit Data_rd ; \
     } dmem_monitor_s;

  `define dmem_TO_MONITOR_STRUCT_FUNCTION \
  virtual function dmem_monitor_s to_monitor_struct();\
    dmem_monitor_struct = \
            { \
            this.complete_data , \
            this.wait_complete , \
            this.Data_dout , \
            this.Data_din , \
            this.Data_addr , \
            this.Data_rd  \
            };\
    return ( dmem_monitor_struct);\
  endfunction\

  `define dmem_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(dmem_monitor_s dmem_monitor_struct);\
            {\
            this.complete_data , \
            this.wait_complete , \
            this.Data_dout , \
            this.Data_din , \
            this.Data_addr , \
            this.Data_rd  \
            } = dmem_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the dmem_transaction class.
//      Also update the comments in the driver BFM.
//
  `define dmem_INITIATOR_STRUCT typedef struct packed  { \
  bit complete_data ; \
  int wait_complete ; \
  bit [15:0] Data_dout ; \
  bit [15:0] Data_din ; \
  bit [15:0] Data_addr ; \
  bit Data_rd ; \
     } dmem_initiator_s;

  `define dmem_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function dmem_initiator_s to_initiator_struct();\
    dmem_initiator_struct = \
           {\
           this.complete_data , \
           this.wait_complete , \
           this.Data_dout , \
           this.Data_din , \
           this.Data_addr , \
           this.Data_rd  \
           };\
    return ( dmem_initiator_struct);\
  endfunction

  `define dmem_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(dmem_initiator_s dmem_initiator_struct);\
           {\
           this.complete_data , \
           this.wait_complete , \
           this.Data_dout , \
           this.Data_din , \
           this.Data_addr , \
           this.Data_rd  \
           } = dmem_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the dmem_transaction class.
//      Also update the comments in the driver BFM.
//
  `define dmem_RESPONDER_STRUCT typedef struct packed  { \
  bit complete_data ; \
  int wait_complete ; \
  bit [15:0] Data_dout ; \
  bit [15:0] Data_din ; \
  bit [15:0] Data_addr ; \
  bit Data_rd ; \
     } dmem_responder_s;

  `define dmem_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function dmem_responder_s to_responder_struct();\
    dmem_responder_struct = \
           {\
           this.complete_data , \
           this.wait_complete , \
           this.Data_dout , \
           this.Data_din , \
           this.Data_addr , \
           this.Data_rd  \
           };\
    return ( dmem_responder_struct);\
  endfunction

  `define dmem_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(dmem_responder_s dmem_responder_struct);\
           {\
           this.complete_data , \
           this.wait_complete , \
           this.Data_dout , \
           this.Data_din , \
           this.Data_addr , \
           this.Data_rd  \
           } = dmem_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end
