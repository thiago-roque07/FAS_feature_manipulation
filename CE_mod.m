function hbwt_CE_mod = CE_mod(hbwt,M,ang)

a=1:M;
% a=sin(1.7*a.^2.5);

% C_zero = (2*CE)/fs;
% C_zero = 0.5;

bend = abs(ang)*0.009;

%lin = 1-(C_zero*ang + (C_zero.^2)*bend);
    vec = ((bend*(a.^2)+ang*a));
if ang<0
    vec = vec + (1-vec(end));
elseif ang>0
    vec = vec + (1-vec(1));
% else
%     vec = ones(size(a));
end
% plot(vec);


hbwt_CE_mod = hbwt;
for k=1:M
    
    hbwt_CE_mod(k).Cw = hbwt(k).Cw*vec(k);
%     hbwt_CE_mod(k).Cw(1:hbwt(1).Lw(1)) = hbwt(k).Cw(1:hbwt(1).Lw(1)) *vec(k);

end

end
 
 