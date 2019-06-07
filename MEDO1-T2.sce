clear;
clc;

Ci = 0; Cw = 10; Ce = 35; a = 40; l = 300;
Dt = 0; Dx = 0; s = a * ((Dt)/(Dx*Dx));
fi_n = [];
fi_n1 = [];

fi_n[2] = fi_n1[2]*(1 + 2*s) - s*(fi_n1[3] - Cw);
fi_n[300] = fi_n1[300]*(1 + 2*s) - s*(fi_n1[299] - Ce);

function saida = (vetor[])
    for i = 3:299
        fi_n[i] = fi[i]*(1 + 2*s) - s*(fi_n1[i+1] - fi_n1[i-1]);
    end

endfunction

