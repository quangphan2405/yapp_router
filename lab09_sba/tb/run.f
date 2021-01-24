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

// options
+UVM_VERBOSITY=UVM_LOW
+UVM_TESTNAME=multichannel_test

// include directories
//*** add incdir include directories here
-incdir ../sv // include directory for sv files
-incdir ../../yapp/sv            // incude directory for YAPP UVC
-incdir ../../channel/sv         // include directory for channel UVC
-incdir ../../hbus/sv            // include directory for HBUS UVC
-incdir ../../clock_and_reset/sv // include directory for clock_and_reset UVC

// set default timescale
-timescale 1ns/100ps

// compile files
//*** add compile files here
../../yapp/sv/yapp_pkg.sv 			// compile YAPP package
../../yapp/sv/yapp_if.sv  			// compile YAPP interface
../../channel/sv/channel_pkg.sv 		// compile channel package
../../channel/sv/channel_if.sv 			// compile channel interface
../../hbus/sv/hbus_pkg.sv 			// compile HBUS package
../../hbus/sv/hbus_if.sv 			// compile HBUS interface
../../clock_and_reset/sv/clock_and_reset_pkg.sv // compile clock_and_reset package
../../clock_and_reset/sv/clock_and_reset_if.sv  // compile clock_and_reset interface

clkgen.sv // compile clock generation
../../router_rtl/yapp_router.sv // compile yapp router
hw_top.sv // compile hardware top level
tb_top.sv // compile top level module
