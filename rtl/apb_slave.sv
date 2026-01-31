module apb_slave (
    input  wire        pclk,
    input  wire        presetn,
    input  wire [31:0] paddr,
    input  wire        psel,
    input  wire        penable,
    input  wire        pwrite,
    input  wire [31:0] pwdata,
    output reg  [31:0] prdata,
    output wire        pready
);

    // Simple 64-word memory
    reg [31:0] mem [0:63];

    // Ready is always 1 for this simple design
    assign pready = 1'b1;

    always @(posedge pclk or negedge presetn) begin
        if (!presetn) begin
            prdata <= 32'b0;
        end
        else begin
            // Write operation: Setup (psel) + Access (penable)
            if (psel && penable && pwrite) begin
                mem[paddr[5:0]] <= pwdata;
            end
            // Read operation
            else if (psel && !pwrite) begin
                prdata <= mem[paddr[5:0]];
            end
        end
    end

endmodule
