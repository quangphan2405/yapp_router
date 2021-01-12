/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab01_data top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module top;
// import the UVM library
// include the UVM macros
   import uvm_pkg::*;
`include "uvm_macros.svh"   

// import the YAPP package
   import yapp_pkg::*;

// generate 5 random packets and use the print method
// to display the results
   yapp_packet p1, p2, p3;
   int ok;
         
   initial begin : TEST
      $display("Generate 5 random packets");      
      repeat (5) begin : GENERATE
	 p1 = new("p1");
	 ok = p1.randomize();
	 p1.print();
      end
      
      $display("\nExperiment with UVM copy");
      p2 = new("p2");      
      p2.copy(p1);
      p2.print();

      $display("\nExperiment with UVM clone");
      $cast(p3, p1.clone());
      p3.print();

      $display("\nExperiment with UVM print method:");
      $display("*** TREE printer ***");
      p3.print(uvm_default_tree_printer);
      $display("\n*** LINE printer ***");
      p3.print(uvm_default_line_printer);
      
      $display("\nTEST COMPLETE");
      $finish;      
   end // block: TEST
   
endmodule : top
