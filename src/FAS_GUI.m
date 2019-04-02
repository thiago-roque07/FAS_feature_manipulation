function varargout = FAS_GUI(varargin)
% FAS_GUI MATLAB code for FAS_GUI.fig
%      FAS_GUI, by itself, creates a new FAS_GUI or raises the existing
%      singleton*.
%
%      H = FAS_GUI returns the handle to a new FAS_GUI or the handle to
%      the existing singleton*.
%
%      FAS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FAS_GUI.M with the given input arguments.
%
%      FAS_GUI('Property','Value',...) creates a new FAS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FAS_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FAS_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FAS_GUI

% Last Modified by GUIDE v2.5 27-May-2018 15:30:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FAS_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @FAS_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FAS_GUI is made visible.
function FAS_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FAS_GUI (see VARARGIN)

% Choose default command line output for FAS_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FAS_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%set(get(handles.axes1, 'title'), 'string', 'Original File')  %%Title to figure 1





% --- Outputs from this function are returned to the command line.
function varargout = FAS_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function fileinput_Callback(hObject, eventdata, handles)
% hObject    handle to fileinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileinput as text
%        str2double(get(hObject,'String')) returns contents of fileinput as a double


% --- Executes during object creation, after setting all properties.
function fileinput_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileinput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.wav', 'Select a wave file','MultiSelect','off');
if filename==0
    msgbox('No file chosen. Please choose a file to process.');
else
    nwavfile = fullfile(pathname, filesep, filename);
    handles.file.nwavfile = nwavfile;
    
    [audioIn,fs] = audioread(nwavfile); %read wav file
    handles.file.wavdata = audioIn;
    handles.file.fs = fs;
    

    
    %Change InputFile GUI by the name of the file chosen
    set(handles.input_file, 'String',filename);
    


    %PROCESS AUDIO FILE
    
    handles.file.n_harm = str2num(handles.n_harm.String); %get the n_harmonics chosen GUI
    
    %extract pitch and apply FAS transform and descriptors calculation:
    handles.file = FAS_File_Treatment(handles); 
    

    
    %Display Descriptors - original values
    
    guidata(hObject, handles);
end


% Check if the user selected one file or multiple
%https://www.mathworks.com/matlabcentral/answers/281895-reading-audio-file-using-gui-pushbutton-and-saving-them-to-a-folder
% if iscell(filename)
%      nfiles = length(filename);
%      nwavfile = cell(1,nfiles);
%      for i = 1:nfiles
%          nwavfile{i,1} = fullfile(pathname, filesep, filename{1,i});
%          %Enter the command to save nwavfile{1,i} here
%      end
% elseif filename==0
%     message = msgbox('No file chosen')
%     %Stop callback
% else
%      nwavfile{1,1} = fullfile(pathname, filesep, filename);
%      %Enter the command to save nwavfile here
% end









% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.Modfile = FAS_File_Modulation( handles );

