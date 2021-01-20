class yapp_env extends uvm_env;

   `uvm_component_utils(yapp_env)

   yapp_tx_agent agent;
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      agent = new("agent", this);
   endfunction : build_phase

endclass : yapp_env
