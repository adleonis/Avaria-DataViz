function varargout = Avaria_v01(varargin)
% AVARIA_V01 M-file for Avaria_v01.fig
%      AVARIA_V01, by itself, creates a new AVARIA_V01 or raises the existing
%      singleton*.
%
%      H = AVARIA_V01 returns the handle to a new AVARIA_V01 or the handle to
%      the existing singleton*.
%
%      AVARIA_V01('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AVARIA_V01.M with the given input arguments.
%
%      AVARIA_V01('Property','Value',...) creates a new AVARIA_V01 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Avaria_v01_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Avaria_v01_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help Avaria_v01

% Last Modified by GUIDE v2.5 06-Feb-2006 11:16:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Avaria_v01_OpeningFcn, ...
                   'gui_OutputFcn',  @Avaria_v01_OutputFcn, ...
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


% --- Executes just before Avaria_v01 is made visible.
function Avaria_v01_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Avaria_v01 (see VARARGIN)

% Choose default command line output for Avaria_v01
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Avaria_v01 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.save_to_file,'String','Save')
set(handles.pushbutton4,'String','Previous')
set(handles.pushbutton6,'String','Next')
set(handles.plot_fit,'String','Calculate Polynomial Fit')

set(handles.axes1,'XTickLabel',{' '})
set(handles.axes1,'YTickLabel',{' '})
box on

set(handles.axes2,'XTickLabel',{' '})
set(handles.axes2,'YTickLabel',{' '})
box on

set(handles.axes3,'XAxisLocation','Top')
set(handles.axes3,'yAxisLocation','Left')
set(handles.axes3,'Fontname','Courier')
set(handles.axes3,'Fontsize',7)
%set(handles.axes3,'XTickLabel',{' '})
%set(handles.axes3,'YTickLabel',{' '})
box on

set(handles.axes4,'XAxisLocation','Top')
set(handles.axes4,'yAxisLocation','Right')
set(handles.axes4,'Fontname','Courier')
set(handles.axes4,'Fontsize',7)
box on


% --- Outputs from this function are returned to the command line.
function varargout = Avaria_v01_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename
global file
global dir
global averaged
[filename] = make_dirname(hObject,'res',{dir file});
set(handles.save_name,'String',strcat(dir,'\',file(1:2),'\',file(1:2)))
%Get pixel/cm
[pixdx pixdy]=get_pixdxdy(filename);

dir=get(handles.dirname,'String');
file=get(handles.edit3,'String');
%Assure current parameters
check_params_Callback(hObject, eventdata, handles)
%Plots
axes(handles.axes1)
axis off
om_mask_select1(hObject,'reserved',{get(handles.popupmenu1,'Value') get(handles.slider4,'Value') get(handles.slider5,'Value') get(handles.slider6,'Value') get(handles.slider7,'Value') get(handles.slider1,'Value') get(handles.slider2,'Value') filename});
plot_om_field(hObject,'reserved',filename)
axes(handles.axes2)
%axis off
[averaged] = om_mask_select2(hObject,'reserved',{get(handles.popupmenu1,'Value') get(handles.slider4,'Value') get(handles.slider5,'Value') get(handles.slider6,'Value') get(handles.slider7,'Value') get(handles.slider1,'Value') get(handles.slider2,'Value') filename});

global axes2_ymax
global axes2_ymin
axes2_ymax=max(averaged(:,2));
axes2_ymin=min(averaged(:,2));
global axes2_xmax
global axes2_xmin
axes2_xmax=averaged(size(averaged(:,1),1),1);
axes2_xmin=averaged(1,1);
xlim([axes2_xmin axes2_xmax]);

%axes('YAxisLocation','right')
%axis off



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename
axes(handles.axes1);
plot_om_field(hObject,'reserved',filename);



% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(hObject,'String','Previous');
global filename
global file
[file] = what_next(hObject,'res',-1);
set(handles.edit3,'String',file);
pushbutton2_Callback(hObject, eventdata, handles);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename
global file
set(hObject,'String','Next');
[file] = what_next(hObject,handles,1);
set(handles.edit3,'String',file);
pushbutton2_Callback(hObject, eventdata, handles);



% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
global funk_id
funk_id=get(hObject,'Value');

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
set(hObject,'string',{'y = a*x + b' 'y = a*Sin([x-d]/c) + b'});












% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global slider1value
%slider1value=get(hObject,'Value');
pushbutton2_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'value',0.01);



% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global slider2value
%slider2value=get(hObject,'Value');
pushbutton2_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'value',1);



% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global slider4value
slider4value=get(hObject,'Value');
global funk_id
funk_id=get(handles.popupmenu1,'Value')
if funk_id==1
    set(hObject,'Min',-1);
    set(hObject,'Max',1);
    set(hObject,'SliderStep',[0.005 0.01])
