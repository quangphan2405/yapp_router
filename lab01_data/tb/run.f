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

// compile files
//*** add compile files here
../sv/yapp_pkg.sv // compile YAPP package
top.sv // compile top level module
