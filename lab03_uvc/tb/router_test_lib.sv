class base_test extends uvm_test;

   `uvm_component_utils(base_test)

   router_tb tb;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);      
      `uvm_info("BUILD", "Build phase of test is being executed", UVM_HIGH)
      uvm_config_wrapper::set(this, "tb.yapp.tx_agent.sequencer.run_phase",
			      "default_sequence", yapp_5_packets::get_type());
      tb = new("tb", this);
   endfunction : build_phase

   function void end_of_elaboration_phase(uvm_phase phase);
      uvm_top.print_topology();
   endfunction : end_of_elaboration_phase

endclass : base_test


class test2 extends base_test;

   `uvm_component_utils(test2)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

endclass : test2
