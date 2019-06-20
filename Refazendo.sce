clear;
clc;
close;

//Variáveis com valores iniciais da planilha

varCi = 0;
varCe = 35;
varCw = 10;
varAlpha = 40e-6;
varComprimento = 300;

//disp("Variaveis da planilha implementadas com sucesso;")

//Variáveis com valores iniciais, criadas para cálculo

nosEspaco = 61
nosTempo = 10;
tempoTotal = 10000000000000000;

//disp("Variaveis iniciais para calculo implementadas com sucesso;")

//Variaveis sem valores iniciais, criadas para cálculos

deltaX = varComprimento/nosEspaco;
deltaT = tempoTotal/nosTempo;
s = (varAlpha*deltaT)/(deltaX * deltaX);

//disp("Variaveis sem valores iniciais implementadas com sucesso;")

//Vetores utilizados para cálculo
    
    //Geração do vetor com valores de espaço 
    
    for i = 1:nosEspaco+1
        if i == 1
            vetorEspaco(i) = 0;
        else
            vetorEspaco(i) = vetorEspaco(i-1) + deltaX;
        end
//        disp("Valor Espaco:");
//        disp(i);
//        disp(vetorEspaco(i));
    end
    
    //Geração do vetor com valores de tempo
    
    for i = 1:nosTempo+1
        if i == 1
            vetorTempo(i) = 0;
        else
            vetorTempo(i) = vetorTempo(i-1) + deltaT;
        end
//        disp("Valor Tempo:");
//        disp(i);
//        disp(vetorTempo(i));
    end
    
    //Geração dos vetores Ce e Cw [Cw 0 0 0 ... 0 0 0 0] e [0 0 ... 0 Ce]
    
    for i = 1:nosEspaco-1
        if i == 1
            vetorCw(i) = varCw;
            vetorCe(i) = 0;
        elseif i == nosEspaco-1
            vetorCe(i) = varCe;
            vetorCw(i) = 0;
        else 
            vetorCw(i) = 0;
            vetorCe(i) = 0;
        end
//        disp("vetorCw:")
//        disp(i);
//        disp(vetorCw(i));
//        disp("vetorCe:")
//        disp(i);
//        disp(vetorCe(i));
    end
    
    //Geração do vetor com os valores iniciais [Cw Ci Ci ... Ci Ci Ce] --> (Ci(n))
    
    vetorIniciais = [0,1];
    
    for i = 1:nosEspaco+1
        if i == 1
            vetorIniciais(i) = varCw;
        elseif i == nosEspaco+1
            vetorIniciais(i) = varCe;
        else
            vetorIniciais(i) = varCi;
        end
//        disp("vetorIniciais:")
//        disp(i);
//        disp(vetorIniciais(i));
    end

//Geraçao da famosa matriz nxn de coeficientes

M = zeros();

for i = 1:nosEspaco-1
   for j = 1:nosEspaco-1
      if abs(i-j) == 0
            M(i,j) = 1 +2*s;                  
        elseif abs(i-j) == 1
            M(i,j) = -s;
        else
            M(i,j) = 0;
        end
//        disp (M(i,j));
     end
end

//=============== QUERIA MUITO MUDAR ALGUMA COISA POR AQUI, MAS SINCERAMENTE NÃO ENTENDI O QUE TA ACONTECENDO ====================

//Geração do vetor (Ci(n+1)) por Jacobi

x = [0, 0];
for i = 1:nosEspaco-1
    aux(i) = 0;
end

vetorInternos = vetorIniciais(2:nosEspaco);

for n = 1:nosTempo
    erro = 1;
    f = vetorInternos + s*(vetorCw' + vetorCe'); //Formulação do sistema de equações lineares do método de Jacobi
    while erro > 1e-6
        aux2 = aux;
        for i = 1:nosEspaco-1
            soma1=0;
            for j = 1:i-1
                soma1 = soma1 + M(i,j)*aux(j);
            end
            soma2 = 0;
            for j = i+1:nosEspaco-1
                soma2 = soma2 + M(i,j)*aux(j);
            end
            aux(i) = (1/M(i,i))*(f(i)-(soma1+soma2));
        end
        erro = norm(aux-aux2);
        disp(x);
        disp(erro);
    end
    vetorInternos = aux'; // o erro está aqui em algum lugar <_<_<_<_<_<_<_<_< tirando o transposto dá merda, mas o outro nosso nao tem
end

for i = 1:nosEspaco+1
    if i == 1
        vetorInternos(i) = varCw;
    elseif i == nosEspaco+1
        vetorInternos(i) = varCe;
    else
        vetorInternos(2:nosEspaco) = aux;
    end
end

//================== QUERIA MUITO MUDAR ALGUMA COISA POR AQUI, MAS SINCERAMENTE NÃO ENTENDI O QUE TA ACONTECENDO ================

//Plotagem do gráfico de espaco e vetorIniciaisInternos

//Plot do gráfico Espaço X Concetração
plot (vetorEspaco, vetorInternos')
xgrid()