elseif funk_id==2
    set(hObject,'Min',-1);
    set(hObject,'Max',1);
    set(hObject,'SliderStep',[0.01 0.5])
end
pushbutton2_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
%hold on
%[outputs] = om_mask_select({1 slider4value slider5value 1 0 slider1value slider2value name})
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'value',0.5);




% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global slider5value
%slider5value=get(hObject,'Value');
pushbutton2_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
%hold on
%[outputs] = om_mask_select({1 slider4value slider5value 1 0 slider1value slider2value name})
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'value',0.5);



% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
pushbutton2_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'value',1);

set(hObject,'Max',20);
set(hObject,'Min',0.01);



% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
pushbutton2_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'value',0);
set(hObject,'Max',100);
set(hObject,'Min',-100);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  SPREAD LIMIT SLIDERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on slider movement.
function SpreadA1_Callback(hObject, eventdata, handles)
% hObject    handle to SpreadA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global spreadA1
SpreadA1=get(hObject,'Value');
plot_axes2_limits(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function SpreadA1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpreadA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.2);

% --- Executes on slider movement.
function SpreadA2_Callback(hObject, eventdata, handles)
% hObject    handle to SpreadA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global spreadA2
SpreadA2=get(hObject,'Value');
plot_axes2_limits(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function SpreadA2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpreadA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.45);

% --- Executes on slider movement.
function SpreadB1_Callback(hObject, eventdata, handles)
% hObject    handle to SpreadB1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global spreadB1
SpreadB1=get(hObject,'Value');
plot_axes2_limits(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function SpreadB1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpreadB1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject,'Value',0.55)

% --- Executes on slider movement.
function SpreadB2_Callback(hObject, eventdata, handles)
% hObject    handle to SpreadB2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global spreadB2
SpreadB2=get(hObject,'Value');
plot_axes2_limits(hObject,eventdata,handles);

function SpreadB2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SpreadB2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
%set(hObject,'Min',0)
set(hObject,'Value',0.75)

function plot_axes2_limits(hObject,eventdata,handles)
global spreadA1
global spreadA2
global spreadB1
global spreadB2
global axes2_ymin
global axes2_ymax
global axes2_xmax
global axes2_xmin
global averaged
axes(handles.axes2)
axis manual
pushbutton2_Callback(hObject, eventdata, handles);
set(gca,'XTickLabel',{' '})
set(gca,'YTickLabel',{' '})
hold on
SpreadA1=get(handles.SpreadA1,'Value');
SpreadA2=get(handles.SpreadA2,'Value');
SpreadB1=get(handles.SpreadB1,'Value');
SpreadB2=get(handles.SpreadB2,'Value');
plot([axes2_xmax*SpreadA1 axes2_xmax*SpreadA1],[axes2_ymin axes2_ymax],'-r','linewidth',2)
plot([axes2_xmax*SpreadA2 axes2_xmax*SpreadA2],[axes2_ymin axes2_ymax],'-b','linewidth',2)
plot([axes2_xmax*SpreadB1 axes2_xmax*SpreadB1],[axes2_ymin axes2_ymax],'-y','linewidth',2)
plot([axes2_xmax*SpreadB2 axes2_xmax*SpreadB2],[axes2_ymin axes2_ymax],'-g','linewidth',2)
set(gca,'XTickLabel',{' '})
set(gca,'YTickLabel',{' '})


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  END SPREAD LIMIT SLIDERS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in plot_fit.
function plot_fit_Callback(hObject, eventdata, handles)
% hObject    handle to plot_fit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global averaged
global wakewidth
axes(handles.axes2)
[fitted] = make_fit(hObject,handles,averaged);
axes(handles.axes3)
[U1 ymax rescaled] = profile_nondim(hObject,handles,fitted);
axes(handles.axes4)
[wakewidth norml] = get_wakewidth(hObject,handles,{U1 ymax rescaled});
global norml_save
norml_save=norml;

wakewidth_round=round(wakewidth*100)/100;
U1_round=abs(round(U1*1000)/1000);
set(handles.wakewidth_text,'String',wakewidth_round)
set(handles.U1_text,'String',U1_round)
%hold on
%plot([-wakewidth/2 -wakewidth/2],[0 1],'--k',[wakewidth/2 wakewidth/2],[0 1],'--k')  %plot wakewidth limits on axes4
%hold off

