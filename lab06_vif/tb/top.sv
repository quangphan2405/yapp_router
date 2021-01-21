module top;
   // import the UVM library
   import uvm_pkg::*;

   // include the UVM macros
`include "uvm_macros.svh"

   // include testbench top level
`include "tb_top.sv"

   // inlucde clock generation
`include "clkgen.sv"
   
   // include hardware top level
`include "hw_top.sv"

endmodule : top
