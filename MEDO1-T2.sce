clear;
clc;

//Variáveis dadas no problema
Ci = 0; 
Cw = 10; 
Ce = 35; 
a = 40; 
l = 300;

//Variáveis novas que serão utilizadas para cálculo
NosEsp = 3; //MODIFICAR
NosTemp = 3; //MODIFICAR
TempoTotal = 6; //MODIFICAR
Dx = l/NosEsp; 
Dt = TempoTotal/NosTemp; 
s = a * ((Dt)/(Dx*Dx));

//Preenchimento do vetor de espaço com a variação requerida
VetorEsp(1)= 0;

for i = 2:NosEsp  
    VetorEsp(i) = VetorEsp(i-1) + Dx;
end

//Preenchimento do vetor de tempo com a variação requerida
VetorTemp(1)= 0;

for i = 2:NosTemp  
    VetorTemp(i) = VetorTemp(i-1) + Dt;
end

//Define os valores iniciais no vetor Ci
VetorCi(1) = Cw;
VetorCi(NosEsp+1) = Ce;

for i = 2:l 
       Ci(i) = Ci;
end

//Define o primeiro valor do vetor Cw, e os outros para zero
VetorCw(1) = Cw;

for i = 2:NosEsp-1
    VetorCw(i) = 0;
end

//Define o primeiro valor do vetor Ce, e os outros para zero
VetorCe(1) = Ce;

for i = 2:NosTemp-1
    VetorCe(i) = 0;
end

//Criação e definição dos valores daquela matriz vista em sala com -s e 2.s 
for i = 1: NosEsp-1
    for j = 1:NosEsp-1
        if abs(i-j) > 1
            M(i,j) = 0; 
        if abs(i-j) == 1
            M(i,j) = -s;
        if abs(i-j) == 0
            M(i,j) = 1 + 2*s; 
    end
end

//Resolução por Jacobi
