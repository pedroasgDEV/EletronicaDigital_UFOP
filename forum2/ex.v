module SOMASUB(A,B,op,R,zero,sinal,overflow);

    input [3:0] A,B;

    input op;

    output reg [3:0] R;

    output zero,sinal, overflow;


    assign sinal=R[3];

    assign zero=~(|R);
    
    assign overflow = (A[0] & B[0]) | ((A[0] ^ B[0]) & ~R[0]);


    always @(*)

        begin

            R = (op)?A-B:A+B;

        end

endmodule // SOMASUB