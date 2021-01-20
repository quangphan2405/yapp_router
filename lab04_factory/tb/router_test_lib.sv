class base_test extends uvm_test;

   // UVM component utility macro
   `uvm_component_utils(base_test)

   // Testbench handle
   router_tb tb;

   // Constructor
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   // Build_phase method
   virtual function void build_phase(uvm_phase phase);
      uvm_config_int::set(this, "*", "recording_detail", 1);
      super.build_phase(phase);      
      `uvm_info("BUILD", "Build phase of test is being executed", UVM_HIGH)
      uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
			      "default_sequence", yapp_5_packets::get_type());
      tb = router_tb::type_id::create("tb", this);
   endfunction : build_phase

   // Print topology
   function void end_of_elaboration_phase(uvm_phase phase);
      uvm_top.print_topology();
   endfunction : end_of_elaboration_phase

   // Check configuration after run
   function void check_phase(uvm_phase phase);
      check_config_usage();
   endfunction : check_phase
   
endclass : base_test


class test2 extends base_test;

   `uvm_component_utils(test2)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

endclass : test2


class short_packet_test extends base_test;

   // UVM component utility macro
   `uvm_component_utils(base_test)

   // Constructor
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   // Build_phase method
   virtual function void build_phase(uvm_phase phase);
      // Enable transaction recording
      uvm_config_int::set(this, "*", "recording_detail", 1);
      
      // Change packet type to short_yapp_packet
      set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());

      // Build
      super.build_phase(phase);
      
      // Set sequencer to execute generated sequence
      `uvm_info("BUILD", "Build phase of test is being executed", UVM_HIGH)
      uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
			      "default_sequence", yapp_5_packets::get_type());

      // Create testbench instance
      tb = router_tb::type_id::create("tb", this);
   endfunction : build_phase

endclass : short_packet_test
