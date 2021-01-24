typedef enum bit {EQUALITY, UVM} comp_t;

class router_scoreboard extends uvm_scoreboard;

   // UVM component utility macro
   `uvm_component_utils(router_scoreboard)

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
   [yapp_packet] sb_queue0 [$];
   [yapp_packet] sb_queue1 [$];
   [yapp_packet] sb_queue2 [$];

   // Comparer policy
   comp_t comparer_policy;
      
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

   function void write_yapp(input yapp_packet yapp_pkt);
      yapp_packet yp;
      // Clone YAPP packet
      $cast(yp, yapp_pkt.clone());
      case (yp.addr)
	2'b00: begin
	   sb_queue0.push_back(yp);
	   `uvm_info(get_type_name(), "Added packet to Scoreboard Queue 0", UVM_HIGH)
	end
	2'b01: begin
	   sb_queue1.push_back(yp);
	   `uvm_info(get_type_name(), "Added packet to Scoreboard Queue 1", UVM_HIGH)
	end
	2'b10: begin
	   sb_queue2.push_back(yp);
	   `uvm_info(get_type_name(), "Added packet to Scoreboard Queue 2", UVM_HIGH)
	end
	default: begin
	   `uvm_info(get_type_name(), "Packet dropped due to illegal address", UVM_HIGH)
	end
      endcase // case (yp.addr)
   endfunction : write_yapp

   
	
	

   
   
