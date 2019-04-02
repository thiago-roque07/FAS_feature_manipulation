function [fas_estoc_gamma] = gamma_mod (fas_estoc,H_mod)

fas_estoc_gamma = fas_estoc;

% gamma_mod = gamma_orig*(1-modulacao);
gamma_mod = - 2*H_mod;
amp_mod = 1+(H_mod./2);
% amp_mod = 1+(H_mod./1.5);

for k=1:length(fas_estoc)
    
    if fas_estoc(k).gamma(1) + gamma_mod < 0
        fas_estoc_gamma(k).gamma(1) = fas_estoc(k).gamma(1) + gamma_mod;
        fas_estoc_gamma(k).gamma(2) = fas_estoc(k).gamma(2) * amp_mod;
    else
        fas_estoc_gamma(k).gamma(1) = 0;
        fas_estoc_gamma(k).gamma(2) = fas_estoc(k).gamma(2)/amp_mod;
    end
    gamma_test_1(k) = fas_estoc_gamma(k).gamma(1);
    gamma_test_2(k) = fas_estoc_gamma(k).gamma(2);    
end
