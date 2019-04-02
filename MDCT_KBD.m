function banco=MDCT_KBD(M,fs)

%% Passo 1
% entrar valor de p (roll-off factor), M (numero de subbandas) e Aa (atenuacao da banda de corte)
p=0.5;
Aa=-50;


%% Passo 2
% Calcular o ripple da banda de corte (sig)
sig=10^(0.05*Aa);

%% Passo 3
% Calcular a frequencia de regeicao
wa=((1+p)*pi)/(2*M);

%% Passo 4
% Calcular o parametro D a partir dos valores tabelados de 'a', 'b' e 'c'

% Para Aa = -90
% a=-0.001839;
% b=-0.688;
% c=0.9994;

% Para Aa = -50
a=-0.03096;
b=-0.6345;
c=1.015;

D=(a*p^2)+(b*p)+c;

%% Passo 5
% Calcular a frequencia de passagem
wp=D*pi/(2*M);


%% Passo 6
% Encontra os parametros alpha e N da janela de kaiser
Bt = wa-wp;
alph = 0.1102*(Aa-8.7);
N = ceil((-Aa-8)/(2.285*Bt));

if mod(N,M)~=0
    Nk=N+(M-mod(N,M));
else
    Nk=N;
end

K=kaiser(Nk,alph);


%% Passo 7
wc=(wa+wp)/2;

%% Passo 8
% Calcula a Resp. Inpulso do filtro ideal
n=0:Nk-1;

hid=(wc/pi)*sinc((wc*(n-(Nk/2)))/pi);
% hid(floor(Nk/2)+1) = 2*wc;


%% Obtem o filtro real pelo janelamento do filtro ideal
hp=K.*hid';

banco.h0=hp;
banco.hk(M).h=[];

w = 0:1/1000:pi;
w_hz = w*fs/(2*pi);
H = freqz(hp,1,w);

fs=44000;

% subplot(211)
% plot(n,hp);
% % axis([0 N -0.05 0.1]);
% title('hp(n)')
% 
% subplot(212)
% plot(w_hz,20*log10(abs(H)));
% % axis([0 24 -90 10])
% title('H(w) in dB')
% xlabel('f (kHz)')


%% Modular o filtro protótipo
h_s(Nk) = 0;
f_s(Nk) = 0;
for k=1:M
    for n=1:Nk
        
        h_s(n) = 2*hp(n)*cos((pi/M)*(k+0.5)*(n-(Nk/2))+((pi/4)*(-1)^k));
        f_s(n) = 2*hp(n)*cos((pi/M)*(k+0.5)*(n-(Nk/2))-((pi/4)*(-1)^k));
        
    end
    banco.hk(k).h = h_s;
    banco.fk(k).h = f_s;
end




% figure;
% for k=1:M
%     
%     H = freqz(banco.hk(k).h,1,w);
%     
%     plot(w_hz,20*log10(abs(H)));
%     % axis([0 24 -90 10])
%     title('H(w) in dB')
%     xlabel('f (kHz)')
%     hold on
% end

end

