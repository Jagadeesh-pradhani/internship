module DFF2(
    input wire D, in,
    input wire clk,
    output reg Q
);
    reg q1;          // First flip-flop's output
    wire and_out;    // AND gate output

    // AND gate with both inputs tied to first flip-flop's output
    assign and_out = q1 & in;  // Equivalent to just q1, but follows spec

    // First flip-flop
    always @(posedge clk) begin
        q1 <= D;
    end

    // Second flip-flop
    always @(posedge clk) begin
        Q <= and_out;  // Feeds AND output to second flip-flop
    end
endmodule