/*-----------------------------------------------------------------
File name     : run.f
Description   : lab01_data simulator run template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
              : Set $UVMHOME to install directory of UVM library
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/
// 64 bit option for AWS labs
-64

 -uvmhome $UVMHOME

// include directories
//*** add incdir include directories here
-incdir ../sv // include directory for sv files

// set default timescale
-timescale 1ns/1ns

// compile files
//*** add compile files here
../sv/yapp_pkg.sv // compile YAPP package
../sv/yapp_if.sv  // compile YAPP interface
clkgen.sv // compile clock generation
../../router_rtl/yapp_router.sv // compile yapp router
hw_top.sv // compile hardware top level
tb_top.sv // compile top level module
