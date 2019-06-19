clear;
clc;
close;

printf("Trabalho Reinoso e Dudinha");

//Variáveis dadas no problema
Ci = 0; 
Cw = 10; 
Ce = 35; 
a = 40; 
l = 300;

//Variáveis novas que serão utilizadas para cálculo
NosEsp = input("digite o valor dos nos internos do espaço: "); //MODIFICAR
NosTemp = input("digite o valor dos nos internos do tempo: "); //MODIFICAR
TempoTotal = input("digite o valor do tempo total: "); //MODIFICAR
Dx = l/NosEsp; 
Dt = TempoTotal/NosTemp; 
s = a * ((Dt)/(Dx*Dx));
M = zeros() //Declaração da matriz neutra A que será preechida posteriormente
VetorCi = [0,1] //Declaração do vetor coluna que apresentará as condições iniciais

//Preenchimento do vetor de espaço com a variação requerida
for i = 1:NosEsp+1 
    if i == 1
         VetorEsp(i)= 0;
    else
        VetorEsp(i) = VetorEsp(i-1) + Dx;
    end
end

//Preenchimento do vetor de tempo com a variação requerida
for i = 1:NosTemp+1 
    if i == 1
        VetorTemp(i) = 0;
    else 
        VetorTemp(i) = VetorTemp(i-1) + Dt;
    end
end

//Define os valores iniciais no vetor Ci
for i = 1:NosEsp+1
    if i==1
        VetorCi(i)= Cw;
    elseif i == NosEsp+1
        VetorCi(i)= Ce; 
    else 
        VetorCi(i) = Ci;
    end        
end

//Define o primeiro valor do vetor Cw, e os outros para zero
for i = 1:NosEsp-1
    if i==1
        VetorCw(i)= Cw;
    else
        VetorCw(i)=0;    
    end     
end

//Define o primeiro valor do vetor Ce, e os outros para zero
for i = 1:NosEsp-1
    if i==NosEsp-1
        VetorCe(i)= Ce;
    else
        VetorCe(i)=0;   
    end      
end

//Criação e definição dos valores daquela matriz vista em sala com -s e 2.s 
for i = 1:NosEsp-1
    for j = 1:NosEsp-1
        if abs(i-j) > 1
            M(i,j) = 0; 
        elseif abs(i-j) == 1
            M(i,j) = -s;
        else abs(i-j) == 0
            M(i,j) = 1 + 2*s; 
        end
    end
end

//OLHA LÁ HEIN CARALHOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO

//Geração de Ci(n+1)
aux = [0,0];
for i=1:NosEsp-1 
    aux(i) = 0; 
end

//Aplicação do método iterativo de Jacobi de resolução de sistemas lineares
InterCi = VetorCi(2:NosEsp);

for n = 1:NosTemp 
    erro = 1;
    f = InterCi + s*(VetorCe' + VetorCw'); 
    while erro > 1e-6 
        aux2 = aux;
        for i = 1:NosEsp-1
            soma = 0;
            for j = 1:(i-1)
                soma = soma + M(i,j)*aux(j);
            end
            soma2 = 0;
            for j=(i+1):(NosEsp-1)
                soma2 = soma2 + M(i,j)*aux(j);
            end
            aux(i) = (1/M(i,i)) * (f(i) - (soma+soma2));
        end
        erro = norm(aux-aux2);
    end
    InterCi = aux;
end

//Geração de Ci(n)
for i=1:NosEsp+1 
    if i==1 
        InterCi(i) = Cw;
    elseif i==NosEsp+1
        InterCi(i) = Ce;
    else
        InterCi(2:NosEsp) = aux;  
    end
end

//Plot do gráfico Espaço X Concetração
plot (VetorEsp, InterCi');
title("Gráfico Espaço X Concentração",'fontsize',3);
xlabel("t(s)",'fontsize',3);
ylabel("C(mol/cm^3)",'fontsize',3);
xgrid();
