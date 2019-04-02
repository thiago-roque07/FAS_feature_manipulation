function fas_det_EOR_mod = EOR_mod(fas_det,mod)


    fas_det_EOR_mod = fas_det;

    
    alpha = nthroot(mod,2);
    
    fas_det_EOR_mod(1:2:end,:) = fas_det(1:2:end,:)*alpha;
    fas_det_EOR_mod(2:2:end,:) = fas_det(2:2:end,:)/alpha;

    
end