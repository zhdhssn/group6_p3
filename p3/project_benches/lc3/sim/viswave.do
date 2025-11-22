 

onerror resume
wave tags F0
wave update off

wave spacer -backgroundcolor Salmon { fetch_env_fetch_in_agent }
wave add uvm_test_top.environment.fetch_env.fetch_in_agent.fetch_in_agent_monitor.txn_stream -radix string -tag F0
wave group fetch_env_fetch_in_agent_bus
wave add -group fetch_env_fetch_in_agent_bus hdl_top.fetch_env_fetch_in_agent_bus.* -radix hexadecimal -tag F0
wave group fetch_env_fetch_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { fetch_env_fetch_out_agent }
wave add uvm_test_top.environment.fetch_env.fetch_out_agent.fetch_out_agent_monitor.txn_stream -radix string -tag F0
wave group fetch_env_fetch_out_agent_bus
wave add -group fetch_env_fetch_out_agent_bus hdl_top.fetch_env_fetch_out_agent_bus.* -radix hexadecimal -tag F0
wave group fetch_env_fetch_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_env_dec_in_agent }
wave add uvm_test_top.environment.decode_env.dec_in_agent.dec_in_agent_monitor.txn_stream -radix string -tag F0
wave group decode_env_dec_in_agent_bus
wave add -group decode_env_dec_in_agent_bus hdl_top.decode_env_dec_in_agent_bus.* -radix hexadecimal -tag F0
wave group decode_env_dec_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { decode_env_dec_out_agent }
wave add uvm_test_top.environment.decode_env.dec_out_agent.dec_out_agent_monitor.txn_stream -radix string -tag F0
wave group decode_env_dec_out_agent_bus
wave add -group decode_env_dec_out_agent_bus hdl_top.decode_env_dec_out_agent_bus.* -radix hexadecimal -tag F0
wave group decode_env_dec_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_exe_in_agent }
wave add uvm_test_top.environment.execute_env.exe_in_agent.exe_in_agent_monitor.txn_stream -radix string -tag F0
wave group execute_env_exe_in_agent_bus
wave add -group execute_env_exe_in_agent_bus hdl_top.execute_env_exe_in_agent_bus.* -radix hexadecimal -tag F0
wave group execute_env_exe_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { execute_env_exe_out_agent }
wave add uvm_test_top.environment.execute_env.exe_out_agent.exe_out_agent_monitor.txn_stream -radix string -tag F0
wave group execute_env_exe_out_agent_bus
wave add -group execute_env_exe_out_agent_bus hdl_top.execute_env_exe_out_agent_bus.* -radix hexadecimal -tag F0
wave group execute_env_exe_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_env_memaccess_in_agt }
wave add uvm_test_top.environment.memaccess_env.memaccess_in_agt.memaccess_in_agt_monitor.txn_stream -radix string -tag F0
wave group memaccess_env_memaccess_in_agt_bus
wave add -group memaccess_env_memaccess_in_agt_bus hdl_top.memaccess_env_memaccess_in_agt_bus.* -radix hexadecimal -tag F0
wave group memaccess_env_memaccess_in_agt_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { memaccess_env_memaccess_out_agt }
wave add uvm_test_top.environment.memaccess_env.memaccess_out_agt.memaccess_out_agt_monitor.txn_stream -radix string -tag F0
wave group memaccess_env_memaccess_out_agt_bus
wave add -group memaccess_env_memaccess_out_agt_bus hdl_top.memaccess_env_memaccess_out_agt_bus.* -radix hexadecimal -tag F0
wave group memaccess_env_memaccess_out_agt_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_env_writeback_in_agent }
wave add uvm_test_top.environment.writeback_env.writeback_in_agent.writeback_in_agent_monitor.txn_stream -radix string -tag F0
wave group writeback_env_writeback_in_agent_bus
wave add -group writeback_env_writeback_in_agent_bus hdl_top.writeback_env_writeback_in_agent_bus.* -radix hexadecimal -tag F0
wave group writeback_env_writeback_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { writeback_env_writeback_out_agent }
wave add uvm_test_top.environment.writeback_env.writeback_out_agent.writeback_out_agent_monitor.txn_stream -radix string -tag F0
wave group writeback_env_writeback_out_agent_bus
wave add -group writeback_env_writeback_out_agent_bus hdl_top.writeback_env_writeback_out_agent_bus.* -radix hexadecimal -tag F0
wave group writeback_env_writeback_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { controller_env_controller_in_agent }
wave add uvm_test_top.environment.controller_env.controller_in_agent.controller_in_agent_monitor.txn_stream -radix string -tag F0
wave group controller_env_controller_in_agent_bus
wave add -group controller_env_controller_in_agent_bus hdl_top.controller_env_controller_in_agent_bus.* -radix hexadecimal -tag F0
wave group controller_env_controller_in_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { controller_env_controller_out_agent }
wave add uvm_test_top.environment.controller_env.controller_out_agent.controller_out_agent_monitor.txn_stream -radix string -tag F0
wave group controller_env_controller_out_agent_bus
wave add -group controller_env_controller_out_agent_bus hdl_top.controller_env_controller_out_agent_bus.* -radix hexadecimal -tag F0
wave group controller_env_controller_out_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { imem_agent }
wave add uvm_test_top.environment.imem_agent.imem_agent_monitor.txn_stream -radix string -tag F0
wave group imem_agent_bus
wave add -group imem_agent_bus hdl_top.imem_agent_bus.* -radix hexadecimal -tag F0
wave group imem_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]
wave spacer -backgroundcolor Salmon { dmem_agent }
wave add uvm_test_top.environment.dmem_agent.dmem_agent_monitor.txn_stream -radix string -tag F0
wave group dmem_agent_bus
wave add -group dmem_agent_bus hdl_top.dmem_agent_bus.* -radix hexadecimal -tag F0
wave group dmem_agent_bus -collapse
wave insertion [expr [wave index insertpoint] +1]



wave update on
WaveSetStreamView

