// Testbench for LED Pattern Generator
`timescale 1ns/1ps

module tb_LED_Pattern_Generator();
    // Testbench signals
    reg clock;
    reg reset_n;
    reg enable;
    reg [7:0] inputs;
    reg [7:0] unused_in;
    wire [7:0] led_outputs;
    wire [7:0] unused_out;
    wire [7:0] io_enable;
    
    // Instantiate the Device Under Test (DUT)
    LED_Pattern_Generator dut (
        .clock(clock),
        .reset_n(reset_n),
        .enable(enable),
        .inputs(inputs),
        .unused_in(unused_in),
        .led_outputs(led_outputs),
        .unused_out(unused_out),
        .io_enable(io_enable)
    );
    
    // Clock generation (100MHz)
    always begin
        #5 clock = ~clock;  // 10ns period (100MHz)
    end
    
    // Test sequence
    initial begin
        // Initialize signals
        clock = 0;
        reset_n = 0;      // Start in reset
        enable = 1;        // Module enabled
        inputs = 8'h00;    // Mode 0 initially
        unused_in = 8'h00; // Not used
        
        // Dump waveforms to file
        $dumpfile("led_pattern_generator.vcd");
        $dumpvars(0, tb_LED_Pattern_Generator);
        
        // Release reset after 100ns
        #100 reset_n = 1;
        
        // Test Mode 0 (Binary Counter)
        inputs = 8'h00;
        $display("Testing Mode 0: Binary Counter Pattern");
        repeat(100) begin
            @(posedge clock);
            if (led_outputs != 0) $display("Time: %t, Mode: %d, Output changed to: %b", 
                                         $time, inputs[1:0], led_outputs);
        end
        
        // Test Mode 1 (Knight Rider Pattern)
        inputs = 8'h01;
        $display("Testing Mode 1: Knight Rider Scanning Pattern");
        repeat(100) begin
            @(posedge clock);
            if (led_outputs != 0) $display("Time: %t, Mode: %d, Output changed to: %b", 
                                         $time, inputs[1:0], led_outputs);
        end
        
        // Test Mode 2 (Random Pattern)
        inputs = 8'h02;
        $display("Testing Mode 2: Pseudo-Random Pattern");
        repeat(100) begin
            @(posedge clock);
            if (led_outputs != 0) $display("Time: %t, Mode: %d, Output changed to: %b", 
                                         $time, inputs[1:0], led_outputs);
        end
        
        // Test Mode 3 (Alternating Pattern)
        inputs = 8'h03;
        $display("Testing Mode 3: Alternating Pattern");
        repeat(100) begin
            @(posedge clock);
            if (led_outputs != 0) $display("Time: %t, Mode: %d, Output changed to: %b", 
                                         $time, inputs[1:0], led_outputs);
        end
        
        // End simulation
        $display("Simulation complete");
        $finish;
    end
    
    // Monitor only when outputs change
    reg [7:0] last_out = 0;
    always @(posedge clock) begin
        if (led_outputs != last_out) begin
            $display("Time: %t, Mode: %d, Output: %b", $time, inputs[1:0], led_outputs);
            last_out = led_outputs;
        end
    end
endmodule
