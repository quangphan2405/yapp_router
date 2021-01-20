class yapp_tx_monitor extends uvm_monitor;

   `uvm_component_utils(yapp_tx_monitor)

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   virtual task run_phase(uvm_phase phase);
      `uvm_info("INFO", "You are in the monitor!", UVM_LOW)
   endtask : run_phase

   function void start_of_simulation_phase(uvm_phase phase);
      `uvm_info(get_type_name(), {"Simulation starts for: ", get_full_name()}, UVM_HIGH)
   endfunction : start_of_simulation_phase

endclass : yapp_tx_monitor