%save to gui
guidata(hObject, handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch handles.popupmenu1.Value
    case 1 
        som = handles.Modfile.wavdata.detstoc;
    case 2
        som = handles.Modfile.wavdata.det;
    case 3 
        som = handles.Modfile.wavdata.stoc;
end
sound(som,handles.Modfile.fs)



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter desired file name to save:'}
title = 'Save Input';
dims = [1 35];
nome = strcat('FAS_',handles.input_file.String);
definput = {nome};
[file,path] = uiputfile(nome); %% GET NAME FROM FILENAME
complete_path = strcat(path,file);
handles.Modfile.savedata = complete_path;
%answer = inputdlg(prompt,title,dims,definput); %DESIRED SAVED FILE NAME
%audiowrite(filename,y,Fs) falta arquivo alterado que sera o y


switch handles.popupmenu1.Value
    case 1 
        som = handles.Modfile.wavdata.detstoc;
    case 2
        som = handles.Modfile.wavdata.det;
    case 3 
        som = handles.Modfile.wavdata.stoc;
end
audiowrite(complete_path,som,handles.Modfile.fs) %concertar

guidata(hObject, handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function n_harm_Callback(hObject, eventdata, handles)
% hObject    handle to n_harm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n_harm as text
%        str2double(get(hObject,'String')) returns contents of n_harm as a double


% --- Executes during object creation, after setting all properties.
function n_harm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n_harm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in play_orig_button.
function play_orig_button_Callback(hObject, eventdata, handles)
% hObject    handle to play_orig_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sound(handles.file.wavdata/max(handles.file.wavdata),handles.file.fs) %normalization


% --- Executes on slider movement.
function slider_ceh_Callback(hObject, eventdata, handles)
% hObject    handle to slider_ceh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
% test it out - get the handles object and write the current value
 % to the edit box
 %handles = guidata(hFigure);
 sliderValue = get(handles.slider_ceh,'Value');
 set(handles.coef_ceh,'String',num2str(sliderValue));

% --- Executes during object creation, after setting all properties.
function slider_ceh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_ceh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_rhip_Callback(hObject, eventdata, handles)
% hObject    handle to slider_rhip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
 sliderValue = get(handles.slider_rhip,'Value');
 set(handles.coef_rhip,'String',num2str(sliderValue));

% --- Executes during object creation, after setting all properties.
function slider_rhip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_rhip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_ehbh_Callback(hObject, eventdata, handles)
% hObject    handle to slider_ehbh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
 sliderValue = get(handles.slider_ehbh,'Value');
 set(handles.coef_ehbh,'String',num2str(sliderValue));

% --- Executes during object creation, after setting all properties.
function slider_ehbh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_ehbh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_ee_Callback(hObject, eventdata, handles)
% hObject    handle to slider_ee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
 sliderValue = get(handles.slider_ee,'Value');
 set(handles.coef_ee,'String',num2str(sliderValue));

% --- Executes during object creation, after setting all properties.
function slider_ee_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_ee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_tr_Callback(hObject, eventdata, handles)
% hObject    handle to slider_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
 sliderValue = get(handles.slider_tr,'Value');
 set(handles.coef_tr,'String',num2str(sliderValue));

% --- Executes during object creation, after setting all properties.
function slider_tr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider_ccbh_Callback(hObject, eventdata, handles)
% hObject    handle to slider_ccbh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
 sliderValue = get(handles.slider_ccbh,'Value');
 set(handles.coef_ccbh,'String',num2str(sliderValue));

% --- Executes during object creation, after setting all properties.
function slider_ccbh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_ccbh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in checkbox_ceh.
function checkbox_ceh_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ceh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ceh


% --- Executes on button press in checkbox_rhip.
function checkbox_rhip_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_rhip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_rhip


% --- Executes on button press in checkbox_ehbh.
function checkbox_ehbh_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ehbh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ehbh


% --- Executes on button press in checkbox_ee.
function checkbox_ee_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ee


% --- Executes on button press in checkbox_tr.
function checkbox_tr_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_tr


% --- Executes on button press in checkbox_ccbh.
function checkbox_ccbh_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ccbh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_ccbh






function coef_ceh_Callback(hObject, eventdata, handles)
% hObject    handle to coef_ceh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coef_ceh as text
%        str2double(get(hObject,'String')) returns contents of coef_ceh as a double
 sliderValue = get(handles.coef_ceh,'String');
 set(handles.slider_ceh,'Value',str2num(sliderValue));



function coef_rhip_Callback(hObject, eventdata, handles)
% hObject    handle to coef_rhip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coef_rhip as text
%        str2double(get(hObject,'String')) returns contents of coef_rhip as a double
 sliderValue = get(handles.coef_rhip,'String');
 set(handles.slider_rhip,'Value',str2num(sliderValue));



function coef_ehbh_Callback(hObject, eventdata, handles)
% hObject    handle to coef_ehbh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coef_ehbh as text
%        str2double(get(hObject,'String')) returns contents of coef_ehbh as a double
 sliderValue = get(handles.coef_ehbh,'String');
 set(handles.slider_ehbh,'Value',str2num(sliderValue));



function coef_ee_Callback(hObject, eventdata, handles)
% hObject    handle to coef_ee (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coef_ee as text
%        str2double(get(hObject,'String')) returns contents of coef_ee as a double
 sliderValue = get(handles.coef_ee,'String');
 set(handles.slider_ee,'Value',str2num(sliderValue));



function coef_tr_Callback(hObject, eventdata, handles)
% hObject    handle to coef_tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coef_tr as text
%        str2double(get(hObject,'String')) returns contents of coef_tr as a double
 sliderValue = get(handles.coef_tr,'String');
 set(handles.slider_tr,'Value',str2num(sliderValue));



function coef_ccbh_Callback(hObject, eventdata, handles)
% hObject    handle to coef_ccbh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coef_ccbh as text
%        str2double(get(hObject,'String')) returns contents of coef_ccbh as a double
 sliderValue = get(handles.coef_ccbh,'String');
 set(handles.slider_ccbh,'Value',str2num(sliderValue));


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

%CHANGE PLOTS FOR MODDED FILE
%plot new wave and spectrum
fs_resample = handles.Modfile.fs;
axes(handles.axes3)       %choose axis3 to plot to
switch handles.popupmenu1.Value
    case 1 
        som = handles.Modfile.wavdata.detstoc;
    case 2
        som = handles.Modfile.wavdata.det;
    case 3 
        som = handles.Modfile.wavdata.stoc;
end
t = (0:length(som)-1)/fs_resample;
plot(t,som)
xlabel('Time (s)')
ylabel('Magnitude')
ylim([-1.1 1.1])

%plot original file spectrum
axes(handles.axes4)       %choose axis1 to plot to
plot_spectrum(som,fs_resample);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over slider_rhip.
function slider_rhip_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to slider_rhip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = sprintf('Steps to process file:\n1 - Click on "Load File" to choose a file to process;\n2 - If you want, click on "Play File" to play the original file;\n3 - Choose a coeficient value by dragging the slider or inputting directly on the corresponding box. Do not forget to check the box if you want to modulate that descriptor;\n4 - Press the red "Process File" button to begin processing;\n5 - Choose to play or save the 3 configurations of the modulated signal available, Deterministic only, Stochastic only or both;\n6 - To modulate again, go back to step 4.');
mensagem= msgbox(a,'TUTORIAL','help');
