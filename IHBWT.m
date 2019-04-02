function [som_mod,hbwt]=IHBWT(hbwt,banco,z)


M=length(banco.fk);

for k=1:M
    
    %% Limpa conteudo estocastico ou deterministico%%
    if z==1 % Limpa o conteúdo estocástico
      hbwt(k).Cw(hbwt(k).Lw(2)+1:end) = 0;   
    elseif z==2 % Limpa o conteúdo determinístico
      hbwt(k).Cw(1:hbwt(k).Lw(2)) = 0; 
    end
    %%
    
    x_idwt = waverec(hbwt(k).Cw,hbwt(k).Lw,'db12');
    x_resample = upsample(x_idwt,M);
    x_imdct(k,:) = filter(banco.fk(k).h,1,x_resample);

%     x_imdct(k,:) = filter(banco.fk(k).h,1,x_idwt);
    
end

som_mod = sum(x_imdct).*31;         % Compensa perdas de intensidade do processo
% som_mod = som_mod/max(som_mod);

end
