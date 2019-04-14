module BidirectionalSinglePortIO #
(
  parameter DATA_WIDTH = 8,
  parameter ADDR_WIDTH = 4,
  parameter RAM_LENGTH = 16,
  parameter RAM_DEPTH = 1 << (ADDR_WIDTH-1)
)
(
    input clk,
    input rst,

    input [ADDR_WIDTH-1:0] ram_addr,
    input [DATA_WIDTH-1:0] ram_d,
    input ram_req,
    input ram_we,
    output reg [DATA_WIDTH-1:0] ram_q,
    output [ADDR_WIDTH-1:0] ram_len,
  
    input wire signed [DATA_WIDTH-1:0] in_io_ports0,
    input wire signed [DATA_WIDTH-1:0] in_io_ports1,
    input wire signed [DATA_WIDTH-1:0] in_io_ports2,
    input wire signed [DATA_WIDTH-1:0] in_io_ports3,
    input wire signed [DATA_WIDTH-1:0] in_io_ports4,
    input wire signed [DATA_WIDTH-1:0] in_io_ports5,
    input wire signed [DATA_WIDTH-1:0] in_io_ports6,
    input wire signed [DATA_WIDTH-1:0] in_io_ports7,
    input wire signed [DATA_WIDTH-1:0] in_io_ports8,
    input wire signed [DATA_WIDTH-1:0] in_io_ports9,
    output reg signed [DATA_WIDTH-1:0] out_io_ports0,
    output reg signed [DATA_WIDTH-1:0] out_io_ports1,
    output reg signed [DATA_WIDTH-1:0] out_io_ports2,
    output reg signed [DATA_WIDTH-1:0] out_io_ports3,
    output reg signed [DATA_WIDTH-1:0] out_io_ports4,
    output reg signed [DATA_WIDTH-1:0] out_io_ports5,
    output reg signed [DATA_WIDTH-1:0] out_io_ports6,
    output reg signed [DATA_WIDTH-1:0] out_io_ports7,
    output reg signed [DATA_WIDTH-1:0] out_io_ports8,
    output reg signed [DATA_WIDTH-1:0] out_io_ports9
);
  assign ram_len = RAM_LENGTH;
    
  always @ (posedge clk) begin
    if (ram_req == 1) begin
        case (ram_addr)
          0: begin
            ram_q <= in_io_ports0;
          end
          1: begin
            ram_q <= in_io_ports1;
          end
          2: begin
            ram_q <= in_io_ports2;
          end
          3: begin
            ram_q <= in_io_ports3;
          end
          4: begin
            ram_q <= in_io_ports4;
          end
          5: begin
            ram_q <= in_io_ports5;
          end
          6: begin
            ram_q <= in_io_ports6;
          end
          7: begin
            ram_q <= in_io_ports7;
          end
          8: begin
            ram_q <= in_io_ports8;
          end
          9: begin
            ram_q <= in_io_ports9;
          end
        endcase

        if (ram_we == 1) begin
            case (ram_addr)
              0: begin
                out_io_ports0 <= ram_d;
              end
              1: begin
                out_io_ports1 <= ram_d;
              end
              2: begin
                out_io_ports2 <= ram_d;
              end
              3: begin
                out_io_ports3 <= ram_d;
              end
              4: begin
                out_io_ports4 <= ram_d;
              end
              5: begin
                out_io_ports5 <= ram_d;
              end
              6: begin
                out_io_ports6 <= ram_d;
              end
              7: begin
                out_io_ports7 <= ram_d;
              end
              8: begin
                out_io_ports8 <= ram_d;
              end
              9: begin
                out_io_ports9 <= ram_d;
              end
            endcase
        end
     end
  end
endmodule
