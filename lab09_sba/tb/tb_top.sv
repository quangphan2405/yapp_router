/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab01_data top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module tb_top;
   // import the UVM library
   import uvm_pkg::*;

// include the UVM macros
`include "uvm_macros.svh"   

   // import the YAPP package
   import yapp_pkg::*;

   // import the channel package
   import channel_pkg::*;

   // import the HBUS package
   import hbus_pkg::*;

   // import the clock_and_reset package
   import clock_and_reset_pkg::*;

// include the mc sequencer
`include "router_mcsequencer.sv"

// include the mc sequence
`include "router_mcseqs_lib.sv"

// include the scoreboard
`include "router_scoreboard.sv"   
   
// include the testbench
`include "router_tb.sv"

// include the test library
`include "router_test_lib.sv"
   
   // Hardware top level
   hw_top hardware();
      
initial begin
   // set the yapp interface
   yapp_vif_config::set(null, "*.tb.yapp.tx_agent.*", "vif", hardware.yapp_in0);

   // set the channel interface
   channel_vif_config::set(null, "*.tb.chan0.*", "vif", hardware.chan_in0);
   channel_vif_config::set(null, "*.tb.chan1.*", "vif", hardware.chan_in1);
   channel_vif_config::set(null, "*.tb.chan2.*", "vif", hardware.chan_in2);

   // set the HBUS interface
   hbus_vif_config::set(null, "*.tb.hbus.*", "vif", hardware.hbus_in0);

   // set the clock_and_reset interface
   clock_and_reset_vif_config::set(null, "*.tb.clk_rst.*", "vif", hardware.clk_rst_in0);
   
   // Start the test
   run_test();
end
      
endmodule : tb_top
