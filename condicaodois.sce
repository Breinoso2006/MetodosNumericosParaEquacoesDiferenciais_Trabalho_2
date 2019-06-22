clear;
clc;
close;

//Variáveis com valores iniciais da planilha

varCi = 0;

varCw = 10;
varAlpha = 40e-6;
varComprimento = 300;

//disp("Variaveis da planilha implementadas com sucesso;")

//Variáveis com valores iniciais, criadas para cálculo

nosEspaco = 61;
nosTempo = 100000;
tempoTotal = 100;
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
    vetNovo(nosEspaco+1) = vetNovo(nosEspaco-1);
    for i=2:nosEspaco-1
        vetAntigo(i) = varCi;
        vetNovo(i) = varCi;
    end
    vetAntigo(nosEspaco) = vetAntigo(nosEspaco+1);
    vetNovo(nosEspaco) = vetNovo(nosEspaco+1);

//Resolução

for t = 1:tempoTotal
    for i = 1:tempoConvergencia
        erro = -1;
        for j = 2:nosEspaco-1
            aux = vetNovo(j);
            vetNovo(j) = (s*(vetNovo(j-1) + vetNovo(j+1)))/(2*s+1);
            erro = max(erro,abs((vetNovo(j) - aux)/vetNovo(j)));
        end
        if (erro<tolerancia)
            break;
        end
    end
    vetAntigo = vetNovo;
end

//Plot

plot (vetEspaco, vetNovo);
title("Gráfico Espaço X Concentração",'fontsize',3);
xlabel("t(s)",'fontsize',3);
ylabel("C(mol/cm^3)",'fontsize',3);
xgrid();