% --- Executes on button press in check_params.
function check_params_Callback(hObject, eventdata, handles)
% hObject    handle to check_params (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dir
global file
global filename
global t_now
global d
global U
global NBV
global Fr
global Re
global Nt_now

[t_now d U NBV Fr Re Nt_now] = what_params(hObject,handles);
set(handles.Nt_text,'String',round(Nt_now))
set(handles.t_text,'String',round(t_now))
set(handles.d_text,'String',d)
set(handles.U_text,'String',U)
set(handles.N_text,'String',NBV)


%axes(handles.axes5)
%current_Nt_handle = plot([Nt_now Nt_now],get(handles.axes5,'ylim'),'-.k')
%delete(current_Nt_handle)

% --- Executes on button press in get_mean_om.
function get_mean_om_Callback(hObject, eventdata, handles)
% hObject    handle to get_mean_om (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename
global wakewidth
axes(handles.axes1)
hold on
[om_mean] = om_mask_mean(hObject, handles,{get(handles.popupmenu1,'Value') get(handles.slider4,'Value') get(handles.slider5,'Value') get(handles.slider6,'Value') get(handles.slider7,'Value') get(handles.slider1,'Value') get(handles.slider2,'Value') filename});
set(handles.Om_text,'String',om_mean)
hold off


% --- Executes on button press in save_to_file.
function save_to_file_Callback(hObject, previous_NttomU, handles)
% hObject    handle to save_to_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename
global U1
global om_mean
global Nt_now
global t_now
global norml_save
global wakewidth
%Assure current parameters
check_params_Callback(hObject, 'eventdata', handles)

%save to
saveN=get(handles.save_name,'String');
saveext1=get(handles.save_ext1,'String');
saveext2=get(handles.save_ext2,'String');
savename1=strcat(saveN,saveext1);
savename2=strcat(saveN,saveext2);

%SET UP ARRAYS TO SAVE
saver2(1,1)=Nt_now;
saver2(1,2)=0;
saver=cat(1,saver2,norml_save);    %this is the new 2 row array to save

NttomU(1,1)=Nt_now;
NttomU(1,2)=t_now;
NttomU(1,3)=om_mean*10^6;  %for saving issues with dlmwrite precision %%%%%%%%%%careful
NttomU(1,4)=wakewidth;
NttomU(1,5)=abs(U1);


%Open file or create and write data
fid=fopen(savename1);
if fid==-1
    %no file of this name, create one and write to
    dlmwrite(savename1, saver, 'delimiter', '\t', 'precision','%.6f');
    dlmwrite(savename2, NttomU, 'delimiter', '\t', 'precision','%.6f');
    new_NttomU = [0 0 0 0 0];
else
    status = fclose(fid);
    previous_data = dlmread(savename1,'\t');    %this is all the data in the file
    previous_NttomU = dlmread(savename2,'\t');
    
    %make both previous data or saver the same length
    %pad with zeros since LimA & LimB change all the time
    [L1 W1]=size(previous_data);
    [L2 W2]=size(saver);
    if L1<L2
        previous_data(L1+1:L2,:)=0;
    elseif L2<L1
        saver(L2+1:L1,:)=0;
    end
     
    %Look for previous existence of the same point
    prev=previous_data(1,:)
    Nt_now_saved=round(Nt_now*10)/10;
    Nt_now_saved2=round(Nt_now*100)/100;
    k = find(prev == Nt_now_saved | prev == Nt_now | prev == Nt_now_saved2);
    %same for NttomU array
    pre=previous_NttomU(:,1);
    g = find(pre == Nt_now_saved | pre == Nt_now | pre == Nt_now_saved2);
    
%   Nt_now_saved
    
    %save normalized U profiles
    if size(k,2)==0
        new_data=cat(2,previous_data,saver);
        dlmwrite(savename1,new_data,'\t');
    else
        C=k(1);
        previous_data(:,C:C+1)=saver;
        dlmwrite(savename1, previous_data,'\t');
    end
    
    if size(g,1)==0
        new_NttomU=cat(1,previous_NttomU,NttomU);
        dlmwrite(savename2,new_NttomU,'\t');
    else
        R=g(1);
        new_NttomU=previous_NttomU;
        new_NttomU(R,:)=NttomU;
        dlmwrite(savename2, new_NttomU,'\t');
    end
end

%plot previous points on axes 5 & 6
axes(handles.axes5)
cla
plot(new_NttomU(:,1),new_NttomU(:,3),'ob','Markersize',3)
xlabel('Nt','FontSize',7)
ylabel('<om^2>_i','FontSize',7)

axes(handles.axes6)
cla
[AX,H1,H2]=plotyy(new_NttomU(:,1),new_NttomU(:,4),new_NttomU(:,1),abs(new_NttomU(:,5)),'plot');
xlabel('Nt','FontSize',7)
%set(get(AX(1),'Xlabel'),'String','Nt')
%set(get(AX(2),'Xlabel'),'String','Nt')
set(get(AX(1),'Ylabel'),'String','L_1')
set(get(AX(2),'Ylabel'),'String','|U_1|')
%set(get(AX(1),'Xlabel'),'Ycolor','g')
%set(get(AX(2),'Xlabel'),'Ycoloc','b')
set(AX(1),'yColor','r')
set(AX(2),'yColor','b')
set(AX(2),'FontSize',7)

set(get(AX(1),'Ylabel'),'FontSize',7)
set(get(AX(2),'Ylabel'),'FontSize',7)
%ylabel('L_1','FontSize',7)
%set(gca,'XAxisLocation','Bottom')
%set(gca,'YAxisLocation','Right')
set(H1,'Marker','s','Markersize',3,'Color','r','Linestyle','none')
set(H2,'Marker','o','Markersize',3,'Color','b','Linestyle','none')


%plot(norml(:,1),norml(:,2),'Color','r','Linestyle','--','Marker','+','Markersize',3)
%plot([widthlimA widthlimA],[-0.1 1.1],'-.k',[widthlimB widthlimB],[-0.1 1.1],'-.k')

%set(gca,'XTickLabel',{' '})
%set(gca,'YTickLabel',{' '})
%,'Rotation',90)
%xlim([-1.5 1.5])
%ylim([-0.1 1.1])


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% CLEAR AXES %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in clear_axes1.
function clear_axes1_Callback(hObject, eventdata, handles)
% hObject    handle to clear_axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla

% --- Executes on button press in clear_axes2.
function clear_axes2_Callback(hObject, eventdata, handles)
% hObject    handle to clear_axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes2)
cla
% --- Executes on button press in clear_axes3.
function clear_axes3_Callback(hObject, eventdata, handles)
% hObject    handle to clear_axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of clear_axes3
axes(handles.axes3)
cla


