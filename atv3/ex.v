module relogio (rst, clk, dez, uni);
    input rst, clk;
    output reg [2:0] dez;
    output reg [3:0] uni;

    initial 
        begin
            {dez, uni} = 0;
        end

    always @(posedge clk) 
        begin
            if((rst) || (dez == 5 && uni == 9)) {dez, uni} <= 0;
            if(uni == 9) 
                begin
                    uni <= 0;
                    dez++;
                end
            uni++;
        end
endmodule

module top;
    reg rst, clk;
    wire [2:0] dez;
    wire [3:0] uni;

    relogio rel(.rst(rst), .clk(clk), .dez(dez), .uni(uni));

    initial 
        begin
            {rst, clk} = 0;
            #200 rst = 1;
            #2 rst = 0;
            #99 $stop; 
        end
    
    always
        begin
            #1 clk = ~clk;
        end

    initial
        begin
            $dumpfile("ex.dump");
            $dumpvars(0, top);
            $dumpon;
            $display("Tempo \t clk \t rst \t time");
            $monitor("%0d \t %b \t %b \t %d%d ", $time, clk, rst, dez, uni);
        end

endmodule