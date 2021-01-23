class router_mcsequencer extends uvm_sequencer;

   // UVM component utility macro
   `uvm_component_utils(router_mcsequencer)

   // YAPP and HBUS UVC sequencer handles
   yapp_tx_sequencer yapp_seqr;
   hbus_master_sequencer hbus_seqr;
   
   // Constructor
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

endclass : router_mcsequencer
