function [file] = FAS_File_Modulation( handles )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%create mod_matrix - pre-allocate size 
%Value - checkbox
ModMatrix = zeros(6,2);
%assign mod values
    ModMatrix(1,1) = handles.slider_ceh.Value;
    ModMatrix(2,1) = handles.slider_rhip.Value;
    ModMatrix(3,1) = handles.slider_ehbh.Value;
    ModMatrix(4,1) = handles.slider_ee.Value;
    ModMatrix(5,1) = handles.slider_tr.Value;
    ModMatrix(6,1) = handles.slider_ccbh.Value;
%assign checkbox - (mod or not?)
    ModMatrix(1,2) = handles.checkbox_ceh.Value;
    ModMatrix(2,2) = handles.checkbox_rhip.Value;
    ModMatrix(3,2) = handles.checkbox_ehbh.Value;
    ModMatrix(4,2) = handles.checkbox_ee.Value;
    ModMatrix(5,2) = handles.checkbox_tr.Value;
    ModMatrix(6,2) = handles.checkbox_ccbh.Value;

%get values from file
    fas_det = handles.file.FAS.det ;
    fas_stoc = handles.file.FAS.stoc; 
    hbwt = handles.file.HBWT ;
    wavelet_N = handles.file.wavelet_N ;
    M = handles.file.M;
    fs = handles.file.fs_resample; %ou handles.file.fs_resample
    gamma = handles.file.FAS.gamma;
    banco = handles.file.banco;

%modulate descriptors
    [fas_det,fas_stoc,gamma,lpc_mod] = FAS_Mod_Descript(ModMatrix, fas_det , fas_stoc,gamma , hbwt , wavelet_N , M);
    FAS_values.det = fas_det;
    FAS_values.stoc = fas_stoc;
    FAS_values.gamma = gamma;

%Inverse FAS transformation
    hbwt = FAS_inversa(fas_det,fas_stoc,lpc_mod);

%calc new descritors
    
    [CEH,RHIP,EHBH,EE,TR_orig,CCBH] = FAS_Calc_Descript( fas_det,fas_stoc,gamma,hbwt, fs, M ); 

    Descript.CEH = CEH;
    Descript.RHIP = RHIP;
    Descript.EHBH = EHBH;
    Descript.EE = EE;
    Descript.Tr = TR_orig;
    Descript.CCBH = CCBH;

%% save in handles.Modfile - fas_det & stoc,hbwt and descriptors

    handles.Modfile.FAS = FAS_values;            %store FAS result in handles
    handles.Modfile.HBWT = hbwt;                 %store hbwt result in handles
    handles.Modfile.banco = banco;
    handles.Modfile.Descript = Descript;         %store Descriptores in handles
    handles.Modfile.f0 = handles.file.f0;               %store f0 in handles
    handles.Modfile.M = M;                       %store MDCT channel number in handles
    handles.Modfile.wavelet_N = wavelet_N;       %store wavelet depth in handles
    handles.Modfile.fs = fs;                     %store fs in handles - actually file.fs_resample
    
    
%% Display GUI new descriptor values
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
    set(handles.value_Mceh, 'String',CEH_gui)         %CEH - integer HZ            
    set(handles.value_Mrhip, 'String',RHIP1)           %RHIP - 3 decimal cases
    set(handles.value_Mehbh, 'String',EHBH_gui)              %EHBH
    set(handles.value_Mee, 'String',EE_gui)                  %EE
    set(handles.value_Mtr1, 'String',TR1)         %TRISTIMULUS
    set(handles.value_Mtr2, 'String',TR2)
    set(handles.value_Mtr3, 'String',TR3)
    set(handles.value_Mccbh, 'String',CCBH_gui)      %CCBH

%% Generate audio file    
    som_fas = IHBWT(hbwt,banco,0);                 % Inverse HBWT     
    som_fas_det = IHBWT(hbwt,banco,1);             % Inverse HBWT without stochastic content
    som_fas_stoc = IHBWT(hbwt,banco,2);           % Inverse HBWt without deterministic content
    
    %normalization
    som_fas = som_fas/max(som_fas); 
    som_fas_det = som_fas_det/max(som_fas_det);
    som_fas_stoc = som_fas_stoc/max(som_fas_stoc);
    
%plot new wave and spectrum
%fs_resample = handles.file.fs_resample;
t = (0:length(som_fas)-1)/fs;
axes(handles.axes3)       %choose axis3 to plot to
plot(t,som_fas)
xlabel('Time (s)')
ylabel('Magnitude')
ylim([-1.1 1.1])

%plot original file spectrum
axes(handles.axes4)       %choose axis1 to plot to
plot_spectrum(som_fas,fs);




%save ModMatrix to handles
    handles.Modfile.wavdata.detstoc = som_fas;                     %store det+stoc in handles
    handles.Modfile.wavdata.det = som_fas_det;                     %store det+stoc in handles
    handles.Modfile.wavdata.stoc = som_fas_stoc;                     %store det+stoc in handles
    handles.Modfile.ModMatrix = ModMatrix;

    file = handles.Modfile;
    
end

