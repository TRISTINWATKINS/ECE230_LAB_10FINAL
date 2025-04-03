
module memory_system(
    input [7:0] data,
    input store,
    input [1:0] addr,
    output reg [7:0] memory
);

    wire [7:0] byte_mem_out [3:0];
    reg [7:0] demux_data [3:0];
    reg  [3:0] demux_store ;

    // Demultiplexer for data
    always @(*) begin
        case(addr)
            2'b00: begin
                demux_data[0] <= data;
                demux_data[1] <= 8'b0;
                demux_data[2] <= 8'b0;
                demux_data[3] <= 8'b0;
            end
            2'b01: begin
                demux_data[0] <= 8'b0;
                demux_data[1] <= data;
                demux_data[2] <= 8'b0;
                demux_data[3] <= 8'b0;
            end
            2'b10: begin
                demux_data[0] <= 8'b0;
                demux_data[1] <= 8'b0;
                demux_data[2] <= data;
                demux_data[3] <= 8'b0;
            end
            2'b11: begin
                demux_data[0] <= 8'b0;
                demux_data[1] <= 8'b0;
                demux_data[2] <= 8'b0;
                demux_data[3] <= data;
            end
            default: begin
              demux_data[0] <= 8'b0;
              demux_data[1] <= 8'b0;
              demux_data[2] <= 8'b0;
              demux_data[3] <= 8'b0;
            end
        endcase
    end

    // Demultiplexer for store
    always @(*) begin
        case(addr)
            2'b00: begin
                demux_store[0] <= store;
                demux_store[1] <= 1'b0;
                demux_store[2] <= 1'b0;
                demux_store[3] <= 1'b0;
            end
            2'b01: begin
                demux_store[0] <= 1'b0;
                demux_store[1] <= store;
                demux_store[2] <= 1'b0;
                demux_store[3] <= 1'b0;
            end
            2'b10: begin
                demux_store[0] <= 1'b0;
                demux_store[1] <= 1'b0;
                demux_store[2] <= store;
                demux_store[3] <= 1'b0;
            end
            2'b11: begin
                demux_store[0] <= 1'b0;
                demux_store[1] <= 1'b0;
                demux_store[2] <= 1'b0;
                demux_store[3] <= store;
            end
            default: begin
              demux_store[0] <= 1'b0;
              demux_store[1] <= 1'b0;
              demux_store[2] <= 1'b0;
              demux_store[3] <= 1'b0;
            end
        endcase
    end
    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : byte_mem_instances
            byte_memory bm(
                .data(demux_data[i]),
                .store(demux_store[i]),
                .memory(byte_mem_out[i])
            );
        end
    endgenerate

    // Multiplexer for output
    always @(*) begin
        case(addr)
            2'b00: memory <= byte_mem_out[0];
            2'b01: memory <= byte_mem_out[1];
            2'b10: memory <= byte_mem_out[2];
            2'b11: memory <= byte_mem_out[3];
            default: memory = 8'b0;
        endcase
    end

endmodule