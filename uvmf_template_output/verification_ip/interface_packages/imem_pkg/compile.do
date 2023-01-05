# Tcl do file for compile of imem interface

# pragma uvmf custom additional begin
# pragma uvmf custom additional end


vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/imem_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/imem_pkg/imem_filelist_hdl.f

vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/imem_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/imem_pkg/imem_filelist_hvl.f

vlog -sv -timescale 1ps/1ps -suppress 2223,2286 +incdir+$env(UVMF_VIP_LIBRARY_HOME)/interface_packages/imem_pkg \
  -F $env(UVMF_VIP_LIBRARY_HOME)/interface_packages/imem_pkg/imem_filelist_xrtl.f