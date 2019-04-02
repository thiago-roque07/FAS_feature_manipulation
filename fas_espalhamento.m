function [EE,EE_pond]=fas_espalhamento(CE,hbwt,M,fs)

freq_vector = ((1:M/2).*(fs/M))';

for k=1:M/2
    
%     hb_var((2*k)-1) = RMS(hbwt((2*k)-1).Cw);
    hb_var((2*k)-1) = var(hbwt((2*k)-1).Cw);
    hb_freq((2*k)-1) = ((freq_vector(k)-CE)^2)*hb_var((2*k)-1);
       
    
%     hb_var(2*k) = RMS(hbwt(2*k).Cw);
    hb_var(2*k) = var(hbwt(2*k).Cw);
    hb_freq(2*k) = (freq_vector(k)-CE)^2*hb_var(2*k);
end



num = sum(hb_freq);
den = sum(hb_var);
EE = sqrt(num/den);
EE_pond = EE/CE;
end