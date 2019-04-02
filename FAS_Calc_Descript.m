function [CEH,RHIP,EHBH,EE,TR_orig,CCBH] = FAS_Calc_Descript( fas_det,fas_estoc,gamma,hbwt, fs, M )
%FAS_Calc_Descrit - calculates all the descritors values based on the FAS
%values for the determinant and stochastic parts, the gamma value and the
%hbwt.

%% CE %% 
CEH=fas_centroid_harmonico(fas_det,M,fs);
roud_ce = round(CEH);


%% RHIP %%
[EOR_var_1,energia_par_var_1,energia_impar_var_1] = fas_eor_2(fas_det);
RHIP = {EOR_var_1,energia_par_var_1,energia_impar_var_1};

%% EHBH %%
gamma_medio = calc_gamma_medio(gamma);
EHBH = fas_hurst(gamma_medio);

%% EE %%
EE_orig = fas_espalhamento(CEH,hbwt,M,fs);
EE_orig_norm = EE_orig/CEH;
EE = EE_orig_norm;


%% Tristimulos %%
TR_orig = tristimulus(fas_det);

%% CCBH %%
desloc = 12;
[c_est,corr_medio] = estoc_analise_novo(fas_estoc,0,desloc);
CCBH = {corr_medio,c_est};
end

