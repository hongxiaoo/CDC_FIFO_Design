module axis_upsizer #(
  parameter int ADDR_WIDTH = 4,
  parameter int DATA_WIDTH = 8,
  parameter int DATA_RATIO = 8,
  parameter int S_DATA_WIDTH = DATA_WIDTH,
  parameter int M_DATA_WIDTH = DATA_RATIO*DATA_WIDTH
  ) (
  input  logic                    aclk,
  input  logic                    areset,
  
  input  logic [S_DATA_WIDTH-1:0] s_axis_tdata,
  input  logic                    s_axis_tvalid,
  input  logic                    s_axis_tlast,
  output logic                    s_axis_tready,
  
  output logic [M_DATA_WIDTH-1:0] m_axis_tdata,
  output logic                    m_axis_tvalid,
  output logic                    m_axis_tlast,
  input  logic                    m_axis_tready
  );
  
  generate for(genvar i=0; i<=DATA_RATIO; i++) begin : gen
    sync_fifo_core #(
      .ADDR_WIDTH(ADDR_WIDTH),
      .DATA_WIDTH(DATA_WIDTH)
    ) fifo_core_inst (
      .clk    (clk),
      .reset  (reset),
      .wen    (wen),
      .wdata  (wdata),
      .wfull  (wfull),
      .ren    (ren),
      .rdata  (rdata),
      .rempty (rempty)
    );
  end endgenerate
  
endmodule