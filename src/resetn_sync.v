module resetn_sync
(
    input   src_arst,
    input   dst_clk,
    output  dest_inv_arst
);

    wire dest_arst;

    xpm_cdc_async_rst #
    (
        .DEST_SYNC_FF(4),    
        .INIT_SYNC_FF(0),    
        .RST_ACTIVE_HIGH(0)  
    )
    xpm_cdc_async_rst_inst
    (
        .dest_arst  (dest_arst),
        .dest_clk   (dest_clk),   
        .src_arst   (src_arst)   
    );

    assign dest_inv_arst = ~dest_arst;


endmodule