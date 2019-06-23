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

nosEspaco = 61;
nosTempo = 10;
tempoTotal = 1000;
tolerancia = 1e-10;
tempoConvergencia = 50;

//disp("Variaveis iniciais para calculo implementadas com sucesso;")

//Variaveis sem valores iniciais, criadas para cálculos

deltaX = varComprimento/nosEspaco;
deltaT = tempoTotal/nosTempo;
s = (varAlpha*deltaT)/(deltaX * deltaX);

//disp("Variaveis sem valores iniciais implementadas com sucesso;")

//Vetores utilizados para cálculo

    //Vetor de espaço
    vetEspaco(1) = 0;
    for i = 2:nosEspaco
        vetEspaco(i) = vetEspaco(i-1) + deltaX;
    end
    
    //Geração dos vetores com valores de concetração
    vetAntigo(1) = varCw;
    vetNovo(1)= varCw;
    for i=2:nosEspaco-1
        vetAntigo(i) = varCi;
        vetNovo(i) = varCi;
    end
    vetAntigo(nosEspaco) = varCe;
    vetNovo(nosEspaco) = varCe;

//Resolução

t=0;
while t < tempoTotal
    for i = 1:tempoConvergencia
        erro = -1;
        for j = 2:nosEspaco-1
            aux = vetNovo(j);
            vetNovo(j) = (s*(vetNovo(j-1) + vetNovo(j+1))+vetAntigo(j))/(2*s+1);
            erro = max(erro,abs((vetNovo(j) - aux)/vetNovo(j)));
        end
        if (erro<tolerancia)
            break;
        end
    end
    vetAntigo = vetNovo;
    t = t + deltaT;
end

//Plot

plot (vetEspaco, vetNovo);
title("Gráfico Espaço X Concentração",'fontsize',3);
xlabel("Cm",'fontsize',3);
ylabel("C(mol/cm^3)",'fontsize',3);
xgrid();