% --- Executes on button press in clear_axes4.
function clear_axes4_Callback(hObject, eventdata, handles)
% hObject    handle to clear_axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of clear_axes4
axes(handles.axes4)
cla

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% END CLEAR AXES %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%   EDIT TEXT BOXES    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function dirname_Callback(hObject, eventdata, handles)
% hObject    handle to dirname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dirname as text
%        str2double(get(hObject,'String')) returns contents of dirname as a double
global dir
dir=get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function dirname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dirname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
global dir
dir='c:\data\Spring06';
set(hObject,'String',dir)       %\\\  SET DEFAULT DIRECTORY HERE

function poly_order_Callback(hObject, eventdata, handles)
% hObject    handle to poly_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poly_order as text
%        str2double(get(hObject,'String')) returns contents of poly_order as a double
%global filename
%set(hObject,'String',filename);

% --- Executes during object creation, after setting all properties.
function poly_order_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poly_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
global file
file=get(hObject,'String');

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','ac001')  ;                  %\\\  SET DEFAULT FILEN HERE



function Nt_text_Callback(hObject, eventdata, handles)
% hObject    handle to Nt_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Nt_text as text
%        str2double(get(hObject,'String')) returns contents of Nt_text as a double


% --- Executes during object creation, after setting all properties.
function Nt_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Nt_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function wakewidth_text_Callback(hObject, eventdata, handles)
% hObject    handle to wakewidth_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wakewidth_text as text
%        str2double(get(hObject,'String')) returns contents of wakewidth_text as a double


% --- Executes during object creation, after setting all properties.
function wakewidth_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wakewidth_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function U1_text_Callback(hObject, eventdata, handles)
% hObject    handle to U1_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of U1_text as text
%        str2double(get(hObject,'String')) returns contents of U1_text as a double


% --- Executes during object creation, after setting all properties.
function U1_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to U1_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function save_name_Callback(hObject, eventdata, handles)
% hObject    handle to save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of save_name as text
%        str2double(get(hObject,'String')) returns contents of save_name as a double


% --- Executes during object creation, after setting all properties.
function save_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function save_ext2_Callback(hObject, eventdata, handles)
% hObject    handle to save_ext2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of save_ext2 as text
%        str2double(get(hObject,'String')) returns contents of save_ext2 as a double


% --- Executes during object creation, after setting all properties.
function save_ext2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_ext2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','.om.txt')
set(hObject,'FontSize',7)

function save_ext1_Callback(hObject, eventdata, handles)
% hObject    handle to save_ext1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of save_ext1 as text
%        str2double(get(hObject,'String')) returns contents of save_ext1 as a double


% --- Executes during object creation, after setting all properties.
function save_ext1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to save_ext1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'String','.uprof.txt')
set(hObject,'FontSize',7)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%    END EDIT TEXT BOXES      %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%












function om_mask_select1(hObject,reserved,inputs)
%%%%%%%%%%%% SJCG  %%%%%%%%%%%%%
%[a b] range -0.5 to 1.5 both 
%limA & limB both go between 0 and 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%THIS JUST PLOTS LIMITS AND FUNK ONTO SELECTED AXES


