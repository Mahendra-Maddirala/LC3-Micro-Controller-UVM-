//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//     
// DESCRIPTION: This file contains macros used with the decode_out package.
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
//      the decode_out_configuration class.
//
  `define decode_out_CONFIGURATION_STRUCT \
typedef struct packed  { \
     uvmf_active_passive_t active_passive; \
     uvmf_initiator_responder_t initiator_responder; \
     } decode_out_configuration_s;

  `define decode_out_CONFIGURATION_TO_STRUCT_FUNCTION \
  virtual function decode_out_configuration_s to_struct();\
    decode_out_configuration_struct = \
       {\
       this.active_passive,\
       this.initiator_responder\
       };\
    return ( decode_out_configuration_struct );\
  endfunction

  `define decode_out_CONFIGURATION_FROM_STRUCT_FUNCTION \
  virtual function void from_struct(decode_out_configuration_s decode_out_configuration_struct);\
      {\
      this.active_passive,\
      this.initiator_responder  \
      } = decode_out_configuration_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_monitor_struct
//      and from_monitor_struct methods of the decode_out_transaction class.
//
  `define decode_out_MONITOR_STRUCT typedef struct packed  { \
  ir_t IR ; \
  e_ctrl_t E_control ; \
  npc_t npc_out ; \
  m_ctrl_t M_control ; \
  w_ctrl_t W_control ; \
     } decode_out_monitor_s;

  `define decode_out_TO_MONITOR_STRUCT_FUNCTION \
  virtual function decode_out_monitor_s to_monitor_struct();\
    decode_out_monitor_struct = \
            { \
            this.IR , \
            this.E_control , \
            this.npc_out , \
            this.M_control , \
            this.W_control  \
            };\
    return ( decode_out_monitor_struct);\
  endfunction\

  `define decode_out_FROM_MONITOR_STRUCT_FUNCTION \
  virtual function void from_monitor_struct(decode_out_monitor_s decode_out_monitor_struct);\
            {\
            this.IR , \
            this.E_control , \
            this.npc_out , \
            this.M_control , \
            this.W_control  \
            } = decode_out_monitor_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_initiator_struct
//      and from_initiator_struct methods of the decode_out_transaction class.
//      Also update the comments in the driver BFM.
//
  `define decode_out_INITIATOR_STRUCT typedef struct packed  { \
  ir_t IR ; \
  e_ctrl_t E_control ; \
  npc_t npc_out ; \
  m_ctrl_t M_control ; \
  w_ctrl_t W_control ; \
     } decode_out_initiator_s;

  `define decode_out_TO_INITIATOR_STRUCT_FUNCTION \
  virtual function decode_out_initiator_s to_initiator_struct();\
    decode_out_initiator_struct = \
           {\
           this.IR , \
           this.E_control , \
           this.npc_out , \
           this.M_control , \
           this.W_control  \
           };\
    return ( decode_out_initiator_struct);\
  endfunction

  `define decode_out_FROM_INITIATOR_STRUCT_FUNCTION \
  virtual function void from_initiator_struct(decode_out_initiator_s decode_out_initiator_struct);\
           {\
           this.IR , \
           this.E_control , \
           this.npc_out , \
           this.M_control , \
           this.W_control  \
           } = decode_out_initiator_struct;\
  endfunction

// ****************************************************************************
// When changing the contents of this struct, be sure to update the to_responder_struct
//      and from_responder_struct methods of the decode_out_transaction class.
//      Also update the comments in the driver BFM.
//
  `define decode_out_RESPONDER_STRUCT typedef struct packed  { \
  ir_t IR ; \
  e_ctrl_t E_control ; \
  npc_t npc_out ; \
  m_ctrl_t M_control ; \
  w_ctrl_t W_control ; \
     } decode_out_responder_s;

  `define decode_out_TO_RESPONDER_STRUCT_FUNCTION \
  virtual function decode_out_responder_s to_responder_struct();\
    decode_out_responder_struct = \
           {\
           this.IR , \
           this.E_control , \
           this.npc_out , \
           this.M_control , \
           this.W_control  \
           };\
    return ( decode_out_responder_struct);\
  endfunction

  `define decode_out_FROM_RESPONDER_STRUCT_FUNCTION \
  virtual function void from_responder_struct(decode_out_responder_s decode_out_responder_struct);\
           {\
           this.IR , \
           this.E_control , \
           this.npc_out , \
           this.M_control , \
           this.W_control  \
           } = decode_out_responder_struct;\
  endfunction
// pragma uvmf custom additional begin
// pragma uvmf custom additional end