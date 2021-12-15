module action (clk, leds);
    input clk;
    reg [4:0] led1, led2, led3, led4;
    output reg [7:0] leds;

    initial 
        begin
            led1 = 5'b10001;
            led2 = 5'b10100;
            led3 = 5'b10010;
            led4 = 5'b11000;
            leds = 0;
        end
    
    always @(posedge clk) 
        begin
            led1 <= {led1[0], led1[4:1]};
            led2 <= {led2[0], led2[4:1]};
            led3 <= {led3[0], led3[4:1]};
            led4 <= {led4[0], led4[4:1]};
            leds <= {led1[0], led2[0], led3[0], led4[0], led4[0], led3[0], led2[0], led1[0]};
        end
endmodule

module top;
    reg clk;
    wire [7:0] leds;

    action act(.clk(clk), .leds(leds));

    initial 
        begin
            clk = 0;
            #32 $stop;
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
            $display("Tempo \t clk \t leds");
            $monitor("%0d \t %b \t %b ", $time, clk, leds);
        end
    
endmodule