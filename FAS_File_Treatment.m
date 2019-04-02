function [file] = FAS_File_Treatment(handles )
%function [FAS_values,Descript,f0_frame] = FAS_File_Treatment(handles )
%Initial File treatment - before application of transforms

%convert from stereo to mono
audioIn = handles.file.wavdata;
fs = handles.file.fs;
n_harm = handles.file.n_harm;
x = sum(audioIn, 2) / size(audioIn, 2);
x = x/(1.1*max(abs(x)));

t = (0:length(audioIn)-1)/fs;

%plot current file
axes(handles.axes1)       %choose axis1 to plot to
handles.current_data = x;
plot(t,handles.current_data)
xlabel('Time (s)')
ylabel('Magnitude')

%plot original file spectrum
axes(handles.axes2)       %choose axis1 to plot to
plot_spectrum(x,handles.file.fs);


% DEFINE PITCH
n = 1024;
[time,f0] = yin_estimator_frame(x,fs,n); %Hz Oboe 247
flag = find(f0~=0 & f0~=inf);
f0_frame = mean(f0(flag));
%plot(time,f0)

% Resample audio
fs_resample = round(f0_frame*2*n_harm); %new FS according to n_harm
som = resample(x,fs_resample,fs);
l = length(som);
som = som.*tukeywin(l,0.3);     % Janela o sinal para eliminar transientes de ataque ou release
% MDCT
M=round(fs_resample/f0_frame);                   % MDCT channels
banco = MDCT_KBD(M,fs_resample);         % Filter bank through Kaiser-Bessel windowing

% HBWT
wavelet_N=5;                               % Wavelet depth
hbwt = HBWT(som,banco,wavelet_N);                   % HBWT transformation

% FAS
[fas_det,fas_estoc,gamma] = FAS(hbwt,wavelet_N);    % FAS transformation
FAS_values.det = fas_det;
FAS_values.stoc = fas_estoc;
FAS_values.gamma = gamma;
%FAS_values = {fas_det,fas_estoc,gamma};

%% Descritors calculation
[CEH,RHIP,EHBH,EE,TR_orig,CCBH] = FAS_Calc_Descript( fas_det,fas_estoc,gamma,hbwt, fs_resample, M );
%Descript = {CEH,RHIP,EHBH,EE,TR_orig,CEBH};
Descript.CEH = CEH;
Descript.RHIP = RHIP;
Descript.EHBH = EHBH;
Descript.EE = EE;
Descript.Tr = TR_orig;
Descript.CCBH = CCBH;


%% Save in handles
    handles.file.FAS = FAS_values;            %store FAS result in handles
    handles.file.HBWT = hbwt;                 %store hbwt result in handles
    handles.file.banco = banco;
    handles.file.Descript = Descript;         %store Descriptores in handles
    handles.file.f0 = f0_frame;               %store f0 in handles
    handles.file.M = M;                       %store MDCT channel number in handles
    handles.file.wavelet_N = wavelet_N;       %store wavelet depth in handles
    handles.file.fs_resample = fs_resample;                 %store resampled frequency
    
    %Show in GUI
    %F0
    f0_char = num2str(round(f0_frame*100)/100);  %round and transform to char f0
    set(handles.pitch_file, 'String',f0_char);   %show f0 in GUI
    %Descriptors
    %decimal cases
    CEH_gui = strcat(num2str(round(CEH)),' Hz');
    RHIP1 = round(RHIP{1}*1000)/1000;  
    EHBH_gui = round(EHBH*1000)/1000;
    EE_gui = round(EE*1000)/1000;
    TR1 = round(TR_orig(1)*1000)/1000;
    TR2 = round(TR_orig(2)*1000)/1000;
    TR3 = round(TR_orig(3)*1000)/1000;
    CCBH_gui = round(CCBH{1}*1000)/1000;
    %Show in GUI
    set(handles.value_ceh, 'String',CEH_gui)         %CEH - integer HZ            
    set(handles.value_rhip, 'String',RHIP1)           %RHIP - 3 decimal cases
    set(handles.value_ehbh, 'String',EHBH_gui)              %EHBH
    set(handles.value_ee, 'String',EE_gui)                  %EE
    set(handles.value_tr1, 'String',TR1)         %TRISTIMULUS
    set(handles.value_tr2, 'String',TR2)
    set(handles.value_tr3, 'String',TR3)
    set(handles.value_ccbh, 'String',CCBH_gui)      %CCBH
    file = handles.file;
    
    

end

