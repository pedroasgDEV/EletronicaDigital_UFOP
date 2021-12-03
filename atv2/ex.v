module controle(S, V, V0, V1, V2, V3);
    input [1:0] S;
    input [3:0] V;
    reg [7:0] Vel;
    output reg [7:0] V0, V1, V2, V3;

    always @(*) 
        begin
            //Define a velocidade do motor que vai ser ligado
            if(V == 0) Vel = 0; //Velocidade 0
            else if(V < 3) Vel = 8'b00001111; //Velocidade 1
            else if(V < 8) Vel = 8'b00110011; //Velocidade 2
            else Vel = 8'b11000011; //Velocidade 3

            //Define o motor que será ligado
            case(S)
                0: {V0,V1,V2,V3} = {Vel,24'd0}; //Ativa o motor 0
				1: {V0,V1,V2,V3} = {8'd0,Vel,16'd0}; //Ativa o motor 1
				2: {V0,V1,V2,V3} = {16'd0,Vel,8'd0}; //Ativa o motor 2
				3: {V0,V1,V2,V3} = {24'd0,Vel}; //Ativa o motor 3
            endcase
        end

endmodule

module top;
    reg [1:0] S;
    reg [3:0] V;
    wire [7:0] V0, V1, V2, V3;

    controle ctrl(.S(S), .V(V), .V0(V0), .V1(V1), .V2(V2), .V3(V3));

    initial 
        begin
            {S, V} = 0;
        end

    always 
        begin
            #1 V++;
        end
    
    initial 
        begin
            #16 S = 1;
            #16 S = 2;
            #16 S = 3;
            #16 $stop;
        end

    initial
        begin
            $dumpfile("ex.dump");
            $dumpvars(0, top);
            $dumpon;
            $display("Tempo \t S \t V \t V1 \t V2 \t V3 \t V4");
            $monitor("%0d \t %d \t %d \t %b \t %b \t %b \t %b", $time, S, V, V0, V1, V2, V3);
        end

    
endmodule