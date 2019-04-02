function [fas_det,fas_estoc,gamma]=FAS(hbwt,wavelet_N)

M=length(hbwt);
ar_ncoef = 30;                          % Numero de coeficientes do filtro Autoregressivo 

fas_estoc(1).Lw = hbwt(1).Lw;
fas_estoc(M).Lw = hbwt(1).Lw;

%% Codificação dos coeficientes estocásticos

for k=1:M
    
    aprox_coef = DWT_coef(hbwt(k).Cw,hbwt(k).Lw,5);             % Extrai os coeficientes wavelet de aproximação do último nível (conteúdo estocástico)
    fas_estoc(k).aprox_coef = aprox_coef/RMS(aprox_coef);       % Normaliza os coeficientes pela sua energia média
    ar_filt = aryule(fas_estoc(k).aprox_coef,ar_ncoef);         % Calcula os coeficientes do filtro autoregressivo
    fas_estoc(k).lpc = ar_filt;                                 % Armazena tais coeficientes na estrutura fas_estoc
    
    for n=1:wavelet_N
        %% Calcula e armazena a energia dos coeficientes de cada nível da transformada wavelet
        cD_coef = DWT_coef(hbwt(k).Cw,hbwt(k).Lw,n+1);
        e_cD = var(cD_coef);
        
        fas_estoc(k).env_cD(n) = e_cD;
        
    end
    
    %% Realiza a regressão linear da energia dos coeficientes estocásticos
    
    [p1,~] = polyfit((1:wavelet_N-1),(log2(fas_estoc(k).env_cD(1:end-1))),1);
    fas_estoc(k).gamma = [p1(1),p1(2)];
    % fas_estoc(k).hurst = [real(((-1*p1(1))+1)/2),p1(2)];
    if p1(1) < 0
        gamma(k) = abs(p1(1));
    else
        gamma(k) = 0;
    end
end

%% Codificação dos coeficientes determinísticos
for k=1:M/2

    cA_coef_impar = DWT_coef(hbwt(2*k-1).Cw,hbwt(2*k-1).Lw,1);
    cA_coef_par = DWT_coef(hbwt(2*k).Cw,hbwt(2*k).Lw,1);
    
    if (var(cA_coef_par)<(1e-10))||(var(cA_coef_impar)<(1e-10))
        cA_coef_impar = zeros(1,length(cA_coef_impar));
        cA_coef_par = zeros(1,length(cA_coef_par));
    end

    fas_det(k,:) = cA_coef_impar+(1i*cA_coef_par);
    
end

end