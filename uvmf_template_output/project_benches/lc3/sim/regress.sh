make clean
rm -rf transcript_folder
rm -rf ./lc3_TestPlan.ucdb 
rm -rf ./sim_and_testplan_merged.ucdb
rm -rf ./covhtmlreport
make debug_proj
make convert_testplan
mkdir transcript_folder
make local_debug_cli
cp transcript transcript_folder/mix_transcript
make local_debug_cli NEW_SEQ_TYPE=imem_alu_responder_sequence  
cp transcript transcript_folder/alu_transcript
make local_debug_cli NEW_SEQ_TYPE=imem_mem_responder_sequence  
cp transcript transcript_folder/mem_transcript
make local_debug_cli NEW_SEQ_TYPE=imem_ctrl_switch_responder_sequence  
cp transcript transcript_folder/ctrl_transcript
make local_debug_cli NEW_SEQ_TYPE=imem_raw_responder_sequence  
cp transcript transcript_folder/raw_transcript
make local_debug_cli NEW_SEQ_TYPE=imem_waw_responder_sequence  
cp transcript transcript_folder/waw_transcript
make local_debug_cli NEW_SEQ_TYPE=imem_war_responder_sequence  
cp transcript transcript_folder/war_transcript
make local_debug_cli NEW_SEQ_TYPE=imem_misc_responder_sequence  
cp transcript transcript_folder/misc_transcript
make merge_coverage
make report_coverage
