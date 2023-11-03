`ifndef SIMPLE_SEQ_LITE_SV
`define SIMPLE_SEQ_LITE_SV

class simple_seq_lite extends base_seq_lite;

    `uvm_object_utils(simple_seq_lite)

    logic[31:0] command_or_possitinon;
    integer offset_reg;
	
    seq_item_lite item;

    function new(string name = "simple_seq_lite");
      super.new(name);  
    endfunction

    virtual task body();   
        item = seq_item_lite::type_id::create("item");
        `uvm_info(get_name(), $sformatf("SENDING COMMAND OR POSSITION"),   UVM_HIGH) 

        start_item(item);
        item.COM_OR_POS = command_or_possitinon;
        item.offset = offset_reg;
        finish_item(item);
		//ovde mozemo da dodelimo sekvenci vrednost interapta
        `uvm_info(get_name(), $sformatf("COMMAND OR POSSITION SENT %h, OFFSET: %d", command_or_possitinon, offset_reg),   UVM_HIGH) 
    endtask : body

endclass : simple_seq_lite
`endif