%%%%%%%%%%%%%%%%%%%%INPUTS%%%%%%%%%%%%%%%%%%%%%%%%%
    funk_id=inputs{1};
    a=inputs{2};
    b=inputs{3};
    c=inputs{4};  %
    d=inputs{5};   %not used when using funk1
    limA=inputs{6};
    limB=inputs{7};
    ename=inputs{8};
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global ro
global co

    %read in .d file
    
    nu=.01004;
    [x,y,u,v,du_dx,du_dy,dv_dx,dv_dy,m,n,dx,dy,u2,om,div,eps,Q]=rd_d(ename,nu);

    %make straight line with slope a and offset b
    [ro co]=size(om);
    x_scale=[1:1:co];
    funk1=round((a*(ro/co))*(x_scale)+(b*ro));
    funk2=round((a*ro)*sin((x_scale-d)/c)+(b*ro));
    %make vertical line limits
    lim_line=[1 ro];
    lim_A=[round(limA*co) round(limA*co)];
    lim_B=[round(limB*co) round(limB*co)];
    
    
    if funk_id==1
        active_funk=funk1;
    else if funk_id==2
        active_funk=funk2;     
        else
        test='undefined function'       
        end
    end
    
    %plot limits
    %figure(1)
    %contourf(om);
    %pcolor(om)
    %shading interp

    cla
    hold on
    axis([0 co 0 ro])
    plot(x_scale,active_funk,'-k','LineWidth',3)
    plot(lim_A,lim_line,'-b','LineWidth',3)
    plot(lim_B,lim_line,'-g','LineWidth',3)
    set(gca,'visible','off')
    
    %center has x and value of funk chosen at given x
    center(:,1)=x_scale';
    center(:,2)=active_funk';


    
    
    
    
function [averaged] = om_mask_select2(hObject, reserved,inputs) 
    %THIS PLOTS THE AVERAGED PROFILES FROM THE GIVEN FUNK AND LIMITS
    
    %%%%%%%%%%%%%%%%%%%%INPUTS%%%%%%%%%%%%%%%%%%%%%%%%%
    funk_id=inputs{1};
    a=inputs{2};
    b=inputs{3};
    c=inputs{4};  %
    d=inputs{5};   %not used when using funk1
    limA=inputs{6};
    limB=inputs{7};
    ename=inputs{8};
    
    global ro
    global co
    global dy
    global ysize_real
    %read in .d file
    nu=.01004;
    [x,y,u,v,du_dx,du_dy,dv_dx,dv_dy,m,n,dx,dy,u2,om,div,eps,Q]=rd_d(ename,nu);
    
    
    %Arrange so scale is correct even when using funk
    actual_y=size(y(:,1),1);
    ysize_real=y(actual_y,1)-y(1,1);
    
    %Plot velocity field without using FUNK to correct
    %Just a check to make sure setting limits is worthwhile
    % Unless wake is straight, difference should be noticeable!  
    hold off
    %y(:,1);
    plot(y(:,1),mean(u,2),'Color','b','Linestyle','--')    
    set(gca,'XTickLabel',{' '})
    set(gca,'YTickLabel',{' '})
    hold on
    
    %make straight line with slope a and offset b
    [ro co]=size(om);

    
    x_scale=[0:1:(co-1)];
    funk1=round((a*(ro/co))*(x_scale)+(b*ro));
    funk2=round((a*ro)*sin((x_scale-d)/c)+(b*ro));
    %make vertical line limits
    lim_line=[0 ro];
    lim_A=[round(limA*co) round(limA*co)];
    lim_B=[round(limB*co) round(limB*co)];
    
    
    if funk_id==1
        active_funk=funk1;
    else if funk_id==2
        active_funk=funk2;     
        else
        test='undefined function'       
        end
    end
    
    
    %center has x and value of funk chosen at given x
    center(:,1)=x_scale';
    center(:,2)=active_funk';
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %extract from each line of om one at a time, and average all
    %this averaging procedure follows funk_active and averages along that
    %
    counter2=0;
    for offset=-ro:ro
    counter=0;
    sum=0;
    offset;
        for jj=lim_A(1):lim_B(1)    
            %start=center(i,2)
            %end=ro
            height=center(jj,2)+offset;
            if (height >= 1) & (height <= ro)
            sum=sum+u(height,jj)  ;
            counter=counter+1;
            end
        end
    numberofpoints=counter;
    if numberofpoints>0
        counter2=counter2+1;
        ave(counter2)=sum/numberofpoints;  %this is the average along funk
        
    end
    end

    new_y=size(ave,2);
    
    averaged(:,1)=(1:new_y)./((new_y-1)/ysize_real);   % this is a vector the size of ave with correct scale
    averaged(:,2)=ave;
   
    %figure(3)
    plot(averaged(:,1),averaged(:,2),'Color','b','Linestyle','-','Marker','o','Markersize',3)    
    %set(gca,'XTickLabel',{' '})
    %set(gca,'YTickLabel',{' '})
    
    
    
    
