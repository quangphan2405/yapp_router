class router_simple_mcseq extends uvm_sequence;

   // Required macro for sequences automation
   `uvm_object_utils(router_simple_mcseq)

   // Sequence handle
   yapp_012_seq yapp_012;
   yapp_rnd_seq yapp_rnd;
   hbus_small_packet_seq h_small;
   hbus_set_default_regs_seq h_large;
   hbus_read_max_pkt_seq read_max_pkt;
   
   // Constructor
   function new(string name="router_simple_mcseq");
      super.new(name);
   endfunction : new

   // Access multichannel sequencer
   `uvm_declare_p_sequencer(router_mcsequencer)

   task pre_body();
      uvm_phase phase;
      `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
      `else
      phase = starting_phase;
      `endif
      if (phase != null) begin
	 phase.raise_objection(this, get_type_name());
	 `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
      end
   endtask : pre_body

   task body(uvm_phase phase);
      `uvm_info(get_type_name(), "Executing router_simple_mcseq sequence", UVM_LOW)

      // Set router to accept small packets and check the setting
      `uvm_do(h_small, p_sequencer.hbus_seqr)
      `uvm_do(read_max_pkt, p_sequencer.hbus_seqr)

      // Send 6 consecutive packs to address 0, 1, 2
      repeat (6)
	`uvm_do(yapp_012, p_sequencer.yapp_seqr)

      // Set router to accept large packets and check the setting
      `uvm_do(h_large, p_sequencer.hbus_seqr)
      `uvm_do(read_max_pkt, p_sequencer.hbus_seqr)

      // Send a random sequencer of 6 packets
      `uvm_do_with(yapp_rnd, p_sequencer.yapp_seqr, { count == 6; })
   endtask : body   

   task post_body();
      uvm_phase phase;
      `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
      `else
      phase = starting_phase;
      `endif
      if (phase != null) begin
	 phase.drop_objection(this, get_type_name());
	 `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
      end
   endtask : post_body

endclass : router_simple_mcseq
