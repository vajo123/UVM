`ifndef MONITOR_AXI_STREAM_MASTER_SV
`define MONITOR_AXI_STREAM_MASTER_SV

class monitor_axi_stream_master extends uvm_monitor;

    `uvm_component_utils(monitor_axi_stream_master)

    title_config cfg;
    seq_item_master item;
    virtual interface title_interface vif;
    uvm_analysis_port #(seq_item_master) port_axis; //sends items to scoreboard

    function new(string name = "monitor_axi_stream_master", uvm_component parent = null);
        super.new(name,parent);  
        port_axis = new("port_axis", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);

        if (!uvm_config_db#(virtual title_interface)::get(this, "", "title_interface", vif))
            `uvm_fatal("NOVIF",{"virtual interface must be set:",get_full_name(),".vif"})
        
        if(!uvm_config_db#(title_config)::get(this, "", "title_config", cfg))
            `uvm_fatal("NOCONFIG",{"Config object must be set for: ",get_full_name(),".cfg"})
    endfunction : connect_phase

    task main_phase(uvm_phase phase);
        item = seq_item_master::type_id::create("item",this);
        
        forever begin
            @(negedge vif.clk) begin // pos ili neg???
                if(vif.axim_s_ready && vif.axim_s_valid) begin
                    item.axim_s_data.push_back(vif.axim_s_data);
                                        
                    if(vif.axim_s_last) begin
                        port_axis.write(item);
                        //$display(" = > MONITOR SEND %d",item.axim_s_data.size);
                        item.axim_s_data.delete();
                    end
                end
            end
        end
        
    endtask : main_phase


endclass : monitor_axi_stream_master

`endif
