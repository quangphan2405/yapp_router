class yapp_tx_driver extends uvm_driver #(yapp_packet);

   `uvm_component_utils(yapp_tx_driver)   
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void start_of_simulation_phase(uvm_phase phase);
      `uvm_info(get_type_name(), {"Simulation starts for: ", get_full_name()}, UVM_HIGH)
   endfunction : start_of_simulation_phase

   virtual task run_phase(uvm_phase phase);
      forever begin
	 seq_item_port.get_next_item(req);
	 send_to_dut(req);
	 seq_item_port.item_done();
      end
   endtask : run_phase

   virtual task send_to_dut(yapp_packet packet);
      `uvm_info(get_type_name(), $sformatf("Packet is \n%s", packet.sprint()), UVM_LOW)
      #10ns;
   endtask : send_to_dut   
   
endclass : yapp_tx_driver
