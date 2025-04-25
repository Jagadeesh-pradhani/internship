// 2x1 Multiplexer Module
module mux2x1(
    input in0,
    input in1,
    input sel,
    output out
);
    assign out = sel ? in1 : in0;
endmodule

// D Flip-Flop Module
module dff(
    input clk,
    input D,
    output reg Q
);
    always @(posedge clk) begin
        Q <= D;
    end
endmodule

// 4-bit Register with Enable
module reg4bit(
    input [3:0] D,
    input clk,
    input enable,
    output [3:0] Q
);
    wire [3:0] mux_out;
    
    // Generate 4 instances of mux and dff
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : reg_gen
            mux2x1 mux (
                .in0(Q[i]),    // Feedback from Q
                .in1(D[i]),    // Data input
                .sel(enable),  // Enable signal
                .out(mux_out[i])
            );
            
            dff flip_flop (
                .clk(clk),
                .D(mux_out[i]),
                .Q(Q[i])
            );
        end
    endgenerate
endmodule