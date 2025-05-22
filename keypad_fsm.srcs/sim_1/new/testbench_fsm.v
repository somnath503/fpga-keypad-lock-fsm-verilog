`timescale 1ns / 1ps

module testbench;

    reg clk, reset, key_valid;
    reg [3:0] key_in;
    wire unlocked;
    wire [1:0] state;

    // Instantiate the FSM
    keypad_fsm uut (
        .clk(clk),
        .reset(reset),
        .key_in(key_in),
        .key_valid(key_valid),
        .unlocked(unlocked),
        .state(state)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        $display("Simulation started...");
        $dumpfile("fsm.vcd");
        $dumpvars(0, testbench);

        reset = 1;
        key_valid = 0;
        key_in = 0;

        #10 reset = 0;

        // Input correct password: 1, 2, 3, 4
        send_key(4'd1);
        send_key(4'd2);
        send_key(4'd3);
        send_key(4'd4);

        #20; // Let FSM update

        if (unlocked)
            $display("✅ Password Correct: UNLOCKED!");
        else
            $display("❌ Password Incorrect: LOCKED!");

        #20;
        $finish;
    end

    // Key sending task
    task send_key(input [3:0] key);
        begin
            key_in = key;
            key_valid = 1;
            #10;
            key_valid = 0;
            #10;
        end
    endtask

endmodule