function plot_om_field(hObject,reserved,ename)%%%%%%%%%%%%%%%%%%%%%%%%%%%
%THIS JUST PLOTS THE VORTICITY FIELD

    %read in .d file
    global co
    global ro
    
    nu=.01004;
    [x,y,u,v,du_dx,du_dy,dv_dx,dv_dy,m,n,dx,dy,u2,om,div,eps,Q]=rd_d(ename,nu);    
    [ro co]=size(om);
    axis([0 co 0 ro])
    pcolor(om)
    set(gca,'XTickLabel',{' '})
    set(gca,'YTickLabel',{' '})

    
    
    

function [filename] = make_dirname(hObject,res,inputs)%%%%%%%%%%%%%%%%%%%%%
%This figures out the name of the .d file 
%c:\data\Spring06\ac\ac055.d
%inputs={directory filename}
%directory='c:\data\Spring06'
%file='ac055'
global dir
global file
global filename
file=inputs{2};
dir=inputs{1};
filename=strcat(inputs{1},'\',file(1:2),'\',inputs{2},'.d');

    
function [file] = what_next(hObject,handles,increment)
%This figures out the name of the next .d file (out_name) from in_name
%and RESETS FILE AS THE NEW FILE GLOBALLY
%global dir
global file
number=str2num(file(3:5));
newnumber=number+increment;

if newnumber>0 & newnumber<10
    file=strcat(file(1:2),'0','0',int2str(newnumber));
elseif newnumber>9 & newnumber<100
    file=strcat(file(1:2),'0',int2str(newnumber));
else
    file=strcat(file(1:2),int2str(newnumber));
end





function [U1 ymax rescaled] = profile_nondim(hObject,handles,fitted)
%%%%%%%%%%%% SJCG 10/19/04 %%%%%%%%%%%%%
%very badly named, does not non dim anything
%just removes fitted function on axes2 and plots chopped version on axes3
%profile plotted is in cm/s vs cm
global SpreadA1
global SpreadB2
global fact
global pixdy
global dy
global ro
global U1
SpreadA1=get(handles.SpreadA1,'Value');
SpreadB2=get(handles.SpreadB2,'Value');
fact=6; %make sure fact is the same as in make_fit

%take average profile and substract polynomial fit
%chopping off at SpreadA1 and SpreadB2 limits
scale=size(fitted,1)-fact;
prof1=fitted(round(scale*SpreadA1):round(scale*SpreadB2),2)-fitted(round(scale*SpreadA1):round(scale*SpreadB2),3);
yscale=fitted(round(scale*SpreadA1):round(scale*SpreadB2),1);

%find |Umax| and y location of |umax|   
[U1 ymax]=min(prof1);        


%recenter profiles about 0 in y.
yscale=(yscale-yscale(ymax));  % <----------------recenter 2 
%ubar_rc(:,1)=(y(:,1)-recenter);


%just sanitiy check
size_chopped=round(size(yscale,1)/fact);
image_width=ro*dy     ;                         % in cm
width_chopped=size_chopped*dy;
width_check=yscale(size(yscale,1))-yscale(1);   %should be the same as width_chopped, width of chopped prof in cm

rescaled(:,1)=yscale;
rescaled(:,2)=prof1;

%figure(1)
hold on
box on
plot(rescaled(:,1),rescaled(:,2),'Color','k','Linestyle','-.','Marker','+','Markersize',3)  %in cm
xlim([yscale(1) yscale(size(yscale,1))])
ylim([min(prof1)+0.1*min(prof1) -0.2*min(prof1)])
set(gca,'XTickLabel',{' '})
set(gca,'YTickLabel',{' '})
plot([yscale(1) yscale(size(yscale,1))],[0 0],'-k',[0 0],[-0.2*min(prof1) min(prof1)+0.1*min(prof1)],'-k')
hold off






function [wakewidth norml] = get_wakewidth(hObject,handles,inputs)
%%%% from a rescaled profile, this
%  outputs wakewidth and plots a non-dimensional profile
global fact
global dy
global pixdy

%Get wakewidth
U1=inputs{1};
ymax=inputs{2};
rescaled=inputs{3};


%----Define inner wake-----------%
Ucut=0.2*U1;
seeker1=ymax;
goal1=U1;
    while  goal1<Ucut                 % |
        goal1=rescaled(seeker1,2);     % |
        seeker1=seeker1+1;            % |
    end                               % |   Seek y coord of limit values within inner wake
seeker2=ymax;                         % |
goal2=U1;                             % |
    while  goal2<Ucut                 % |
        goal2=rescaled(seeker2,2);     % |
        seeker2=seeker2-1;           % |
    end                               % |
%-------------------------------- % 

wakewidth =(rescaled(seeker1-1,1)-rescaled(seeker2+1,1));       %width of inner wake defined by Ucut !should be positive!
%this should be in cm
widthlimA=rescaled(seeker1-1,1)/wakewidth;  %SHOULD BE NON-DIM
widthlimB=rescaled(seeker2+1,1)/wakewidth;
%these are the wake width limits, should intersect with the 0.2*U1 line


%find the closest points in orginal grid to the interpolated width-----
%frak1=(seeker1-1)/fact;
%frak2=(seeker2-1)/fact;
%seeker3=round(frak1)
%seeker4=round(frak2)
%wakewidth2=(rescaled(seeker3-1,1)-rescaled(seeker4+1,1))/dx;  use a non interp velocity field


%save normalized velocity profiles
norml(:,1)=(rescaled(:,1))/wakewidth;  % normalized y array %now non-dimensional
norml(:,2)=rescaled(:,2)/U1; %normalized U array


%figure(2)
hold on
plot(norml(:,1),norml(:,2),'Color','r','Linestyle','--','Marker','+','Markersize',3)
plot([widthlimA widthlimA],[-0.1 1.1],'-.k',[widthlimB widthlimB],[-0.1 1.1],'-.k')
set(gca,'XAxisLocation','Top')
set(gca,'YAxisLocation','Right')
%set(gca,'XTickLabel',{' '})
%set(gca,'YTickLabel',{' '})
xlabel('y/L_1','FontSize',7)
ylabel('<u>/U_1','FontSize',7)%,'Rotation',90)
xlim([-1.5 1.5])
ylim([-0.1 1.1])
plot([-1.5 1.5],[0 0],'-k',[0 0],[-0.1 1.1],'-k')
grid on
hold off




