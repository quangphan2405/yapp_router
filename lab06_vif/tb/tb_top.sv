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

// include the testbench
`include "router_tb.sv"

// include the test library
`include "router_test_lib.sv"

   // Hardware top level
   hw_top hardware();
      
initial begin
   // set the interface
   yapp_vif_config::set(null, "*.tb.yapp.tx_agent.*", "vif", hardware.in0);

   // Start the test
   run_test();
end
      
endmodule : tb_top
