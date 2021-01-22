class router_tb extends uvm_env;

   `uvm_component_utils(router_tb)

   // YAPP UVC environment handle
   yapp_env yapp;

   // Channel UVC environment hanldes
   channel_env chan0;
   channel_env chan1;
   channel_env chan2;
      
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      // Create YAPP UVC environment
      yapp  = yapp_env::type_id::create("yapp", this);

      // Create channel UVC environment
      chan0 = channel_env::type_id::create("chan0", this);
      chan1 = channel_env::type_id::create("chan1", this);
      chan2 = channel_env::type_id::create("chan2", this);

      // Configuration set channel_id
      uvm_config_int::set(this, "chan0", "channel_id", 0);
      uvm_config_int::set(this, "chan1", "channel_id", 1);
      uvm_config_int::set(this, "chan2", "channel_id", 2);
   endfunction : build_phase

endclass : router_tbclass router_tb extends uvm_env;

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