function [fitted] = make_fit(hObject,handles,averaged)
%%%%%%%%%%%% SJCG 01/02/06 %%%%%%%%%%%%%
%makes an interpolated polynomial fit and plots it

%averaged
%size(averaged)
global SpreadA1
global SpreadA2
global SpreadB1
global SpreadB2
global axes2_xmax

SpreadA1=get(handles.SpreadA1,'Value');
SpreadA2=get(handles.SpreadA2,'Value');
SpreadB1=get(handles.SpreadB1,'Value');
SpreadB2=get(handles.SpreadB2,'Value');
%axes2_xmax=max(averaged(:,1));
u=averaged(:,2);
y=averaged(:,1);
fact=6;

%array sizes
[iny inx]=size(u);

%---------interpolate----------------------------------------------------%
%interp factor is called fact
u2 = interp(u,fact); % U
u = interp(u,fact); % U
[iny2 sss]=size(y);
y = interp(y,fact); % y
%------------------------------------------------------------------------%

%Fit with Polynomial
last_in_y=size(y,1)-fact;  %this is the total range with which to rescale

yrange=[y(round(last_in_y*SpreadA1):round(last_in_y*SpreadA2));y(round(last_in_y*SpreadB1):round(last_in_y*SpreadB2))]';
urange=[u(round(last_in_y*SpreadA1):round(last_in_y*SpreadA2));u(round(last_in_y*SpreadB1):round(last_in_y*SpreadB2))]';
%%%%%%%%%%%%%%%%%%%%

order=get(handles.poly_order,'String');
p = polyfit(yrange,urange,str2num(order));
back=polyval(p,y);             %%%% THIS IS THE FIT

fitted(:,1)=y;
fitted(:,2)=u2;
fitted(:,3)=back;
%axis manual
plot(fitted(:,1),fitted(:,3),'-.k','Linewidth',1)
set(gca,'XTickLabel',{' '})
set(gca,'YTickLabel',{' '})


