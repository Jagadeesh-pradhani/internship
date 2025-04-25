module DFF(D,clk,Q);
    input wire D;
    input wire clk; 
    output reg Q; 

    always @(posedge clk) 
    begin
    Q <= D; 
    end 
endmodule 