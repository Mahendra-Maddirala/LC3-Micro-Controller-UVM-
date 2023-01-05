
// UVM
+incdir+${UVM_HOME}/src
${UVM_HOME}/src/uvm_pkg.sv

// Common UVMF files
-f ${UVMF_HOME}/common/common_sve.f

// BFM Files
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/decode_in_pkg/decode_in_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/decode_out_pkg/decode_out_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/execute_in_pkg/execute_in_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/execute_out_pkg/execute_out_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/memaccess_in_pkg/memaccess_in_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/memaccess_out_pkg/memaccess_out_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/writeback_in_pkg/writeback_in_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/writeback_out_pkg/writeback_out_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/imem_pkg/imem_pkg_sve.F
-F ${UVMF_VIP_LIBRARY_HOME}/interface_packages/dmem_pkg/dmem_pkg_sve.F

// Environment Files
-F ${UVMF_VIP_LIBRARY_HOME}/environment_packages/lc3_env_pkg/lc3_env_pkg_sve.F

// Bench Files
+incdir+./tb/tests
./tb/tests/lc3_tests_pkg.sv

+incdir+./tb/sequences
./tb/sequences/lc3_sequences_pkg.sv

+incdir+./tb/parameters
./tb/parameters/lc3_parameters_pkg.sv

./tb/testbench/hdl_top.sv
./tb/testbench/hvl_top.sv

