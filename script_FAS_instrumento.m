%%
% [x,fs_x] = audioread('Clar_sus.wav');   f=440;

% ---- D3 ----
% [x,fs_x] = audioread('BbClar.mf.D3B3.aiff'); x = x(110000:180000); f=145.8;
% ---- G3 ----
% [x,fs_x] = audioread('BbClar.mf.D3B3.aiff'); x = x(1200000:1270000); f=195.9;
% ---- D4 -----
% [x,fs_x] = audioread('BbClar.mf.C4B4.aiff'); x = x(540000:620000); f=291.6;

% [x,fs_x] = audioread('Clar_sus_A3.wav');  f=220.3;
% [x,fs_x] = audioread('Clar_ff_G3.wav'); f=195.9;
% [x,fs_x] = audioread('Clar_D4.wav'); f=293.5;
% [x,fs_x] = audioread('BbClarinet.ff.D3.stereo.aif'); x = (x(:,1)+x(:,2))/2; x = x(30000:100000); f=146.5;
% [x,fs_x] = audioread('BbClarinet.ff.G3.stereo.aif'); x = (x(:,1)+x(:,2))/2; x = x(40000:110000); f=196.3;
% [x,fs_x] = audioread('BbClarinet.ff.D4.stereo.aif'); x = (x(:,1)+x(:,2))/2; x = x(38000:110000); f=292.3;
% [x,fs_x] = audioread('BbClarinet.ff.G4.stereo.aif'); x = (x(:,1)+x(:,2))/2; x = x(23000:100000); f=392.1;
% [x,fs_x] = audioread('BbClarinet.ff.D5.stereo.aif'); x = (x(:,1)+x(:,2))/2; x = x(22000:100000); f=585.8;
% [x,fs_x] = audioread('BbClarinet.ff.G5.stereo.aif'); x = (x(:,1)+x(:,2))/2; x = x(30000:100000); f=783.9;

% % [x,fs_x] = audioread('Tromp.wav');    x = x(15000:170000); f=440;
% [x,fs_x] = audioread('Tromp_D4_ff.wav');     f=294.7;
% [x,fs_x] = audioread('Tromp_B3.wav');     f=247.8;
% [x,fs_x] = audioread('Tromp_A5.wav');     f=879.8;
% [x,fs_x] = audioread('Tromp_G4.wav');     f=393.7;
% [x,fs_x] = audioread('Trumpet.novib.ff.E3.stereo.aif');  f=165.8; x = (x(:,1)+x(:,2))/2; x = x(15000:end);

% [x,fs_x] = audioread('Trumpet.novib.ff.E3.stereo.aif');  f=165.6; x = (x(:,1)+x(:,2))/2; x = x(15000:150000);
% [x,fs_x] = audioread('Trumpet.novib.ff.G3.stereo.aif');  f=194.6; x = (x(:,1)+x(:,2))/2; x = x(15000:160000);
% [x,fs_x] = audioread('Trumpet.novib.ff.B3.stereo.aif');  f=247.9; x = (x(:,1)+x(:,2))/2; x = x(15000:150000);
% [x,fs_x] = audioread('Trumpet.novib.ff.D4.stereo.aif');  f=295; x = (x(:,1)+x(:,2))/2; x = x(15000:140000);
% [x,fs_x] = audioread('Trumpet.novib.ff.G4.stereo.aif');  f=393.8; x = (x(:,1)+x(:,2))/2; x = x(15000:150000);
% [x,fs_x] = audioread('Trumpet.novib.ff.D5.stereo.aif');  f=591.6; x = (x(:,1)+x(:,2))/2; x = x(15000:150000);
% [x,fs_x] = audioread('Trumpet.novib.ff.G5.stereo.aif');  f=786.5; x = (x(:,1)+x(:,2))/2; x = x(15000:150000);
% [x,fs_x] = audioread('Trumpet.novib.ff.A5.stereo.aif');  f=879.7; x = (x(:,1)+x(:,2))/2; x = x(15000:150000);

% [x,fs_x] = audioread('Oboe.wav');   f=441;
[x,fs_x] = audioread('Oboe_B3.wav');   f=247;
% [x,fs_x] = audioread('Oboe_G4.wav');   f=391.4;
% % [x,fs_x] = audioread('Oboe_C5.aif');   f=527;
% [x,fs_x] = audioread('Oboe.ff.B3.stereo.aif'); f=245.6; x = (x(:,1)+x(:,2))/2;

% [x,fs_x] = audioread('Oboe.ff.D4.stereo.aif'); f=293.7; x = (x(:,1)+x(:,2))/2; x = x(3000:65000);
% [x,fs_x] = audioread('Oboe.ff.G4.stereo.aif'); f=391.5; x = (x(:,1)+x(:,2))/2; x = x(6700:60000);
% [x,fs_x] = audioread('Oboe.ff.D5.stereo.aif'); f=589.9 ; x = (x(:,1)+x(:,2))/2; x = x(5800:54000);
% [x,fs_x] = audioread('Oboe.ff.G5.stereo.aif'); f=788.6 ; x = (x(:,1)+x(:,2))/2; x = x(5500:60000);
% [x,fs_x] = audioread('Oboe.ff.D6.stereo.aif'); f=1179 ; x = (x(:,1)+x(:,2))/2; x = x(5000:56000);
 
