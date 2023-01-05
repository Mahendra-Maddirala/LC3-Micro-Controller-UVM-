//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------                     
//               
// Description: This top level module instantiates all synthesizable
//    static content.  This and tb_top.sv are the two top level modules
//    of the simulation.  
//
//    This module instantiates the following:
//        DUT: The Design Under Test
//        Interfaces:  Signal bundles that contain signals connected to DUT
//        Driver BFM's: BFM's that actively drive interface signals
//        Monitor BFM's: BFM's that passively monitor interface signals
//
//----------------------------------------------------------------------

//----------------------------------------------------------------------
//

module hdl_top;

import lc3_parameters_pkg::*;
import uvmf_base_pkg_hdl::*;

  // pragma attribute hdl_top partition_module_xrtl                                            
// pragma uvmf custom clock_generator begin
  bit clk;
  // Instantiate a clk driver 
  // tbx clkgen
  initial begin
    clk = 0;
    #21ns;
    forever begin
      clk = ~clk;
      #6ns;
    end
  end
// pragma uvmf custom clock_generator end

// pragma uvmf custom reset_generator begin
  bit rst;
  // Instantiate a rst driver
  // tbx clkgen
  initial begin
    rst = 1; 
    #250ns;
    rst =  0; 
  end
// pragma uvmf custom reset_generator end

  // pragma uvmf custom module_item_additional begin
  // pragma uvmf custom module_item_additional end

  // Instantiate the signal bundle, monitor bfm and driver bfm for each interface.
  // The signal bundle, _if, contains signals to be connected to the DUT.
  // The monitor, monitor_bfm, observes the bus, _if, and captures transactions.
  // The driver, driver_bfm, drives transactions onto the bus, _if.

  decode_in_if  decode_env_dec_in_bus(
     // pragma uvmf custom decode_env_dec_in_bus_connections begin
     .clock(clk), .reset(rst), .enable_decode(DUT.Dec.enable_decode), .instr_dout(DUT.Dec.dout), .npc_in(DUT.Dec.npc_in)
     // pragma uvmf custom decode_env_dec_in_bus_connections end
     );
  decode_out_if  decode_env_dec_out_bus(
     // pragma uvmf custom decode_env_dec_out_bus_connections begin
     .clock(clk), .reset(rst), .IR(DUT.IR), .E_control(DUT.E_Control), .npc_out(DUT.npc_out_dec), .M_control(DUT.Mem_Control), .W_control(DUT.W_Control), .enable_decode(DUT.Dec.enable_decode)
     // pragma uvmf custom decode_env_dec_out_bus_connections end
     );
  execute_in_if  execute_env_execute_in_agent_bus(
     // pragma uvmf custom execute_env_exec_in_bus_connections begin
     .clock(clk), .reset(rst), .Mem_Control_in(DUT.Ex.Mem_Control_in), .W_Control_in(DUT.Ex.W_Control_in), .E_Control(DUT.Ex.E_Control), .IR(DUT.Ex.IR), .npc_in(DUT.Ex.npc), .VSR1(DUT.Ex.VSR1), .VSR2(DUT.Ex.VSR2), .bypass_alu_1(DUT.Ex.bypass_alu_1), .bypass_alu_2(DUT.Ex.bypass_alu_2), .bypass_mem_1(DUT.Ex.bypass_mem_1), .bypass_mem_2(DUT.Ex.bypass_mem_2) ,.enable_execute(DUT.Ex.enable_execute), .Mem_Bypass_Val(DUT.Ex.Mem_Bypass_Val)
     // pragma uvmf custom execute_env_exec_in_bus_connections end
     );
  execute_out_if  execute_env_execute_out_agent_bus(
     // pragma uvmf custom execute_env_exec_out_bus_connections begin
     .clock(clk), .reset(rst), .W_Control_out(DUT.W_Control_out), .Mem_Control_out(DUT.Mem_Control_out), .aluout(DUT.Ex.aluout), .pcout(DUT.Ex.pcout), .dr(DUT.dr), .sr1(DUT.sr1), .sr2(DUT.sr2), .IR_Exec(DUT.IR_Exec), .NZP(DUT.NZP), .M_Data(DUT.M_Data)
     // pragma uvmf custom execute_env_exec_out_bus_connections end
     );

  memaccess_in_if  memaccess_env_agent_in_bus(
     // pragma uvmf custom memaccess_env_agent_in_bus_connections begin
     .clock(clk), .reset(rst), .mem_state(DUT.mem_state), .M_Control(DUT.MemAccess.M_Control), .M_Data(DUT.M_Data), .M_addr(DUT.MemAccess.M_Addr), .DMem_dout(DUT.Data_dout)
     // pragma uvmf custom memaccess_env_agent_in_bus_connections end
     );
  memaccess_out_if  memaccess_env_agent_out_bus(
     // pragma uvmf custom memaccess_env_agent_out_bus_connections begin
     .clock(clk), .reset(rst), .mem_state(DUT.MemAccess.mem_state), .DMem_addr(DUT.Data_addr), .DMem_rd(DUT.Data_rd), .DMem_din(DUT.Data_din), .memout(DUT.MemAccess.memout)
     // pragma uvmf custom memaccess_env_agent_out_bus_connections end
     );
  writeback_in_if  writeback_env_wb_in_bus(
     // pragma uvmf custom writeback_env_wb_in_bus_connections begin
     .clock(clk), .reset(rst), .npc(DUT.WB.npc), .W_control_in(DUT.WB.W_Control), .aluout(DUT.WB.aluout), .pcout(DUT.WB.pcout), .memout(DUT.WB.memout), .enable_writeback(DUT.WB.enable_writeback), .sr1(DUT.WB.sr1), .sr2(DUT.WB.sr2), .dr(DUT.WB.dr)
     // pragma uvmf custom writeback_env_wb_in_bus_connections end
     );
  writeback_out_if  writeback_env_wb_out_bus(
     // pragma uvmf custom writeback_env_wb_out_bus_connections begin
     .clock(clk), .reset(rst), .VSR1(DUT.WB.d1), .VSR2(DUT.WB.d2), .psr(DUT.psr)
     // pragma uvmf custom writeback_env_wb_out_bus_connections end
     );

  imem_if  imem_in_bus(
     // pragma uvmf custom imem_in_bus_connections begin
     .clock(clk), .reset(rst), .pc(DUT.pc) /*, .instrmem_rd(DUT.instrmem_rd), .instr_dout(DUT.Instr_dout), .complete_instr(DUT.complete_inst)*/
     // pragma uvmf custom imem_in_bus_connections end
     );
  dmem_if  dmem_in_bus(
     // pragma uvmf custom dmem_in_bus_connections begin
     .clock(clk), .reset(rst), .complete_data(DUT.complete_data), .Data_dout(DUT.Data_dout), .Data_din(DUT.Data_din), .Data_addr(DUT.Data_addr), .Data_rd(DUT.Data_rd));
  decode_in_monitor_bfm  decode_env_dec_in_mon_bfm(decode_env_dec_in_bus.monitor_port);
  decode_out_monitor_bfm  decode_env_dec_out_mon_bfm(decode_env_dec_out_bus.monitor_port);
  execute_in_monitor_bfm  execute_env_execute_in_agent_mon_bfm(execute_env_execute_in_agent_bus.monitor_port);
  execute_out_monitor_bfm  execute_env_execute_out_agent_mon_bfm(execute_env_execute_out_agent_bus.monitor_port);
  memaccess_in_monitor_bfm  memaccess_env_agent_in_mon_bfm(memaccess_env_agent_in_bus.monitor_port);
  memaccess_out_monitor_bfm  memaccess_env_agent_out_mon_bfm(memaccess_env_agent_out_bus.monitor_port);
  writeback_in_monitor_bfm  writeback_env_wb_in_mon_bfm(writeback_env_wb_in_bus.monitor_port);
  writeback_out_monitor_bfm  writeback_env_wb_out_mon_bfm(writeback_env_wb_out_bus.monitor_port);
  imem_monitor_bfm  imem_in_mon_bfm(imem_in_bus.monitor_port);
  dmem_monitor_bfm  dmem_in_mon_bfm(dmem_in_bus.monitor_port);
  imem_driver_bfm  imem_in_drv_bfm(imem_in_bus.responder_port);
  dmem_driver_bfm  dmem_in_drv_bfm(dmem_in_bus.responder_port);

  // pragma uvmf custom dut_instantiation begin
  // UVMF_CHANGE_ME : Add DUT and connect to signals in _bus interfaces listed above
  // Instantiate your DUT here
  // These DUT's instantiated to show verilog and vhdl instantiation
  LC3   DUT(   .clock(clk), .reset(rst),  .pc(imem_in_bus.pc), .instrmem_rd(imem_in_bus.instrmem_rd), .Instr_dout(imem_in_bus.instr_dout), .complete_instr(imem_in_bus.complete_instr) , .Data_addr(dmem_in_bus.Data_addr), .complete_data(dmem_in_bus.complete_data), .Data_din(dmem_in_bus.Data_din), .Data_dout(dmem_in_bus.Data_dout), .Data_rd(dmem_in_bus.Data_rd));

  vhdl_dut            dut_vhdl   (   .clk(clk), .rst(rst), .in_signal(verilog_to_vhdl_signal), .out_signal(vhdl_to_verilog_signal));
  // pragma uvmf custom dut_instantiation end

  initial begin      // tbx vif_binding_block 
    import uvm_pkg::uvm_config_db;
    // The monitor_bfm and driver_bfm for each interface is placed into the uvm_config_db.
    // They are placed into the uvm_config_db using the string names defined in the parameters package.
    // The string names are passed to the agent configurations by test_top through the top level configuration.
    // They are retrieved by the agents configuration class for use by the agent.
    uvm_config_db #( virtual decode_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_dec_in_BFM , decode_env_dec_in_mon_bfm ); 
    uvm_config_db #( virtual decode_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , decode_env_dec_out_BFM , decode_env_dec_out_mon_bfm ); 
    uvm_config_db #( virtual execute_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_execute_in_agent_BFM , execute_env_execute_in_agent_mon_bfm ); 
    uvm_config_db #( virtual execute_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , execute_env_execute_out_agent_BFM , execute_env_execute_out_agent_mon_bfm ); 
    uvm_config_db #( virtual memaccess_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_agent_in_BFM , memaccess_env_agent_in_mon_bfm ); 
    uvm_config_db #( virtual memaccess_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , memaccess_env_agent_out_BFM , memaccess_env_agent_out_mon_bfm ); 
    uvm_config_db #( virtual writeback_in_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_wb_in_BFM , writeback_env_wb_in_mon_bfm ); 
    uvm_config_db #( virtual writeback_out_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , writeback_env_wb_out_BFM , writeback_env_wb_out_mon_bfm ); 
    uvm_config_db #( virtual imem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_in_BFM , imem_in_mon_bfm ); 
    uvm_config_db #( virtual dmem_monitor_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , dmem_in_BFM , dmem_in_mon_bfm ); 
    uvm_config_db #( virtual imem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , imem_in_BFM , imem_in_drv_bfm  );
    uvm_config_db #( virtual dmem_driver_bfm  )::set( null , UVMF_VIRTUAL_INTERFACES , dmem_in_BFM , dmem_in_drv_bfm  );
  end

endmodule

// pragma uvmf custom external begin
// pragma uvmf custom external end

