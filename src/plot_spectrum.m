function [y_ft,f]=plot_spectrum(y,Fs)


% t = (1/Fs)*(1:Nsamps);          %Prepare time data for plot

%Do Fourier Transform
% y_ft = abs(fft(y));            %Retain Magnitude
% y_ft = y_ft(1:Nsamps/2);      %Discard Half of Points
% f = (Fs*(0:Nsamps/2-1)/Nsamps);   %Prepare freq data for plot



% %Plot Sound File in Frequency Domain
% figure
% subplot()
% plot(f, 20*log10(abs(y_ft))) 
% % plot(log2(f), log2(abs(y_ft)))
% % plot(f, abs(y_ft))
% xlabel('Frequ?ncia (Hz)')
% ylabel('Magnitude (dB)')
% % title('Especto do som analisado')

Nsamps = length(y);
t = (1/Fs)*(1:Nsamps);          %Prepare time data for plot

%Do Fourier Transform
y_ft = abs(fft(y));            %Retain Magnitude
y_ft = y_ft(1:round(Nsamps/2));      %Discard Half of Points
f = (Fs*(0:round(Nsamps/2)-1)/Nsamps);   %Prepare freq data for plot

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Plot Sound File in Frequency Domain
plot(f, 20*log10(abs(y_ft))) 
% plot(log2(f), log2(abs(y_ft)))
% plot(f, abs(y_ft))
xlabel('Frequency (Hz)')
ylabel('Magnitude (dB)')
xlim([1 Fs/2])
% title('Especto do som analisado')