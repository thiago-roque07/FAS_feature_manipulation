function coef_N=DWT_coef(Cw,Lw,N)

if N==1
    coef_N = Cw(1:(Lw(1)));
else
coef_N = Cw(sum(Lw(1:(N-1)))+1:sum(Lw(1:N)));

end