/*Tabela verdade
A B C D V1e V2e V1d v2d
0 0 0 0  0   0   0   0  
0 0 0 1  0   0   1   0
0 0 1 0  0   0   1   0
0 0 1 1  0   0   1   0
0 1 0 0  0   0   1   1
0 1 0 1  0   0   1   1
0 1 1 0  0   0   1   1
0 1 1 1  0   0   1   1
1 0 0 0  0   1   0   0
1 0 0 1  1   1   0   0
1 0 1 0  1   1   0   0
1 0 1 1  1   1   0   0
1 1 0 0  1   1   0   0
1 1 0 1  1   0   0   0
1 1 1 0  1   0   0   0
1 1 1 1  1   0   0   0
*/


module act_aileron(ang, V1e, V2e, V1d, V2d);
    input [3:0] ang;
    output reg V1e, V2e, V1d, V2d;

    always @(*)
        begin
            V1d = ~ang[3] & (ang[2] | ang[1] | ang[0]);
            V2d = ~ang[3] & ang[2];
            V1e = ang[3] & (ang[2] | ang[1] | ang[0]);
            V2e = ang[3] & (~ang[2] | (~ang[1] & ~ang[0]));    
        end        
    
endmodule

module top;
    reg [3:0] ang;
    wire V1e, V2e, V1d, V2d;

    act_aileron act(.ang(ang), .V1e(V1e), .V2e(V2e), .V1d(V1d), .V2d(V2d));

    initial 
        begin
            ang = 0;
        end

    always 
        begin
            #1 ang++;
        end
    
    initial 
        begin
            #16 $stop;
        end
    
    initial
        begin
            $dumpfile("ex.dump");
            $dumpvars(0, top);
            $dumpon;
            $display("Tempo \t A \t B \t C \t D \t V1e \t V2e \t V1d \t V2d");
            $monitor("%0d \t %b \t %b \t %b \t %b \t %b \t %b \t %b \t %b", $time, ang[3], ang[2], ang[1], ang[0], V1e, V2e, V1d, V2d);
        end
endmodule