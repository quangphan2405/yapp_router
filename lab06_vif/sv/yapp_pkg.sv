package yapp_pkg;

   // UVM package and macro file
   import uvm_pkg::*;
`include "uvm_macros.svh"

   // Type for connecting interface
   typedef uvm_config_db#(virtual yapp_if) yapp_vif_config;

// User-defined SV files
`include "yapp_packet.sv"
`include "yapp_tx_monitor.sv"
`include "yapp_tx_sequencer.sv"
`include "yapp_tx_seqs.sv"
`include "yapp_tx_driver.sv"
`include "yapp_tx_agent.sv"
`include "yapp_env.sv"
   
endpackage : yapp_pkg
   
