module data_gen
(
    input   clk, resetn,

    output[511:0] AXIS_TDATA,
    output reg    AXIS_TVALID,
    output        AXIS_TLAST,
    input         AXIS_TREADY
);


reg[31:0] delay;
reg[ 1:0] fsm_state;
reg[15:0] data;
reg[ 7:0] cycle_count;


assign AXIS_TDATA = {32{data}};
assign AXIS_TLAST = (cycle_count == 4);

always @(posedge clk) begin
    
    if (delay) delay <= delay - 1;
    
    if (resetn == 0) begin
        fsm_state <= 0;

    end else case (fsm_state)

        0:  begin
                delay     <= 200000000;
                fsm_state <= fsm_state + 1;
            end

        1:  if (delay == 0) begin
                data        <= 1;
                cycle_count <= 1;
                AXIS_TVALID <= 1;
                fsm_state   <= fsm_state + 1;
            end


        2:  if (AXIS_TVALID & AXIS_TREADY) begin
                data <= data + 1;
                if (AXIS_TLAST)
                    cycle_count <= 1;
                else
                    cycle_count <= cycle_count + 1;
            end


    endcase


end


endmodule