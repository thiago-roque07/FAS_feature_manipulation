function [est_x_mod] = estoc_mod(ar_filt,noise,LPC_mod)

% n_wavelet = length(fas_estoc.env_cD);
% ar_filt = fas_estoc.lpc;    
exp_vec = 1:length(ar_filt);

ex = exp(-LPC_mod*exp_vec);
a_mod = (ex/max(ex)).*ar_filt;
est_x_mod = filter(1,a_mod,noise); 

% [Cw_estim,Lw_estim]=wavedec(est_x_mod,n_wavelet,'db12');