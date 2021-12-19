/*
Pedro Augusto Sousa Gonçalves - 21.1.4015
João Vitor Costa Marcenes Vieira - 21.1.4016
Carolina Morais Araujo - 20.2.4188
*/
module action (clk, reset, led);
    input clk, reset;
    reg [9:0] bar, mosca, azul;
    output reg [2:0] led;

    initial 
        begin
            bar = 10'b0010011110;
            mosca =10'b0110101100;
            azul = 10'b1010101000;
            led = 0;
        end 

    always @(posedge clk) 
        begin
            if(reset) 
                begin
                    led <= 0;
                    bar <= 10'b0010011110;
                    mosca <=10'b0110101100;
                    azul <= 10'b1010101000;
                end
            else
                begin
                    bar <= {bar[0], bar[9:1]};
                    mosca <= {mosca[0], mosca[9:1]};
                    azul <= {azul[0], azul[9:1]};
                    led = {bar[0], mosca[0], azul[0]};
                end

        end
endmodule

module top;
    reg clk, reset;
    wire [2:0] led;

    action act(.clk(clk), .reset(reset), .led(led));

    initial 
        begin
            {clk, reset} = 0;
            #50 reset = 1;
            #3 reset = 0;
            #19 $stop;
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
            $display("Tempo \t clk \t reset \t Bar \t mosca \t azul");
            $monitor("%0d \t %b \t %b \t %b \t %b \t %b", $time, clk, reset, led[2], led[1], led[0]);
        end
    
endmodule
