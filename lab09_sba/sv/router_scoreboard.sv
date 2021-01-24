typedef enum bit {EQUALITY, UVM} comp_t;

class router_scoreboard extends uvm_scoreboard;   
   
   // Comparer policy
   comp_t comparer_policy = UVM;

   // UVM component utility macro
   `uvm_component_utils_begin(router_scoreboard)
      `uvm_field_enum(comp_t, comparer_policy, UVM_ALL_ON)
   `uvm_component_utils_end   

   // Analysis imp objects
   `uvm_analysis_imp_decl(_yapp)
   `uvm_analysis_imp_decl(_chan0)
   `uvm_analysis_imp_decl(_chan1)
   `uvm_analysis_imp_decl(_chan2)
   
   uvm_analysis_imp_yapp #(yapp_packet, router_scoreboard) sb_yapp_in;
   uvm_analysis_imp_chan0 #(channel_packet, router_scoreboard) sb_chan0_in;
   uvm_analysis_imp_chan1 #(channel_packet, router_scoreboard) sb_chan1_in;
   uvm_analysis_imp_chan2 #(channel_packet, router_scoreboard) sb_chan2_in;

   // Queues for each channel
   yapp_packet sb_queue0[$];
   yapp_packet sb_queue1[$];
   yapp_packet sb_queue2[$];

   // Counter for received, dropped, wrong and matched packets
   int 	     received_in, dropped_in;
   int 	     received_ch0, failed_ch0, matched_ch0, dropped_ch0;
   int 	     received_ch1, failed_ch1, matched_ch1, dropped_ch1;
   int 	     received_ch2, failed_ch2, matched_ch2, dropped_ch2;   
      
   // Constructor
   function new(string name, uvm_component parent);
      super.new(name, parent);
      sb_yapp_in = new("sb_yapp_in", this);
      sb_chan0_in = new("sb_chan0_in", this);
      sb_chan1_in = new("sb_chan1_in", this);
      sb_chan2_in = new("sb_chan2_in", this);
   endfunction : new

   // custom packet compare function using inequality operators
   function bit comp_equal (input yapp_packet yp, input channel_packet cp);
      // returns first mismatch only
      if (yp.addr != cp.addr) begin
        `uvm_error("PKT_COMPARE",$sformatf("Address mismatch YAPP %0d Chan %0d",yp.addr,cp.addr))
        return(0);
      end
      if (yp.length != cp.length) begin
        `uvm_error("PKT_COMPARE",$sformatf("Length mismatch YAPP %0d Chan %0d",yp.length,cp.length))
        return(0);
      end
      foreach (yp.payload [i])
        if (yp.payload[i] != cp.payload[i]) begin
          `uvm_error("PKT_COMPARE",$sformatf("Payload[%0d] mismatch YAPP %0d Chan %0d",i,yp.payload[i],cp.payload[i]))
          return(0);
        end
      if (yp.parity != cp.parity) begin
        `uvm_error("PKT_COMPARE",$sformatf("Parity mismatch YAPP %0d Chan %0d",yp.parity,cp.parity))
        return(0);
      end
      return(1);
   endfunction : comp_equal

   function bit comp_uvm(input yapp_packet yp, channel_packet cp, uvm_comparer comparer = null);
      string str;
      if (comparer == null)
	comparer = new();
      comp_uvm = comparer.compare_field("addr", yp.addr, cp.addr, 2);
      comp_uvm &= comparer.compare_field("length", yp.length, cp.length, 6);
      foreach (yp.payload[i]) begin
	 str.itoa(i);
	 comp_uvm &= comparer.compare_field({"payload[", str,"]"}, yp.payload[i], cp.payload[i], 8);
      end
      comp_uvm &= comparer.compare_field("parity", yp.parity, cp.parity, 8);
   endfunction : comp_uvm

   virtual function void write_yapp(input yapp_packet yp);
      received_in++;      
      yapp_packet yapp_pkt;
      // Clone YAPP packet
      $cast(yapp_pkt, yp.clone());
      case (yapp_pkt.addr)
	2'b00: begin
	   sb_queue0.push_back(yapp_pkt);
	   `uvm_info(get_type_name(), "Added packet to Scoreboard Queue 0", UVM_HIGH)
	end
	2'b01: begin
	   sb_queue1.push_back(yapp_pkt);
	   `uvm_info(get_type_name(), "Added packet to Scoreboard Queue 1", UVM_HIGH)
	end
	2'b10: begin
	   sb_queue2.push_back(yapp_pkt);
	   `uvm_info(get_type_name(), "Added packet to Scoreboard Queue 2", UVM_HIGH)
	end
	default: begin
	   dropped_in++;	   
	   `uvm_info(get_type_name(), "Packet dropped due to illegal address", UVM_HIGH)
	end
      endcase // case (yapp_pkt.addr)
   endfunction : write_yapp

   virtual function void write_chan0(input channel_packet cp);
      received_ch0++;
      yapp_packet yp;      
      bit compare;
      if (sb_queue0.size()) begin 
	`uvm_error(get_type_name(), $sformatf("Scoreboard Error [EMPTY]: Channel 0 received UNEXPECTED packet: \n%s", cp.sprint()))
	 dropped_ch0++;
      end

      if (comparer_policy == UVM)
	compare = comp_uvm(sb.queue0[0], cp);
      else
	compare = comp_equal(sb.queue0[0], cp);

      if (compare) begin
	 void'sb_queue0.pop_front();
	 `uvm_info(get_type_name(), $sformatf("Scoreboard Compare Match: Channel 0 received CORRECT packet: \n%s", cp.sprint()), UVM_HIGH)
	 matched_ch0++;
      end
      else begin
	 yp = sb.queue0[0];
	 `uvm_waring(get_type_name(), $sformatf("Scoreboard Error [MISMATCH]: Channel 0 received WRONG packet: \nExpected:\n%s\nGot:\n%s",
						yp.sprint(), cp.sprint()))
	 failed_ch0++;
      end 
   endfunction : write_chan0
   
   virtual function void write_chan1(input channel_packet cp);
      received_ch1++;
      yapp_packet yp;      
      bit compare;
      if (sb_queue1.size()) begin 
	`uvm_error(get_type_name(), $sformatf("Scoreboard Error [EMPTY]: Channel 1 received UNEXPECTED packet: \n%s", cp.sprint()))
	 dropped_ch1++;
      end

      if (comparer_policy == UVM)
	compare = comp_uvm(sb.queue1[0], cp);
      else
	compare = comp_equal(sb.queue1[0], cp);

      if (compare) begin
	 void'sb_queue1.pop_front();
	 `uvm_info(get_type_name(), $sformatf("Scoreboard Compare Match: Channel 1 received CORRECT packet: \n%s", cp.sprint()), UVM_HIGH)
	 matched_ch1++;
      end
      else begin
	 yp = sb.queue1[0];
	 `uvm_waring(get_type_name(), $sformatf("Scoreboard Error [MISMATCH]: Channel 1 received WRONG packet: \nExpected:\n%s\nGot:\n%s",
						yp.sprint(), cp.sprint()))
	 failed_ch1++;
      end 
   endfunction : write_chan1

   virtual function void write_chan2(input channel_packet cp);
      received_ch2++;
      yapp_packet yp;      
      bit compare;
      if (sb_queue2.size()) begin 
	`uvm_error(get_type_name(), $sformatf("Scoreboard Error [EMPTY]: Channel 2 received UNEXPECTED packet: \n%s", cp.sprint()))
	 dropped_ch2++;
      end

      if (comparer_policy == UVM)
	compare = comp_uvm(sb.queue2[0], cp);
      else
	compare = comp_equal(sb.queue2[0], cp);

      if (compare) begin
	 void'sb_queue2.pop_front();
	 `uvm_info(get_type_name(), $sformatf("Scoreboard Compare Match: Channel 2 received CORRECT packet: \n%s", cp.sprint()), UVM_HIGH)
	 matched_ch2++;
      end
      else begin
	 yp = sb.queue2[0];
	 `uvm_waring(get_type_name(), $sformatf("Scoreboard Error [MISMATCH]: Channel 2 received WRONG packet: \nExpected:\n%s\nGot:\n%s",
						yp.sprint(), cp.sprint()))
	 failed_ch2++;
      end 
   endfunction : write_chan2

   function void check_phase(uvm_phase phase);
      `uvm_info(get_type_name(), "Checking Router Scoreboard", UVM_LOW)
      if (sb_queue0.size() || sb_queue1.size() || sb_queue(3).size())
	`uvm_warning(get_type_name(), $sformatf("Router Scoreboard Not Empty:\nChannel 0: %0d\nChannel 1: %0d\nChannel 2: %0d",
		     sb_queue0.size(), sb_queue1.size(), sb_queue2.size()))
      else
	`uvm_info(get_type_name(), "Router Scoreboard Empty", UVM_LOW)
   endfunction : check_phase

   function void report_phase(uvm_phase phase);
      `uvm_info(get_type_name(), $sformatf("Router Scoreboard Statistics:\nChannel \t Received \t Failed \t Matched\n chan0  \t %0d \t %0d \t %0d\n chan1  \t %0d \t %0d \t %0d\n chan2  \t %0d \t %0d \t %0d",	received_ch0, failed_ch0, matched_ch0, received_ch1, failed_ch1, matched_ch1, received_ch2, failed_ch2, matched_ch2), UVM_LOW)
      if ((dropped_ch0 + dropped_ch1 + dropped_ch2 + failed_ch0 + failed_ch1 + failed_ch2) > 0)
	`uvm_error(get_type_name(), "Simulation FAILED!")
      else
	`uvm_info(get_type_name(), "Simulation PASSED!", UVM_NONE)
   endfunction : report_phase

endclass : router_scoreboard
