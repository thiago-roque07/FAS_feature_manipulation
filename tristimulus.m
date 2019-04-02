function TR=tristimulus(fas_det)

TR = zeros(1,3);

FAS_tr1 = rms(abs(fas_det(1,:)));
FAS_tr2 = sum(rms(abs(fas_det(2:4,:)')));
FAS_tr3 = sum(rms(abs(fas_det(5:end,:)')));

den = sum(rms(abs(fas_det(1:end,:)')));

TR(1)= FAS_tr1/den;
TR(2)= FAS_tr2/den;
TR(3)= FAS_tr3/den;

end