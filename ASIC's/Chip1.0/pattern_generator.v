/*
 * Copyright (c) 2025 Emre Dayangac
 * SPDX-License-Identifier: Apache-2.0
 */

module tt_um_LED_Pattern_Generator (
    input  wire        clk,       // System clock (required)
    input  wire        rst_n,     // Active-low reset (required)
    input  wire        ena,       // Enable (required)
    input  wire [7:0]  ui_in,     // 8 user input pins (required)
    output wire [7:0]  uo_out,    // 8 user output pins (required)
    input  wire [7:0]  uio_in,    // 8 bidirectional inputs (required)
    output wire [7:0]  uio_out,   // 8 bidirectional outputs (required)
    output wire [7:0]  uio_oe     // 8 bidirectional output enables (required)
);

    // Mode selection from first 2 input bits
    wire [1:0] pattern_mode = ui_in[1:0];

    // Bidirectional pins are unused
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Internal state
    reg [7:0] timing_counter;   // Controls pattern timing
    reg [7:0] led_pattern;      // Current LED pattern

    // Output assignment
    assign uo_out = led_pattern;

    // Pattern generation state machine
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            timing_counter <= 8'h00;
            led_pattern <= 8'h00;
        end else if (ena) begin
            timing_counter <= timing_counter + 1;

            case (pattern_mode)
                2'b00: begin
                    // Binary counter pattern
                    if (timing_counter[3:0] == 4'hF) begin
                        led_pattern <= led_pattern + 1;
                    end
                end

                2'b01: begin
                    // Knight Rider pattern
                    if (timing_counter[3:0] == 4'hF) begin
                        if (led_pattern == 8'h00 || led_pattern == 8'h80) begin
                            led_pattern <= 8'h01;
                        end else if (led_pattern < 8'h80) begin
                            led_pattern <= led_pattern << 1;
                        end else begin
                            led_pattern <= led_pattern >> 1;
                        end
                    end
                end

                2'b10: begin
                    // LFSR pseudo-random pattern
                    if (timing_counter[3:0] == 4'hF) begin
                        led_pattern <= {led_pattern[6:0], 
                                        led_pattern[7] ^ led_pattern[5] ^ 
                                        led_pattern[4] ^ led_pattern[3]};
                        if (led_pattern == 8'h00) begin
                            led_pattern <= 8'h01;
                        end
                    end
                end

                2'b11: begin
                    // Alternating pattern
                    if (timing_counter[3:0] == 4'hF) begin
                        if (led_pattern == 8'h55) begin
                            led_pattern <= 8'hAA;
                        end else begin
                            led_pattern <= 8'h55;
                        end
                    end
                end
            endcase
        end
    end
endmodule
