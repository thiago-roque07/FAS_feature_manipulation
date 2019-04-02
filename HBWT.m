function hbwt=HBWT(som,banco,N)

% N é o nível de detalhe da transformada wavelet
M=length(banco.hk);
hbwt(M).a=zeros(size(filter(banco.hk(1).h,1,som)));


% 1a parte da HBWT: Separação de cada banda harmônica pelo banco de filtros MDCT 
for k=1:M
    
    hbwt(k).c = filter(banco.hk(k).h,1,som);
    hbwt(k).a = downsample(hbwt(k).c,M);
    
%     if var(abs(hbwt(k).a))<1*10e-10
    if var(abs(hbwt(k).a))<1*10e-20
        hbwt(k).a = ones(length(hbwt(1).a),1)*10e-10;   % Sinceramente, não lemrbo o motivo disto. Acredito que coeficientes de valor zero dão algum problema
    end
    
end



% 2a parte da HBWT: Análise Wavelet de cada banda harmônica
for k=1:M
    
    [Cw,Lw]=wavedec(hbwt(k).a,N,'db12');
%     hbwt(k).cA=Cw(1:Lw(1));

    hbwt(k).Cw = Cw;
    hbwt(k).Lw = Lw;
    
end

end
