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
      super.build_phase(phase);  
      uvm_config_int::set(this, "*", "recording_detail", 1);
      `uvm_info("BUILD", "Build phase of test is being executed", UVM_HIGH)      
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
   `uvm_component_utils(short_packet_test)

   // Constructor
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   // Build_phase method
   virtual function void build_phase(uvm_phase phase);
      set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
      super.build_phase(phase);
      uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
			      "default_sequence", yapp_5_packets::get_type());
   endfunction : build_phase

endclass : short_packet_test

class set_config_test extends base_test;

   // UVM component utility macro
   `uvm_component_utils(set_config_test)

   // Constructor
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   // Build_phase method
   virtual function void build_phase(uvm_phase phase);
      // Configure agent to be passive
      uvm_config_int::set(this, "tb.yapp.tx_agent", "is_active", UVM_PASSIVE); 
      super.build_phase(phase);
      uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
			      "default_sequence", yapp_5_packets::get_type());      
   endfunction : build_phase

endclass : set_config_test

class incr_payload_test extends base_test;

   // UVM component utility macro
   `uvm_component_utils(incr_payload_test)

   // Constructor
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   // Build_phase method
   virtual function void build_phase(uvm_phase phase);
      set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type()); 
      super.build_phase(phase);
      uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
			      "default_sequence", yapp_incr_payload_seq::get_type());     
   endfunction : build_phase

endclass : incr_payload_test

class exhaustive_seq_test extends base_test;
   
   // UVM component utility macro
   `uvm_component_utils(exhaustive_seq_test)

   // Constructor
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   // Build_phase method
   virtual function void build_phase(uvm_phase phase);
      yapp_packet::type_id::set_type_override(short_yapp_packet::get_type()); 
      super.build_phase(phase);
      uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
			      "default_sequence", yapp_exhaustive_seq::get_type());     
   endfunction : build_phase

endclass : exhaustive_seq_test
