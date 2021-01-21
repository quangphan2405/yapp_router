/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab01_data top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module tb_top;
// import the UVM library
// include the UVM macros
   import uvm_pkg::*;
`include "uvm_macros.svh"   

// import the YAPP package
   import yapp_pkg::*;

// include the testbench
`include "router_tb.sv"

// include the test library
`include "router_test_lib.sv"   
   
initial begin
   // set the interface
   yapp_vif_config::set(null, "uvm_test_top,tb.yapp.*", "vif", hw_top.in0);

   // Start the test
   run_test("base_test");
end
      
endmodule : tb_top
