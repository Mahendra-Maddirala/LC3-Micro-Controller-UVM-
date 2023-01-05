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
//   imem_cov_ae receives transactions of type  imem_transaction  
//
//   This analysis component has the following analysis_ports that can broadcast 
//   the listed transaction type.
//
//
//----------------------------------------------------------------------
//----------------------------------------------------------------------
//

class imem_coverage #(
  type CONFIG_T,
  type BASE_T = uvm_component
  ) extends BASE_T;

  // Factory registration of this class
  `uvm_component_param_utils( imem_coverage #(
                              CONFIG_T,
                              BASE_T
                              ))

  // Instantiate a handle to the configuration of the environment in which this component resides
  CONFIG_T configuration;

  
  // Instantiate the analysis exports
  uvm_analysis_imp_imem_cov_ae #(imem_transaction, imem_coverage #(
                              .CONFIG_T(CONFIG_T),
                              .BASE_T(BASE_T)
                              )) imem_cov_ae;




  // pragma uvmf custom class_item_additional begin
     imem_transaction t_cov, prev_t_cov;
     bit first = 1'b1;
     bit alu,ld,str,flow_switch;
  // pragma uvmf custom class_item_additional end

// ****************************************************************************
  // UVMF_CHANGE_ME : Add coverage bins, crosses, exclusions, etc. according to coverage needs.
  covergroup imem_coverage_cg;
    // pragma uvmf custom covergroup begin
    option.auto_bin_max=1024;
    option.per_instance=1;

    cp_opcode:    coverpoint t_cov.instruction[15:12] {
                     bins add_type = {ADD};
                     bins and_type = {AND};
                     bins not_type = {NOT};
                     bins ld_type =  {LD};
                     bins ldr_type = {LDR};
                     bins ldi_type = {LDI};
                     bins lea_type = {LEA};
                     bins  st_type = {ST};
                     bins str_type = {STR};
                     bins sti_type = {STI};
                     bins  br_type = {BR};
                     bins jmp_type = {JMP};
                  }

     cp_prevopcode: coverpoint {first,prev_t_cov.instruction[15:12]} {
                       bins add_type = {0,ADD};
                       bins and_type = {0,AND};
                       bins not_type = {0,NOT};
                       bins ld_type =  {0,LD};
                       bins ldr_type = {0,LDR};
                       bins ldi_type = {0,LDI};
                       bins lea_type = {0,LEA};
                       bins  st_type = {0,ST};
                       bins str_type = {0,STR};
                       bins sti_type = {0,STI};
                       bins  br_type = {0,BR};
                       bins jmp_type = {0,JMP};
                  }

     cross_opcode_prev_opcode : cross cp_opcode, cp_prevopcode;

     cp_alu_ops: coverpoint t_cov.instruction[15:12] {
                    bins alu_add_type = {ADD};
                    bins alu_and_type = {AND};
                    bins alu_not_type = {NOT};
                }
     cp_ld_ops: coverpoint t_cov.instruction[15:12] {
                   bins mem_ld_type  =  {LD};
                   bins mem_ldr_type = {LDR};
                   bins mem_ldi_type = {LDI};
                   bins mem_lea_type = {LEA};
                }
   
     cp_str_ops: coverpoint t_cov.instruction[15:12] {
                    bins mem_st_type  = {ST};
                    bins mem_str_type = {STR};
                    bins mem_sti_type = {STI};
                 }

     cp_flow_switch_ops: coverpoint t_cov.instruction[15:12] {
                     bins flow_switch_br_type  = {BR};
                     bins flow_switch_jmp_type = {JMP};
                  }

     cp_dest: coverpoint (t_cov.instruction[11:9]) {
                 bins dest_addr[] = {[3'h0:3'h7]};
              }

     cross_alu_dest: cross cp_alu_ops, cp_dest;

     cross_ld_dest:  cross cp_ld_ops, cp_dest;

     cp_alu_sr1: coverpoint (t_cov.instruction[8:6]) iff(alu == 1'b1){
                    bins alu_sr1[] = {[3'h0:3'h7]};
                 }

     cp_str_sr: coverpoint(t_cov.instruction[11:9]) iff(str == 1'b1){
                   bins str_sr[] = {[3'h0:3'h7]};
                }

     cp_br_nzp: coverpoint (t_cov.instruction[11:9]) iff(t_cov.instruction[15:12] == BR){
                   bins br_nzp[] = {[3'h1:3'h7]};
                } 

     cp_add: coverpoint (t_cov.instruction[15:12]){
                bins add_operation = {ADD} ;
             }

     cp_and: coverpoint (t_cov.instruction[15:12]){
                bins and_operation = {AND} ;
             }

     cp_imm_bit: coverpoint (t_cov.instruction[5]) {
                    bins imm_zero_one[] = {[1'b0:1'b1]};
                 }

     cross_add_imm_bit : cross cp_add, cp_imm_bit;
     cross_and_imm_bit : cross cp_and, cp_imm_bit;

     cp_add_imm_val: coverpoint (t_cov.instruction[4:0]) iff(t_cov.instruction[15:12] == ADD && t_cov.instruction[5] == 1'b1){
                     bins add_imm_bit_zero[] = {[5'b0:5'b1]};
                     bins add_imm_bit_one_toggle      = {[5'b00010: 5'b00011]};
                     bins add_imm_bit_two_toggle      = {[5'b00100: 5'b00111]};
                     bins add_imm_bit_three_toggle    = {[5'b01000: 5'b01111]};
                     bins add_imm_bit_four_toggle     = {[5'b10000: 5'b11111]};
                     }

     cp_and_imm_val: coverpoint (t_cov.instruction[4:0]) iff(t_cov.instruction[15:12] == AND && t_cov.instruction[5] == 1'b1){
                     bins and_imm_bit_zero[] = {[5'b0:5'b1]};
                     bins and_imm_bit_one_toggle      = {[5'b00010: 5'b00011]};
                     bins and_imm_bit_two_toggle      = {[5'b00100: 5'b00111]};
                     bins and_imm_bit_three_toggle    = {[5'b01000: 5'b01111]};
                     bins and_imm_bit_four_toggle     = {[5'b10000: 5'b11111]};
                     }

     cp_add_sr2_val: coverpoint (t_cov.instruction[2:0]) iff(t_cov.instruction[15:12] == ADD && t_cov.instruction[5] == 1'b0){
                        bins add_sr2_val[] = {[3'h0:3'h7]};
                     }

     cp_and_sr2_val: coverpoint (t_cov.instruction[2:0]) iff(t_cov.instruction[15:12] == AND && t_cov.instruction[5] == 1'b0){
                        bins and_sr2_val[] = {[3'h0:3'h7]};
                     }

     cp_pcoffset9: coverpoint (t_cov.instruction[8:0]) iff(t_cov.instruction[15:12] == LD || t_cov.instruction[15:12] == LDI || t_cov.instruction[15:12] == LEA || t_cov.instruction[15:12] == ST || t_cov.instruction[15:12] == STI || t_cov.instruction[15:12] == BR)  {
                     bins offset9_bit_zero[] = {[9'b0:9'b1]};
                     bins offset9_bit_one_toggle      = {[9'b000000010: 9'b000000011]};
                     bins offset9_bit_two_toggle      = {[9'b000000100: 9'b000000111]};
                     bins offset9_bit_three_toggle    = {[9'b000001000: 9'b000001111]};
                     bins offset9_bit_four_toggle     = {[9'b000010000: 9'b000011111]};
                     bins offset9_bit_five_toggle     = {[9'b000100000: 9'b000111111]};
                     bins offset9_bit_six_toggle      = {[9'b001000000: 9'b001111111]};
                     bins offset9_bit_seven_toggle    = {[9'b010000000: 9'b011111111]};
                     bins offset9_bit_eight_toggle    = {[9'b100000000: 9'b111111111]};
                     }

     cp_pcoffset6: coverpoint (t_cov.instruction[5:0]) iff(t_cov.instruction[15:12] == LDR || t_cov.instruction[15:12] == STR)  {
                     bins offset6_bit_zero[] = {[6'b0:6'b1]};
                     bins offset6_bit_one_toggle      = {[6'b000010: 6'b000011]};
                     bins offset6_bit_two_toggle      = {[6'b000100: 6'b000111]};
                     bins offset6_bit_three_toggle    = {[6'b001000: 6'b001111]};
                     bins offset6_bit_four_toggle     = {[6'b010000: 6'b011111]};
                     bins offset6_bit_five_toggle     = {[6'b100000: 6'b111111]};
                     }

     cp_baser_val: coverpoint (t_cov.instruction[8:6]) iff(t_cov.instruction[15:12] == LDR || t_cov.instruction[15:12] == STR || t_cov.instruction[15:12] == JMP){
                      bins baser[] = {[3'h0:3'h7]};
                   }

     cp_baser_instr: coverpoint(t_cov.instruction[15:12]) {
                       bins baser_instr[] = {LDR,STR,JMP};
                    }
     cp_offset6_instr: coverpoint (t_cov.instruction[15:12]) {
                          bins offset6_instr[] = {LDR,STR};
                       }
     cp_offset9_instr: coverpoint (t_cov.instruction[15:12]) {
                          bins offset9_instr[] = {LD,LDI,LEA,ST,STI,BR};
                       }
     cross_baser_instr: cross cp_baser_instr, cp_baser_val;
     cross_offset9_instr: cross cp_offset9_instr, cp_pcoffset9;
     cross_offset6_instr: cross cp_offset6_instr, cp_pcoffset6;

    // pragma uvmf custom covergroup end
  endgroup


// ****************************************************************************
  // FUNCTION: new
  function new(string name, uvm_component parent);
     super.new(name,parent);
    imem_coverage_cg=new;
  // pragma uvmf custom new begin
  // pragma uvmf custom new end
  endfunction

// ****************************************************************************
  // FUNCTION: build_phase
  virtual function void build_phase (uvm_phase phase);
    imem_coverage_cg.set_inst_name($sformatf("imem_coverage_cg_%s",get_full_name()));
    imem_cov_ae = new("imem_cov_ae", this);
  // pragma uvmf custom build_phase begin

  // pragma uvmf custom build_phase end
  endfunction

  // ****************************************************************************
  // FUNCTION: write_imem_cov_ae
  // Transactions received through imem_cov_ae initiate the execution of this function.
  // This function collects functional coverage on variables within the received transaction
  virtual function void write_imem_cov_ae(imem_transaction t);
    // pragma uvmf custom imem_cov_ae_coverage begin
    `uvm_info("COV", "Transaction Received through imem_cov_ae", UVM_MEDIUM)
    `uvm_info("COV", {"            Data: ",t.convert2string()}, UVM_NONE)
     t_cov = t;
     if(t_cov.instruction[15:12] == ADD || t_cov.instruction[15:12] == AND || t_cov.instruction[15:12] == NOT )  alu = 1;
     if(t_cov.instruction[15:12] == LD  || t_cov.instruction[15:12] == LDR || t_cov.instruction[15:12] == LDI || t_cov.instruction[15:12] == LEA) ld = 1;
     if(t_cov.instruction[15:12] == ST  || t_cov.instruction[15:12] == STR || t_cov.instruction[15:12] == STI )  str = 1;
     if(t_cov.instruction[15:12] == BR  || t_cov.instruction[15:12] == JMP )  flow_switch = 1;
     if(first == 1'b1) prev_t_cov = t;
    //  UVMF_CHANGE_ME: Add functional coverage to this component to implement coverage model.  
    //imem_coverage_cg.sample(alu,mem,ld,str,flow_switch);
    imem_coverage_cg.sample();
    prev_t_cov = t;
    first = 1'b0;
    alu = 0;
    ld = 0;
    str = 0;
    flow_switch = 0;
    // pragma uvmf custom imem_cov_ae_coverage end
  endfunction

endclass 

// pragma uvmf custom external begin
// pragma uvmf custom external end


