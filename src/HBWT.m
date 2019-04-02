function hbwt=HBWT(som,banco,N)

% N eh o nivel de detalhe da transformada wavelet
M=length(banco.hk);
hbwt(M).a=zeros(size(filter(banco.hk(1).h,1,som)));


% 1a parte da HBWT: Separa??o de cada banda harm?nica pelo banco de filtros MDCT 
for k=1:M
    
    hbwt(k).c = filter(banco.hk(k).h,1,som); %filter each harmonic
    hbwt(k).a = downsample(hbwt(k).c,M);     %all harmonics around frequency axis
    
%     if var(abs(hbwt(k).a))<1*10e-10
    if var(abs(hbwt(k).a))<1*10e-20
        hbwt(k).a = ones(length(hbwt(1).a),1)*10e-10;   % Sinceramente, n?o lemrbo o motivo disto. Acredito que coeficientes de valor zero d?o algum problema
    end
    
end



% 2a parte da HBWT: An?lise Wavelet de cada banda harm?nica
for k=1:M
    
    [Cw,Lw]=wavedec(hbwt(k).a,N,'db12');
%     hbwt(k).cA=Cw(1:Lw(1));

    hbwt(k).Cw = Cw;
    hbwt(k).Lw = Lw;
    
end

end
