class router_tb extends uvm_env;

   `uvm_component_utils(router_tb)

   // YAPP UVC environment handle
   yapp_env yapp;

   // Channel UVC environment hanldes
   channel_env chan0;
   channel_env chan1;
   channel_env chan2;

   // HBUS UVC environment handle
   hbus_env hbus;

   // Clock and Reset UVC environment handle
   clock_and_reset_env clk_rst;
            
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // Create clock_and_reset UVC instance
      clk_rst = clock_and_reset_env::type_id::create("clk_rst", this);
      
      // Create YAPP UVC instance
      yapp = yapp_env::type_id::create("yapp", this);

      // Configuration set channel_id of channels
      uvm_config_int::set(this, "chan0", "channel_id", 0);
      uvm_config_int::set(this, "chan1", "channel_id", 1);
      uvm_config_int::set(this, "chan2", "channel_id", 2);
      // Create channel UVC instances
      chan0 = channel_env::type_id::create("chan0", this);
      chan1 = channel_env::type_id::create("chan1", this);
      chan2 = channel_env::type_id::create("chan2", this);

      // Configuration set num_masters and num_slaves of hbus
      uvm_config_int::set(this, "hbus", "num_masters", 1);
      uvm_config_int::set(this, "hbus", "num_slaves", 0);
      // Create HBUS UVC instance
      hbus = hbus_env::type_id::create("hbus", this);   
   endfunction : build_phase

endclass : router_tb
