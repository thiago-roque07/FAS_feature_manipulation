function CEH=fas_centroid_harmonico(fas_det,M,fs)

% freq_vector = ((1:M/2).*(fs/M))';
% 
% hb_rms = zeros(1,M/2);
% % hb_freq = zeros(1,M/2);
% 
% for k=1:M/2
%     
%     hb_rms(k) = var(abs(fas_det(k,:)));
%     hb_rms1(k) = rms(abs(fas_det(k,:)));
% %     hb_freq(k) = hb_rms(k).*freq_vector(k);
%     
% end
% if min(hb_rms) == 0
%     hb_rms = hb_rms +0.000001;
%     hb_rms_log = log(hb_rms/(min(hb_rms)))';
% else
%     hb_rms_log = log(hb_rms/(min(hb_rms)))';
% end
% 
% 
% hb = (hb_rms_log/max(hb_rms_log));
% hb_freq = (hb.^3).*freq_vector;
% 
% num = sum(hb_freq);
% den = sum(hb.^3);
% CEH = num/den;



freq_vector = ((1:M/2).*(fs/M));

hb_rms = zeros(1,M/2);
% hb_freq = zeros(1,M/2);

for k=1:M/2
    
%     hb_rms(k) = var(abs(fas_det(k,:)));
    hb_rms(k) = rms(abs(fas_det(k,:)));
%     hb_freq(k) = hb_rms(k).*freq_vector(k);
    
end

hb = (hb_rms/max(hb_rms));
hb_freq = (hb).*freq_vector;

num = sum(hb_freq);
den = sum(hb);
CEH = num/den;


end