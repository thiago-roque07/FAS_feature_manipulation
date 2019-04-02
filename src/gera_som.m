function x = gera_som(f,fs,dur,n_harm,inarm)

% gera sinal entrada %%

% fs=44000;
% f=110;
% n_harm=10;
% dur=1;
% 
t=0:1/fs:dur;

x=0;
for n=1:n_harm
    amp=1/(n);
%       amp=1/(n);

        x=x+amp*sin(2*pi*(f+(n*inarm))*t*n);
        x=x/(1.1*max(x));
end




