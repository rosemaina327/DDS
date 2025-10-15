`ifndef ASTEP_IFS
`define ASTEP_IFS

typedef logic [7:0] byte_t;
typedef logic [15:0] word_t;

package axi_ifs;
endpackage

/// An AXIS Interface
interface AXIS #(
    parameter int unsigned AXIS_ADDR_WIDTH = 4,
    parameter int unsigned AXIS_ID_WIDTH = 2,
    parameter int unsigned AXIS_USER_WIDTH = 4,
    parameter int unsigned AXIS_DATA_WIDTH = 8
  );
  
    localparam int unsigned AXIS_STRB_WIDTH = AXIS_DATA_WIDTH / 8;

    typedef logic [3:0] addr_t;
    typedef logic [1:0]   id_t;
    typedef logic [3:0] user_t;
    typedef logic [7:0] data_t;

    addr_t    tdest;
    id_t      tid;
    data_t    tdata;
    logic     tkeep;
    logic     tvalid;
    logic     tlast;
    logic     tready;
    user_t    tuser;


    modport master (
        output tdata,tdest,tid,tuser, tvalid,tlast,
        input tready
    );

    modport master_without_sideband (
        output tdata, tvalid,tlast,
        input tready
    );

        modport slave (
        input tdata,tdest,tid,tuser, tvalid,tlast,
        output tready
    );

     task automatic reset_master();
        
        tdest   <= 0;
        tid     <= 0;
        tuser   <= 0;
        tvalid  <= 1'b0;
        tlast   <= 1'b0;
        

    endtask

    task automatic reset_slave();
        tready <= 1'b0;
    endtask

    task automatic m_write_start(input addr_t dest,input id_t vid, input data_t data);
        
        tvalid <= 1'b1;
        tdest   <= dest;
        tid     <= vid;
        tdata   <= data;

    endtask

    task automatic m_write_single(input addr_t dest,input id_t vid, input data_t data);
        
        tvalid  <= 1'b1;
        tlast   <= 1'b1;
        tdest   <= dest;
        tid     <= vid;
        tdata   <= data;

    endtask

    task automatic m_write_last(input data_t data);
        
        tvalid <= 1'b1;
        tlast   <= 1'b1;
        tdata   <= data;

    endtask

    task automatic m_invalid();
        
        tvalid  <= 1'b0;
        tlast   <= 1'b0;

    endtask

    task automatic m_last();
        tlast   <= 1'b1;
    endtask

    task automatic m_write_data(input data_t data);
        
        tvalid <= 1'b1;
        tdata   <= data;

    endtask

    task automatic s_accept();
        tready <= 1'b1;
    endtask

    task automatic s_not_ready();
        tready <= 1'b0;
    endtask
     

endinterface



`endif 