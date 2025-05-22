`timescale 1ns / 1ps

module keypad_fsm(
    input clk, 
    input reset,
    input [3:0] key_in,
    input key_valid,
    output reg unlocked,
    output [1:0] state  // state is now a wire assigned from current_state
);

// FSM states
parameter IDLE = 2'b00, INPUT = 2'b01, CHECK = 2'b10, UNLOCKED = 2'b11;

// Registers for state machine and password handling
reg [1:0] current_state, next_state;
reg [3:0] password[3:0]; 
reg [3:0] input_code[3:0]; 
reg [1:0] count; 
reg match;

// Assign current_state to output state for waveform visibility
assign state = current_state;

// Match logic
always @(*) begin
    match = (input_code[0] == password[0]) &&
            (input_code[1] == password[1]) &&
            (input_code[2] == password[2]) &&
            (input_code[3] == password[3]);
end

// State transition
always @(posedge clk or posedge reset) begin
    if (reset)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

// Next state logic
always @(*) begin
    case (current_state)
        IDLE: next_state = (key_valid) ? INPUT : IDLE;
        INPUT: next_state = (count == 2'd3 && key_valid) ? CHECK : INPUT;
        CHECK: next_state = (match) ? UNLOCKED : IDLE;
        UNLOCKED: next_state = UNLOCKED; // Remain unlocked
        default: next_state = IDLE;
    endcase
end

// Output logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        unlocked <= 0;
        count <= 0;

        // Set password 1,2,3,4
        password[0] <= 4'd1;
        password[1] <= 4'd2;
        password[2] <= 4'd3;
        password[3] <= 4'd4;
    end else begin
        case (current_state)
            IDLE: begin
                unlocked <= 0;
                count <= 0;
            end
            INPUT: begin
                if (key_valid && count < 4) begin
                    input_code[count] <= key_in;
                    count <= count + 1;
                end
            end
            CHECK: begin
                // nothing needed here; match evaluated in combinational logic
            end
            UNLOCKED: begin
                unlocked <= 1;
            end
        endcase
    end
end

endmodule
