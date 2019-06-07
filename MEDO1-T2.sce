clear;
clc;

Ci = 0; Cw = 10; Ce = 35; a = 40; l = 300;
Dt = 0; Dx = 0; s = a * ((Dt)/(Dx*Dx));
fi = [];

fi[2] = fi[2]*(1 + 2*s) - s*(fi[3] - Cw);
fi[300] = fi[300]*(1 + 2*s) - s*(fi[299] - Ce);

function saida = (vetor[])
    for i = 3:299
        fi[i] = fi[i]*(1 + 2*s) - s*(fi[i+1] - fi[i-1]);
    end

endfunction

