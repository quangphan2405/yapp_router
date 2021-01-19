class router_tb extends uvm_env;

   `uvm_component_utils(router_tb)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("BUILD", "Build phase of tb is being executed", UVM_HIGH)
   endfunction : build_phase

endclass : router_tb
