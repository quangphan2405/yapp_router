/*-----------------------------------------------------------------
File name     : yapp_packet.sv
Description   : lab01_data YAPP UVC packet template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

// Define your enumerated type(s) here
typedef enum bit { GOOD_PARITY, BAD_PARITY } parity_t;

class yapp_packet extends uvm_sequence_item;

// Follow the lab instructions to create the packet.
// Place the packet declarations in the following order:

  // Define protocol data
   rand bit [1:0] addr;
   rand bit [5:0] length;
   rand bit [7:0] payload[];
   bit [7:0] parity;
   rand parity_t parity_type;
   rand int packet_delay;

  // Define control knobs

  // Enable automation of the packet's fields
   `uvm_object_utils_begin(yapp_packet)
      `uvm_field_int(addr, UVM_ALL_ON)
      `uvm_field_int(length, UVM_ALL_ON)
      `uvm_field_array_int(payload, UVM_ALL_ON)
      `uvm_field_int(parity, UVM_ALL_ON + UVM_BIN)
      `uvm_field_enum(parity_t, parity_type, UVM_ALL_ON)
      `uvm_field_int(packet_delay, UVM_ALL_ON + UVM_NOCOMPARE)
   `uvm_object_utils_end
   

  // Define packet constraints

  // Add methods for parity calculation and class construction

endclass: yapp_packet
