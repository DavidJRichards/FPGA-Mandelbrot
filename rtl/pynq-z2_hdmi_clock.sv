`timescale 1ns / 1ns

module hdmi_clock
  #(
     parameter int VIDEO_ID_CODE = 1
   )
   (
     input logic clk_125,
     output logic clk_pixel,
     output logic clk_pixel_x5
   );
  generate
    case (VIDEO_ID_CODE)
      1:  // 640x480 25.2MHz
        mmcm_xilinx  #(.MULT_F(16.125), .DIVCLK_DIVIDE(2), .DIV1_F(40.0), .DIV2(8), .CLKIN_PERIOD(8.0))
        clk_cnv (.clk_in(clk_125), .clk_out1(clk_pixel), .clk_out2(clk_pixel_x5));
      4:  // 1280x720 74.25MHz
        mmcm_xilinx  #(.MULT_F(62.375), .DIVCLK_DIVIDE(7), .DIV1_F(15.0), .DIV2(3), .CLKIN_PERIOD(8.0))
        clk_cnv (.clk_in(clk_125), .clk_out1(clk_pixel), .clk_out2(clk_pixel_x5));
      5:  // 800x600 40.0MHz
        mmcm_xilinx  #(.MULT_F(8.00), .DIVCLK_DIVIDE(1), .DIV1_F(25.0), .DIV2(5), .CLKIN_PERIOD(8.0))
        clk_cnv (.clk_in(clk_125), .clk_out1(clk_pixel), .clk_out2(clk_pixel_x5));
      6:  // 1024x600 48.964 MHz
        mmcm_xilinx  #(.MULT_F(23.5), .DIVCLK_DIVIDE(3), .DIV1_F(20.0), .DIV2(4), .CLKIN_PERIOD(8.0))
        clk_cnv (.clk_in(clk_125), .clk_out1(clk_pixel), .clk_out2(clk_pixel_x5));
      16:  // 1920x1080  	148.5MHz
        mmcm_xilinx  #(.MULT_F(11.875), .DIVCLK_DIVIDE(2), .DIV1_F(5.0), .DIV2(1), .CLKIN_PERIOD(8.0))
        clk_cnv (.clk_in(clk_125), .clk_out1(clk_pixel), .clk_out2(clk_pixel_x5));
    endcase
  endgenerate
endmodule
