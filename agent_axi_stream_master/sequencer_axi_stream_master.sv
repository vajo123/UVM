`ifndef SEQUENCER_AXI_STREAM_MASTER_SV
`define SEQUENCER_AXI_STREAM_MASTER_SV

class sequencer_axi_stream_master extends uvm_sequencer#(seq_item_master);

   `uvm_component_utils(sequencer_axi_stream_master)
   
   function new(string name = "sequencer_axi_stream_master", uvm_component parent = null);
      super.new(name,parent);
   endfunction

endclass : sequencer_axi_stream_master

`endif