function [c_est,corr_medio] = estoc_analise_novo(fas_estoc,lpc_mod,desloc)

M=length(fas_estoc);
c_est_medio = zeros(M,1);
c_est = zeros(desloc,1);
% c_noise = zeros(M,1);
% c_orig = zeros(M,1);

rng('default');
noise = randn(fas_estoc(1).Lw(end-1),1);  % Normalized white Gaussian noise
noise_norm = noise'/rms(noise);


for k=1:M
    AR_coef = fas_estoc(k).lpc;
    [wn_filtrado] = estoc_mod(AR_coef,noise_norm,lpc_mod);
    wn_filtrado = wn_filtrado/rms(max(wn_filtrado));
    
    for i=1:desloc
        c_est(i) = calc_corr(wn_filtrado,i);
    end
    c_est_medio(k) = mean(sqrt((c_est).^2));
end

corr_medio = mean(sqrt((c_est_medio).^2));
end