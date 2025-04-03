
module d_latch(
    input D, E,
    output reg Q, NotQ
);

    always @(*) begin
        if (E) begin
            Q <= D;
        end
        NotQ <= ~Q;
    end

endmodule