function [t_now d U NBV Fr Re Nt_now] = what_params(hObject,handles)
%Gets the current parameters for the file and makes them global
global dir
global file
global filename
global t_now
global d
global U
global NBV
global Fr
global Re
global Nt_now

    %Read .t file
    lame=strcat(dir,'\',file(1:2),'\',file(1:2));
    [t,delta_t]=rd_t(strcat(lame,'.t'));

    %read .info file
    [d,U,NBV,Fr,Re]=rd_info(strcat(lame,'.info'));


number=str2num(file(3:5));
t_now=t(number);
Nt_now=t_now*NBV;





function [om_mean] = om_mask_mean(hObject, reserved,inputs) 
    %THIS averages the OM field inside the inner wake
    % defined by -wakewidht/2 to wakewidth/2
    
    %%%%%%%%%%%%%%%%%%%%INPUTS%%%%%%%%%%%%%%%%%%%%%%%%%
    funk_id=inputs{1};
    a=inputs{2};
    b=inputs{3};
    c=inputs{4};  %
    d=inputs{5};   %not used when using funk1
    limA=inputs{6};
    limB=inputs{7};
    ename=inputs{8};
    
    global ro
    global co
    global dy
    global ysize_real
    global wakewidth
    global om_mean
    %read in .d file
    nu=.01004;
    [x,y,u,v,du_dx,du_dy,dv_dx,dv_dy,m,n,dx,dy,u2,om,div,eps,Q]=rd_d(ename,nu);
    
    
    %Arrange so scale is correct even when using funk
    actual_y=size(y(:,1),1);
    ysize_real=y(actual_y,1)-y(1,1);
    
    [ro co]=size(om);
    
    %make funk
    x_scale=[1:1:(co)];
    funk1=round((a*(ro/co))*(x_scale)+(b*ro));
    funk2=round((a*ro)*sin((x_scale-d)/c)+(b*ro));
    
    %make vertical line limits
    lim_line=[0 ro];
    lim_A=[round(limA*co) round(limA*co)];
    lim_B=[round(limB*co) round(limB*co)];
    
    
    if funk_id==1
        active_funk=funk1;
    else if funk_id==2
        active_funk=funk2;     
        else
        test='undefined function'       
        end
    end
    
    %make center funk
    center(:,1)=x_scale';
    center(:,2)=active_funk';
    
    %make funk_high limit
    funk_high(:,1)=center(:,1);
    funk_high(:,2)=center(:,2)+round(wakewidth/dy/2);
    
    %make funk_low limit
    funk_low(:,1)=center(:,1);
    funk_low(:,2)=center(:,2)-round(wakewidth/dy/2);
    
    %plot inner wake limits on om field
    %figure(1)
    hold on
    pcolor(om)
    axis([0 co 0 ro])
    plot(funk_high(lim_A(1):lim_B(1),1),funk_high(lim_A(1):lim_B(1),2),'-w','LineWidth',2)
    plot(funk_low(lim_A(1):lim_B(1),1),funk_low(lim_A(1):lim_B(1),2),'-w','LineWidth',2)
    %plot(lim_A,lim_line,'-b','LineWidth',3)
    %plot(lim_B,lim_line,'-g','LineWidth',3)
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %extract from each line of om one at a time, and average all
    %this averaging procedure follows funk_active and averages along that
    %
    counter2=0;
    for offset=-ro:ro
    counter=0;
    sum=0;
    offset;
        for jj=lim_A(1):lim_B(1)    
            %start=center(i,2)
            %end=ro
            height=funk_low(jj,2)+offset;
            if (height >= funk_low(jj,2)) & (height <= funk_high(jj,2))
                sum=sum+(om(height,jj)).^2  ;
                counter=counter+1;
            end
        end
    numberofpoints=counter;
    if numberofpoints>0
        counter2=counter2+1;
        ave(counter2)=sum/numberofpoints;  %this is the average along funk
        
    end
    end

    new_y=size(ave,2);
    
    om_prof(:,1)=(1:new_y)./((new_y-1)/ysize_real);   % this is a vector the size of ave with correct scale
    om_prof(:,2)=ave;
   
    %figure(3)
    %plot(om_prof(:,1),om_prof(:,2),'Color','b','Linestyle','-','Marker','o','Markersize',3)    
    %set(gca,'XTickLabel',{' '})
    %set(gca,'YTickLabel',{' '})

    om_mean=mean(om_prof(:,2));














function [pixdx pixdy]=get_pixdxdy(filename)
% Remember that this &(**$^#^*()*!! pixdy is in cm/pixel, not the right way
% around !!!
%global filename
global pixdy
ss=size(filename,2);
fid=fopen(strcat(filename(1:ss-5),'.civ'));

[hello,goodbye]=fscanf(fid,'%f',8);
pixdx=hello(7);
pixdy=hello(8);

fclose(fid);











function d_text_Callback(hObject, eventdata, handles)
% hObject    handle to d_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d_text as text
%        str2double(get(hObject,'String')) returns contents of d_text as a double


% --- Executes during object creation, after setting all properties.
function d_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function U_text_Callback(hObject, eventdata, handles)
% hObject    handle to U_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of U_text as text
%        str2double(get(hObject,'String')) returns contents of U_text as a double


% --- Executes during object creation, after setting all properties.
function U_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to U_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function N_text_Callback(hObject, eventdata, handles)
% hObject    handle to N_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N_text as text
%        str2double(get(hObject,'String')) returns contents of N_text as a double


% --- Executes during object creation, after setting all properties.
function N_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





function t_text_Callback(hObject, eventdata, handles)
% hObject    handle to t_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t_text as text
%        str2double(get(hObject,'String')) returns contents of t_text as a double


% --- Executes during object creation, after setting all properties.
function t_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function Om_text_Callback(hObject, eventdata, handles)
% hObject    handle to Om_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Om_text as text
%        str2double(get(hObject,'String')) returns contents of Om_text as a double


% --- Executes during object creation, after setting all properties.
function Om_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Om_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end













% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)














