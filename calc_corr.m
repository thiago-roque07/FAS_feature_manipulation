function c = calc_corr(x,desloc)

c = corrcoef(x(1:end-desloc),x((desloc+1):end));
c = c(1,2);

end