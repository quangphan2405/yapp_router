class router_tb extends uvm_env;

   `uvm_component_utils(router_tb)

   yapp_env yapp;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      `uvm_info("BUILD", "Build phase of tb is being executed", UVM_HIGH)
      yapp = yapp_env::type_id::create("yapp", this);
   endfunction : build_phase

   function void start_of_simulation_phase(uvm_phase phase);
      `uvm_info(get_type_name(), {"Simulation starts for: ", get_full_name()}, UVM_HIGH)
   endfunction : start_of_simulation_phase

endclass : router_tb
