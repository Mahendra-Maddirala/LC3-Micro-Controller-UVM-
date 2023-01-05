 

onerror resume
wave tags F0
wave update off

wave spacer -backgroundcolor Salmon { decode_env_dec_in }
wave add uvm_test_top.environment.decode_env.dec_in.dec_in_monitor.txn_stream -radix string -tag F0
wave group decode_env_dec_in_bus
wave add -group decode_env_dec_in_bus hdl_top.decode_env_dec_in_bus.* -radix hexadecimal -tag F0
wave group decode_env_dec_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_env_dec_out }
wave add uvm_test_top.environment.decode_env.dec_out.dec_out_monitor.txn_stream -radix string -tag F0
wave group decode_env_dec_out_bus
wave add -group decode_env_dec_out_bus hdl_top.decode_env_dec_out_bus.* -radix hexadecimal -tag F0
wave group decode_env_dec_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_execute_in_agent }
wave add uvm_test_top.environment.execute_env.execute_in_agent.execute_in_agent_monitor.txn_stream -radix string -tag F0
wave group execute_env_execute_in_agent_bus
wave add -group execute_env_execute_in_agent_bus hdl_top.execute_env_execute_in_agent_bus.* -radix hexadecimal -tag F0
wave group execute_env_execute_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_execute_out_agent }
wave add uvm_test_top.environment.execute_env.execute_out_agent.execute_out_agent_monitor.txn_stream -radix string -tag F0
wave group execute_env_execute_out_agent_bus
wave add -group execute_env_execute_out_agent_bus hdl_top.execute_env_execute_out_agent_bus.* -radix hexadecimal -tag F0
wave group execute_env_execute_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_env_agent_in }
wave add uvm_test_top.environment.memaccess_env.agent_in.agent_in_monitor.txn_stream -radix string -tag F0
wave group memaccess_env_agent_in_bus
wave add -group memaccess_env_agent_in_bus hdl_top.memaccess_env_agent_in_bus.* -radix hexadecimal -tag F0
wave group memaccess_env_agent_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_env_agent_out }
wave add uvm_test_top.environment.memaccess_env.agent_out.agent_out_monitor.txn_stream -radix string -tag F0
wave group memaccess_env_agent_out_bus
wave add -group memaccess_env_agent_out_bus hdl_top.memaccess_env_agent_out_bus.* -radix hexadecimal -tag F0
wave group memaccess_env_agent_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_env_wb_in }
wave add uvm_test_top.environment.writeback_env.wb_in.wb_in_monitor.txn_stream -radix string -tag F0
wave group writeback_env_wb_in_bus
wave add -group writeback_env_wb_in_bus hdl_top.writeback_env_wb_in_bus.* -radix hexadecimal -tag F0
wave group writeback_env_wb_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_env_wb_out }
wave add uvm_test_top.environment.writeback_env.wb_out.wb_out_monitor.txn_stream -radix string -tag F0
wave group writeback_env_wb_out_bus
wave add -group writeback_env_wb_out_bus hdl_top.writeback_env_wb_out_bus.* -radix hexadecimal -tag F0
wave group writeback_env_wb_out_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { imem_in }
wave add uvm_test_top.environment.imem_in.imem_in_monitor.txn_stream -radix string -tag F0
wave group imem_in_bus
wave add -group imem_in_bus hdl_top.imem_in_bus.* -radix hexadecimal -tag F0
wave group imem_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { dmem_in }
wave add uvm_test_top.environment.dmem_in.dmem_in_monitor.txn_stream -radix string -tag F0
wave group dmem_in_bus
wave add -group dmem_in_bus hdl_top.dmem_in_bus.* -radix hexadecimal -tag F0
wave group dmem_in_bus -collapse
wave insertion [expr [wave index insertpoint] +1]

wave update on
WaveSetStreamView

