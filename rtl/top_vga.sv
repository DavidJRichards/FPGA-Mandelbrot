`timescale 1ns / 1ns

module top_vga (
    input CLOCK_33,
    output logic[5:0] VGA_R,
    output logic[5:0] VGA_G,
    output logic[5:0] VGA_B,
    output logic VGA_HSYNC,
    output logic VGA_VSYNC,
    output logic vga_adv7123_clk,
    output logic vga_adv7123_blank,
    input PS2_CLOCK,
    input PS2_DATA
  );

  logic VGA_ACTIVE;
  logic [11:0] VGA_SCREEN_WIDTH;
  logic [11:0] VGA_SCREEN_HEIGHT;
  wire [11:0] frame_width;
  wire [11:0] frame_height;


  localparam USE_XILINX_BLOCKRAM = 1;

  localparam key_up = "w";
  localparam key_down = "s";
  localparam key_left = "a";
  localparam key_right = "d";
  localparam key_zoom_in = "q";
  localparam key_zoom_out = "e";
  localparam key_iter_up = "r";
  localparam key_iter_down = "f";

  localparam screen_div = 2;
  localparam num_engines = 4;

  localparam calc_clock_mult = 30;
  localparam calc_clock_div = 10;

  localparam width = 1024/screen_div;
  localparam height = 768/screen_div;

  localparam dimension_bits = $clog2(width - 1);
  localparam data_bits = 4;

  localparam fp_top = 6;
  localparam fp_bot = 44;

  wire clk_calc;
  wire clk_pixel;
  vga_clock  #(.VIDEO_ID_CODE(3)) vga_clock_inst (.clk_33(CLOCK_33), .clk_pixel(clk_pixel));
  
  assign vga_adv7123_clk = clk_pixel;
  assign vga_adv7123_blank = 1;



  pll_xilinx #(.MULT(calc_clock_mult), .DIV(calc_clock_div), .CLKIN_PERIOD(30.0)) pll1
             (
               .clk_in(CLOCK_33),
               .clk_out(clk_calc)
             );

  vga_timing_controller_preset #(.VIDEO_ID_CODE(3)) vga_0 (.clk_pixel(clk_pixel), .vga_hsync(VGA_HSYNC), .vga_vsync(VGA_VSYNC),
                               .vga_x(cx), .vga_y(cy), .video_active(VGA_ACTIVE), .screen_width(VGA_SCREEN_WIDTH), .screen_height(VGA_SCREEN_HEIGHT),
                               .frame_width(frame_width), .frame_height(frame_height));

  top_common #
    (
      .USE_XILINX_BLOCKRAM(USE_XILINX_BLOCKRAM),
      .key_up(key_up),
      .key_down(key_down),
      .key_left(key_left),
      .key_right(key_right),
      .key_zoom_in(key_zoom_in),
      .key_zoom_out(key_zoom_out),
      .key_iter_up(key_iter_up),
      .key_iter_down(key_iter_down),
      .num_engines(num_engines),
      .width(width),
      .height(height),
      .fp_top(fp_top),
      .fp_bot(fp_bot)
    ) top_common (
      .clk_sys(CLOCK_33),
      .clk_calc(clk_calc),
      .clk_pixel(clk_pixel),

      .read_en(read_en),
      .read_addr(read_addr),
      .read_data(read_data),

      .PS2_CLOCK(PS2_CLOCK),
      .PS2_DATA(PS2_DATA)
    );

  logic [11:0] cx;
  logic [11:0] cy;

  logic [17:0] palette[0:15] = '{'b010000000111000011,
                                 'b000110000001000110,
                                 'b000010000000001011,
                                 'b000001000001010010,
                                 'b000000000001011001,
                                 'b000011001011100010,
                                 'b000110010100101100,
                                 'b001110011111110100,
                                 'b100001101101111001,
                                 'b110100111011111110,
                                 'b111100111010101111,
                                 'b111110110010010111,
                                 'b111111101010000000,
                                 'b110011100000000000,
                                 'b100110010101000000,
                                 'b011010001101000000};

  reg [dimension_bits*2 - 1:0] read_addr;
  wire [data_bits-1:0] read_data;
  reg  read_en;

  /* verilator lint_off WIDTH */
  // compensate for 2 cycle read delay
  localparam read_delay = 2;

  // rgb buffer
  always @(posedge clk_pixel)
  begin
    if (cx >= frame_width - read_delay && cy == frame_height - 1)
    begin
      read_addr <= frame_width - cx;
      read_en <= 1'b1;
    end
    else if (VGA_ACTIVE)
    begin
      read_addr <= {cy[9:10-dimension_bits], cx[9:10-dimension_bits]} + read_delay;
      read_en <= 1'b1;
    end

    if (VGA_ACTIVE)
    begin
      {VGA_R, VGA_G, VGA_B} <= palette[read_data];
    end
    else
    begin
      {VGA_R, VGA_G, VGA_B} <= 18'b0;
    end
  end

endmodule
