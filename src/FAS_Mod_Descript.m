function [fas_det,fas_estoc,gamma,lpc_mod] = FAS_Mod_Descript(ModMatrix, fas_det,fas_estoc,gamma,hbwt,wavelet_N, M )
%FAS_Mod_Descript - applies all the modulations selected to all the
%descriptors. The calculation of the new value is made in FAS_Calc_Descript
fas_det = fas_det;
fas_estoc = fas_estoc;
gamma = gamma;

%% CEH %% 
if ModMatrix(1,2) == 1
    CE_ang=ModMatrix(1,1);
    %[som_mod_fas_ce,CE_novo]=CE_modulacao(hbwt,banco,M,CE_ang,fs,wavelet_N);
    %round_ce_novo = round(CE_novo);
    
    ang_estoc = 0.05;
    hbwt_CE_mod = CE_mod(hbwt,M,CE_ang);

% CE_novo=fas_centroid(hbwt_CE_mod,M,fs);

    [fas_det,fas_estoc,gamma] = FAS(hbwt_CE_mod,wavelet_N);
end

%% RHIP %%
if ModMatrix(2,2) == 1
    mod_eor = ModMatrix(2,1);
    %[som_mod,EOR_var_mod_1,~]=eor_modulacao(fas_det,fas_estoc,banco,mod_eor);
    fas_det = EOR_mod(fas_det,mod_eor);
end


%% EHBH %%
if ModMatrix(3,2) == 1
    modulacao_H = ModMatrix(3,1);
    [fas_estoc] = gamma_mod(fas_estoc,modulacao_H);
end

%% EE %%
if ModMatrix(4,2) == 1
    mod_ee = ModMatrix(4,1);
  %still empty
end


%% Tristimulos %%
if ModMatrix(5,2) == 1
    mod_ee = ModMatrix(5,1);
  %still empty
end
%% CCBH %%
    lpc_mod = 0; %initial value - if no modulations is selected
if ModMatrix(6,2) == 1
    lpc_mod = ModMatrix(6,1); %lpc mod - last one to mod before inverse operations
    %hbwt_lpc_mod = FAS_inversa(fas_det,fas_estoc,lpc_mod);
end


end