% [x,fs_x] = audioread('cello_orig_220.wav');   f=220.2;
% [x,fs_x] = audioread('Cello_A3.wav');   f=219.8;
% [x,fs_x] = audioread('Cello_D2.wav');   f=74.1;
% [x,fs_x] = audioread('Cello_G3.wav');   f=196.9;
% [x,fs_x] = audioread('cello_CE_recog.wav');     f=219.8;
% [x,fs_x] = audioread('Cello.arco.ff.sulA.E5.stereo.aif'); f=670 ; x = (x(:,1)+x(:,2))/2; x = x(4000:75000);
% % [x,fs_x] = audioread('Cello.arco.ff.sulC.C2.stereo.aif'); f=66.7 ; x = (x(:,1)+x(:,2))/2; x = x(18000:126000);
% [x,fs_x] = audioread('Cello.arco.ff.sulA.A3.stereo.aif'); f=220.6; x = (x(:,1)+x(:,2))/2; x = x(23000:95000);
% [x,fs_x] = audioread('Cello.arco.ff.sulD.A3.stereo.aif'); f=222.2; x = (x(:,1)+x(:,2))/2; x = x(20000:100000);


% [x,fs_x] = audioread('Cello.arco.ff.sulC.D2.stereo.aif'); f=74.17 ; x = (x(:,1)+x(:,2))/2; x = x(30000:110000);
% [x,fs_x] = audioread('Cello.arco.ff.sulC.G2.stereo.aif'); f=99.03 ; x = (x(:,1)+x(:,2))/2; x = x(2900:100000);
% [x,fs_x] = audioread('Cello.arco.ff.sulG.D3.stereo.aif'); f=149.2 ; x = (x(:,1)+x(:,2))/2; x = x(26000:110000);
% [x,fs_x] = audioread('Cello.arco.ff.sulD.G3.stereo.aif'); f=197.6 ; x = (x(:,1)+x(:,2))/2; x = x(19000:100000);
% [x,fs_x] = audioread('Cello.arco.ff.sulA.D4.stereo.aif'); f=293.4 ; x = (x(:,1)+x(:,2))/2; x = x(13000:95000);
% [x,fs_x] = audioread('Cello.arco.ff.sulA.G4.stereo.aif'); f=394.3; x = (x(:,1)+x(:,2))/2; x = x(13000:95000);


% [x,fs_x] = audioread('piano.wav');      f=439;

% [x,fs_x] = audioread('mA-C5-1.wav');    f=525.3;

% [x,fs_x] = audioread('qC-C5-2-tu.wav'); f=529.2;

% [x,fs_x] = audioread('rA-C5-1.wav');    f=526.9; 

%%
n_harm=30;                      % Determina quantos harmônicos serão avaliados
fs = round(f*2*n_harm);         % Calcula a nova taxa de amostragem de acordo com o número de harmônicos e a fundamental
x = x/(1.1*max(x));             % Normaliza o sinal (com alguma margem)
som = resample(x,fs,fs_x);      % Reamostra o sinal

%%
wavelet_N=5;                    % Determina a profundidade da análise Wavelet
M=round(fs/f);                  % Determina o número de canais da MDCT

l = length(som);
som = som.*tukeywin(l,0.3);     % Janela o sinal para eliminar transientes de ataque ou release

banco = MDCT_KBD(M,fs);         % Cria o banco de filtros da MDCT através do método de janelamento Kaiser-Bessel

hbwt = HBWT(som,banco,wavelet_N);                   % Realiza a transformada HBWT

%%  Transformada inversa HBWT sem passar pela FAS

%[som_hbwt_det,hbwt_mod1] = IHBWT(hbwt,banco,1);     % Realiza a transformada inversa anulando o conteúdo estocástico (somente para testes) 
%[som_hbwt_estoc,hbwt_mod2] = IHBWT(hbwt,banco,2);   % Realiza a transformada inversa anulando o contúdo determinístico (somente para testes)    
[som_hbwt,hbwt_mod3] = IHBWT(hbwt,banco,0);         % Realiza a transformada inversa (somente para testes)

%% FAS

[fas_det,fas_estoc,gamma] = FAS(hbwt,wavelet_N);    % Realiza a transformada FAS

lpc_mod=0;
hbwt_novo = FAS_inversa(fas_det,fas_estoc,lpc_mod); % Realiza a transformada FAS inversa
som_fas = IHBWT(hbwt_novo,banco,0);                 % Realiza a transformada HBWT inversa    

som_fas_det = IHBWT(hbwt_novo,banco,1);             % Realiza a trtansformada HBWT inversa anulando o conteúdo estocástico
som_fas_estoc = IHBWT(hbwt_novo,banco,2);           % Realiza a trtansformada HBWT inversa anulando o conteúdo determinístico