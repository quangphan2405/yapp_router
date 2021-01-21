class router_tb extends uvm_env;

   `uvm_component_utils(router_tb)

   yapp_env yapp;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      yapp = yapp_env::type_id::create("yapp", this);
   endfunction : build_phase

endclass : router_tb
