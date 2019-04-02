function hbwt_novo=FAS_inversa(fas_det,fas_estoc,lpc_mod)

[M,~] = size(fas_det);
n_wavelet = length(fas_estoc(1).env_cD);
mult = ceil(fas_estoc(1).Lw(end)/ fas_estoc(1).Lw(1));


for k=1:M
    fas_estoc_mod_impar = 0;
    fas_estoc_mod_par = 0;
    hbwt_novo(((k*2)-1)).Lw = fas_estoc(1).Lw;
    hbwt_novo(k*2).Lw = fas_estoc(1).Lw;
%     wn = repmat(fas_estoc(k).aprox_coef,1,mult);
%     wn_filtrado = wn(1:fas_estoc(1).Lw(end));

AR_coef = fas_estoc(k).lpc;

rng('default');
noise = randn(fas_estoc(1).Lw(end),1);  % Normalized white Gaussian noise
noise_filt = noise'/rms(noise);

[wn_filtrado] = estoc_mod(AR_coef,noise_filt,lpc_mod);
wn_filtrado = wn_filtrado/rms(max(wn_filtrado));    

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Decodificação FAS estocástica para para bandas ímpares %%
    p = fas_estoc((k*2)-1).gamma;
    
    x = (1:n_wavelet);
    y = p(1).*x+p(2);
    y_nova = 2.^y;
    

    for n=1:n_wavelet
        
        %     AR_coef = fas_estoc((k*2)-1).lpc(n,:)*10;
        %     wn_filtrado = filter(1,AR_coef,w_noise);
        %     wn_filtrado = wn_filtrado/rms(max(wn_filtrado));
     
        
        wn_filt_dec = wn_filtrado(1:fas_estoc(1).Lw(n+1))*sqrt(y_nova(n));
%         wn_filt_dec = noise_filt(1:fas_estoc(1).Lw(n+1))*sqrt(y_nova(n));
        
        if fas_estoc_mod_impar == 0
            fas_estoc_mod_impar = wn_filt_dec;
        else
            fas_estoc_mod_impar = [fas_estoc_mod_impar,wn_filt_dec];
        end
        
    end
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Decodificação FAS estocástica para para bandas pares %%
    p = fas_estoc(k*2).gamma;

    x = 1:n_wavelet;
    y = p(1).*x+p(2);
    y_nova = 2.^y;
    

    for n=1:n_wavelet
        
%     AR_coef = fas_estoc(k*2).lpc(n,:);
%     wn_filtrado = (filter(1,AR_coef,w_noise));
%     wn_filtrado = wn_filtrado/max(max(wn_filtrado));
    
    wn_filt_dec = wn_filtrado(1:fas_estoc(1).Lw(n+1))*sqrt(y_nova(n));
    

    if fas_estoc_mod_par == 0
        fas_estoc_mod_par = wn_filt_dec;
    else
        fas_estoc_mod_par = [fas_estoc_mod_par,wn_filt_dec];
    end
    
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Decodificação FAS determinística para para bandas ímpares %%
    
    fas_det_mod_impar = real(fas_det(k,:));
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Decodificação FAS determinística para para bandas pares %%
    
    fas_det_mod_par = imag(fas_det(k,:));    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Inicio decodificação HBWT %%
    
    hbwt_novo((k*2)-1).Cw = [fas_det_mod_impar,fas_estoc_mod_impar];
    hbwt_novo(k*2).Cw = [fas_det_mod_par,fas_estoc_mod_par];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
end
