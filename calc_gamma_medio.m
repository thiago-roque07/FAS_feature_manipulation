function gamma_medio = calc_gamma_medio(gamma)

gamma_nz = gamma.*(gamma>=0.4);
gamma_medio = sum(gamma_nz)/sum(gamma>=0.4);

% gamma_medio = sum(gamma.^1.2)/length(gamma);

end