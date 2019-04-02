function [EOR_var,energia_par_var,energia_impar_var] = fas_eor_2(fas_det)


    fas_impar = fas_det(1:2:end,:);
    fas_impar_var = var(abs(fas_impar'));

    fas_par = fas_det(2:2:end,:);
    fas_par_var = var(abs(fas_par'));

    mini=min((log2(nonzeros(fas_impar_var))));
    energia_impar_var = sum((-mini+log2(nonzeros(fas_impar_var))));
    energia_par_var = sum((-mini+log2(nonzeros(fas_par_var))));

%      energia_impar_var = sum((log2(nonzeros(fas_impar_var))/min(nonzeros(fas_impar_var))));
%      energia_par_var = sum((log2(nonzeros(fas_par_var))/min(nonzeros(fas_par_var))));

%     EOR_var = energia_impar_var/energia_par_var;
    EOR_var = energia_par_var/energia_impar_var;