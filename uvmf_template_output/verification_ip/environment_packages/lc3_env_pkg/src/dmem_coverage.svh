//----------------------------------------------------------------------
// Created with uvmf_gen version 2022.3
//----------------------------------------------------------------------
// pragma uvmf custom header begin
// pragma uvmf custom header end
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//
// DESCRIPTION: 
//         This component is used to collect functional coverage at the environment level.
//   Coverage collection components typically do not have analysis ports for broadcasting
//   transactions.  They typically only receive transactions and sample functional coverage
//   on the transaction variables.
// 
//   This analysis component has the following analysis_exports that receive the 
//   listed transaction type.
//   
//   dmem_cov_ae receives transactions of type  dmem_transaction  
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//


class dmem_coverage #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( dmem_coverage #(
                              CONFIG_T,
                              BASE_T
                              ))

  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_dmem_cov_ae #(dmem_transaction, dmem_coverage #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) dmem_cov_ae;


   dmem_transaction t_cov, prev_t_cov;
   bit first = 1'b1;
  // pragma uvmf custom class_item_additional begin
  // pragma uvmf custom class_item_additional end

// ****************************************************************************
  // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
  covergroup dmem_coverage_cg;
    // pragma uvmf custom covergroup begin
    option.auto_bin_max=1024;
    option.per_instance=1;
    cp_dmem_rd: coverpoint t_cov.Data_rd iff (t_cov.Data_addr !== 'bz) {
                   bins rd = {1'b1};
                }
    cp_dmem_wr: coverpoint t_cov.Data_rd iff (t_cov.Data_addr !== 'bz) {
                   bins wr = {1'b0};
                }
    cp_dmem_addr: coverpoint t_cov.Data_addr {
                     bins bit_zero[] = {[16'b0:16'b1]};
                     bins bit_one_toggle      = {[16'b0000000000000010: 16'b0000000000000011]};
                     bins bit_two_toggle      = {[16'b0000000000000100: 16'b0000000000000111]};
                     bins bit_three_toggle    = {[16'b0000000000001000: 16'b0000000000001111]};
                     bins bit_four_toggle     = {[16'b0000000000010000: 16'b0000000000011111]};
                     bins bit_five_toggle     = {[16'b0000000000100000: 16'b0000000000111111]};
                     bins bit_six_toggle      = {[16'b0000000001000000: 16'b0000000001111111]};
                     bins bit_seven_toggle    = {[16'b0000000010000000: 16'b0000000011111111]};
                     bins bit_eight_toggle    = {[16'b0000000100000000: 16'b0000000111111111]};
                     bins bit_nine_toggle     = {[16'b0000001000000000: 16'b0000001111111111]};
                     bins bit_ten_toggle      = {[16'b0000010000000000: 16'b0000011111111111]};
                     bins bit_eleven_toggle   = {[16'b0000100000000000: 16'b0000111111111111]};
                     bins bit_twelve_toggle   = {[16'b0001000000000000: 16'b0001111111111111]};
                     bins bit_thirteen_toggle = {[16'b0010000000000000: 16'b0011111111111111]};
                     bins bit_fourteen_toggle = {[16'b0100000000000000: 16'b0111111111111111]};
                     bins bit_fifteen_toggle  = {[16'b1000000000000000: 16'b1111111111111111]};
                  }
    cross_rd_x_addr: cross cp_dmem_rd,cp_dmem_addr;
    cross_wr_x_addr: cross cp_dmem_wr,cp_dmem_addr;
    cp_dmem_dout: coverpoint t_cov.Data_dout {
                     bins dout_bit_zero[] = {[16'b0:16'b1]};
                     bins dout_bit_one_toggle      = {[16'b0000000000000010: 16'b0000000000000011]};
                     bins dout_bit_two_toggle      = {[16'b0000000000000100: 16'b0000000000000111]};
                     bins dout_bit_three_toggle    = {[16'b0000000000001000: 16'b0000000000001111]};
                     bins dout_bit_four_toggle     = {[16'b0000000000010000: 16'b0000000000011111]};
                     bins dout_bit_five_toggle     = {[16'b0000000000100000: 16'b0000000000111111]};
                     bins dout_bit_six_toggle      = {[16'b0000000001000000: 16'b0000000001111111]};
                     bins dout_bit_seven_toggle    = {[16'b0000000010000000: 16'b0000000011111111]};
                     bins dout_bit_eight_toggle    = {[16'b0000000100000000: 16'b0000000111111111]};
                     bins dout_bit_nine_toggle     = {[16'b0000001000000000: 16'b0000001111111111]};
                     bins dout_bit_ten_toggle      = {[16'b0000010000000000: 16'b0000011111111111]};
                     bins dout_bit_eleven_toggle   = {[16'b0000100000000000: 16'b0000111111111111]};
                     bins dout_bit_twelve_toggle   = {[16'b0001000000000000: 16'b0001111111111111]};
                     bins dout_bit_thirteen_toggle = {[16'b0010000000000000: 16'b0011111111111111]};
                     bins dout_bit_fourteen_toggle = {[16'b0100000000000000: 16'b0111111111111111]};
                     bins dout_bit_fifteen_toggle  = {[16'b1000000000000000: 16'b1111111111111111]};
                  }
    cp_dmem_din: coverpoint t_cov.Data_din {
                     bins din_bit_zero[] = {[16'b0:16'b1]};
                     bins din_bit_one_toggle      = {[16'b0000000000000010: 16'b0000000000000011]};
                     bins din_bit_two_toggle      = {[16'b0000000000000100: 16'b0000000000000111]};
                     bins din_bit_three_toggle    = {[16'b0000000000001000: 16'b0000000000001111]};
                     bins din_bit_four_toggle     = {[16'b0000000000010000: 16'b0000000000011111]};
                     bins din_bit_five_toggle     = {[16'b0000000000100000: 16'b0000000000111111]};
                     bins din_bit_six_toggle      = {[16'b0000000001000000: 16'b0000000001111111]};
                     bins din_bit_seven_toggle    = {[16'b0000000010000000: 16'b0000000011111111]};
                     bins din_bit_eight_toggle    = {[16'b0000000100000000: 16'b0000000111111111]};
                     bins din_bit_nine_toggle     = {[16'b0000001000000000: 16'b0000001111111111]};
                     bins din_bit_ten_toggle      = {[16'b0000010000000000: 16'b0000011111111111]};
                     bins din_bit_eleven_toggle   = {[16'b0000100000000000: 16'b0000111111111111]};
                     bins din_bit_twelve_toggle   = {[16'b0001000000000000: 16'b0001111111111111]};
                     bins din_bit_thirteen_toggle = {[16'b0010000000000000: 16'b0011111111111111]};
                     bins din_bit_fourteen_toggle = {[16'b0100000000000000: 16'b0111111111111111]};
                     bins din_bit_fifteen_toggle  = {[16'b1000000000000000: 16'b1111111111111111]};
                  }
    cross_wr_x_din: cross cp_dmem_din,cp_dmem_wr;
    cross_rd_x_dout: cross cp_dmem_dout,cp_dmem_rd;
    cp_prev_dmem_rd: coverpoint {first,prev_t_cov.Data_rd} iff (t_cov.Data_addr !== 'bz) {
                  bins prev_rd = {2'b01};
               }
    cp_prev_dmem_wr: coverpoint {first,prev_t_cov.Data_rd} iff (t_cov.Data_addr !== 'bz) {
                  bins prev_wr = {2'b00};
               }

    cp_wait_complete: coverpoint t_cov.wait_complete {
                     bins cycle_waits[] = {[0:5]};
                  }
    cross_rd_rd_transition: cross cp_dmem_rd,cp_prev_dmem_rd;
    cross_rd_wr_transition: cross cp_dmem_rd,cp_prev_dmem_wr;
    cross_wr_rd_transition: cross cp_dmem_wr,cp_prev_dmem_rd;
    cross_wr_wr_transition: cross cp_dmem_wr,cp_prev_dmem_wr;

//uvmf custom covergroup end
  endgroup


// ****************************************************************************
  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
    dmem_coverage_cg=new;
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

// ****************************************************************************
  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);

    dmem_coverage_cg.set_inst_name($sformatf("dmem_coverage_cg_%s",get_full_name()));

    dmem_cov_ae = new("dmem_cov_ae", this);
  // pragma uvmf custom build_phase begin
  // pragma uvmf custom build_phase end
  endfunction

  // ****************************************************************************
  // FUNCTION: write_dmem_cov_ae
  // Transactions received through dmem_cov_ae initiate the execution of this function.
  // This function collects functional coverage on variables within the received transaction
  virtual function void write_dmem_cov_ae(dmem_transaction t);
    // pragma uvmf custom dmem_cov_ae_coverage begin
    `uvm_info("COV", "Transaction Received through dmem_cov_ae", UVM_MEDIUM)
    `uvm_info("DMEM COV", {"            Data: ",t.convert2string()}, UVM_NONE)
    t_cov = t;
    if(first == 1'b1) prev_t_cov = t;
    dmem_coverage_cg.sample();
    prev_t_cov = t;
    first = 1'b0;
    // pragma uvmf custom dmem_cov_ae_coverage end
  endfunction

endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end

