%%

f_sen = 880;
n_harm_espectro = 30;
noise = 0.01;
inarmonicidade = 0;

fs = f_sen*2*n_harm_espectro;
n_harm_sen = 1;
dur = 1;
som1 = gera_som(f_sen,fs,dur,n_harm_sen,inarmonicidade)';
som = som1 + wgn(dur*fs+1,1,0)*noise;

som=som/max(1.1*som);
f = f_sen;

%%
wavelet_N=5;
M=fs/f;

l = length(som);
som = som.*tukeywin(l,0.3);

% y_fft=ff(som,fs);

% banco = MDCT(M,fs);
banco = MDCT_KBD(M,fs);

hbwt = HBWT(som,banco,wavelet_N);
[som_hbwt_det,hbwt_mod1] = IHBWT(hbwt,banco,1);
[som_hbwt_estoc,hbwt_mod2] = IHBWT(hbwt,banco,2);
[som_hbwt,hbwt_mod3] = IHBWT(hbwt,banco,0);

[fas_det,fas_estoc,gamma] = FAS(hbwt,wavelet_N);

lpc_mod=0;
hbwt_novo = FAS_inversa(fas_det,fas_estoc,lpc_mod);

som_fas_det = IHBWT(hbwt_novo,banco,1);
som_fas_estoc = IHBWT(hbwt_novo,banco,2);
som_fas = IHBWT(hbwt_novo,banco,0);