//Alunos: Pedro Augusto, Carolina Morais, João Vitor.

//Contado que o motor esteja a direita da area
//Se Fe for 0 e Fd 0 a lona esta se movimentando, ou seja a area esta sendo coberta ou fechada
//Se Fe for 1 e Fd 0 a lona esta tocando o canto esquerdo da area, ou seja a area esta coberta
//Se Fe for 0 e Fd 1 alona esta tocando o canto direito da area, ou seja a area esta aberta
//Se L for 1, a area esta com alta insidencia de sol, se for 0, esta em um nivel toleravel
//Se U for 1, a area esta com alta insidencia de chuva, se for 0, esta em um nivel toleravel
//Se A for 1 e B 0, o motor irar girar em sentido anti horario, fechando a area
//Se A for 0 e B 1, o motor irar girar em sentido horario, abrindo a area
//Se A for 0 e B 0, o motor não ira funcionar, e a lona ira se manter no estado anterior

/*Tabela verdade
L U Fe Fd A B
0 0  0  0 0 1
0 0  0  1 0 0
0 0  1  0 0 1
0 0  1  1 0 0 //Isso é um erro mas temos de considerar, nesse caso o melhor é desligar o motor
0 1  0  0 1 0
0 1  0  1 1 0
0 1  1  0 0 0
0 1  1  1 0 0 //Isso é um erro mas temos de considerar, nesse caso o melhor é desligar o motor
1 0  0  0 1 0
1 0  0  1 1 0
1 0  1  0 0 0
1 0  1  1 0 0 //Isso é um erro mas temos de considerar, nesse caso o melhor é desligar o motor
1 1  0  0 1 0
1 1  0  1 1 0
1 1  1  0 0 0
1 1  1  1 0 0 //Isso é um erro mas temos de considerar, nesse caso o melhor é desligar o motor
*/


module cobrir(L, U, Fe, Fd, A, B);
    input L, U, Fe, Fd;
    output reg A, B;

    always @(*)
        begin
            B = ~(L | U | Fd);
            /*Nor de tres entradas, mas para economizar Ci no simulador,
            podemos fazer duas operações em um CI OR e depois mandar
            o resultado final para o CI inversor hexadecimal*/

            A = !Fe & U | !Fe & L; //Uma porta NOT para inverter Fe, 2 And e uma OR

            /*No circuito inteiro usaremos no simulador, um CI AND,
            um CI OR e um CI inversor hexadecima(NOT), alem do CI acionador de motor de ponte H*/
        end        
    
endmodule

module top;
    reg L, U, Fe, Fd;
    wire A, B;

    cobrir cob(.L(L), .U(U), .Fe(Fe), .Fd(Fd), .A(A), .B(B));

    initial 
        begin
            {L, U, Fe, Fd} = 0;
        end

    always 
        begin
            #1 {L, U, Fe, Fd} = {L, U, Fe, Fd} + 1;
        end
    
    initial 
        begin
            #16 $stop;
        end
    

    initial
        begin
            $dumpfile("ex.dump");
            $dumpvars(0, L, U, Fe, Fd, A, B);
            $dumpon;
            $display("Tempo \t L \t U \t Fe \t Fd \t A \t B");
            $monitor("%0d \t %b \t %b \t %b \t %b \t %b \t %b", $time, L, U, Fe, Fd, A, B);
        end
endmodule