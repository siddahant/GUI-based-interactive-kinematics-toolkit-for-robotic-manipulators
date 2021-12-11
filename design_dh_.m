function varargout = design_dh_(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @design_dh__OpeningFcn, ...
                   'gui_OutputFcn',  @design_dh__OutputFcn, ...
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
%------------------------ DO NOT EDIT--------------------------------------


% --- Executes just before design_dh_ is made visible.
function design_dh__OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
%------------------------ Function end ------------------------------------


% --- Outputs from this function are returned to the command line.
function varargout = design_dh__OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;
%------------------------ Function end ------------------------------------

function n_Callback(hObject, eventdata, handles)
n=str2double(handles.n.String) % taking no of joint from user input 
handles.joints.String=num2str(1) % intilize intial joint number 
data=zeros(1,4) % set initial value to zero 
setappdata(0,'tableData',data) % define tabel 
%------------------------ Function end ------------------------------------

% --- Executes during object creation, after setting all properties.
function n_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%------------------------ Function end ------------------------------------

function THETA_Callback(hObject, eventdata, handles)
%------------------------ Function end ------------------------------------

% --- Executes during object creation, after setting all properties.
function THETA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%------------------------ Function end ------------------------------------

function D_Callback(hObject, eventdata, handles)
%------------------------ Function end ------------------------------------



% --- Executes during object creation, after setting all properties.
function D_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%------------------------ Function end ------------------------------------


function A_Callback(hObject, eventdata, handles)
%------------------------ Function end ------------------------------------


% --- Executes during object creation, after setting all properties.
function A_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%------------------------ Function end ------------------------------------

function ALPHA_Callback(hObject, eventdata, handles)
%------------------------ Function end ------------------------------------


% --- Executes during object creation, after setting all properties.
function ALPHA_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%------------------------ Function end ------------------------------------


% --- Executes on button press in update.
function update_Callback(hObject, eventdata, handles)
n=str2double(handles.n.String) %taking no of joint from user input 
joints=str2double(handles.joints.String) % get the joint variable for working
if joints>0 && joints<=n % contdition for joint should not exceed 
handles.out_e.String=""
handles.joints.String=num2str(joints+1) % update working joint
t=str2double(handles.THETA.String)*pi/180 % convert theta in  deg to radian
d=str2double(handles.D.String) % set distance in direction of z
a=str2double(handles.A.String) % set distence in direction of x 
alpha=str2double(handles.ALPHA.String)*pi/180 % convert alpha in deg to radian 
data = getappdata(0,'tableData') % get parameters from table 
data(joints,:)=[t d a alpha] % add parameters into table 
data(isnan(data))=0; % if NaN present set as 0
cla(handles.Built_axes) % clear all axis 
robot=SerialLink(data,'name',' ') % robot generation
robot.plot(zeros(1,(size((data),1))))  % plot robot 
% size the plot 
l=max(sum(data(:,[2,3])))*1.2
xlim([-l, l])
ylim([-l, l])
setappdata(0,'tableData',data) % fix table values 
else 
    handles.out_e.String="Exceed number of DOF"
end
%------------------------ Function end ------------------------------------


function joints_Callback(hObject, eventdata, handles)
%------------------------ Function end ------------------------------------


function joints_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%------------------------ Function end ------------------------------------

% --- Executes on button press in remove.
function remove_Callback(hObject, eventdata, handles)
n=str2double(handles.n.String) %taking no of joint from user input 
joints=str2double(handles.joints.String) % get working joint
if joints>0 && joints<=n % contdition for joint should not exceed 
handles.joints.String=num2str(joints-1) % update working joint
handles.out_e.String="" 
data = getappdata(0,'tableData') % get parameters from table 
data(joints,:)=[] % remove the joint number coloum  form the table 
cla(handles.Built_axes) % clear axes 
robot=SerialLink(data) % rebuilt robot with update table 
robot.plot(zeros(1,(size((data),1)))) % plot robot 
% resize plot 
l=max(sum(data(:,[2,3])))*1.2
xlim([-l, l])
ylim([-l, l])
setappdata(0,'tableData',data) % update table 
else 
      handles.out_e.String="Exceed number of DOF"
end
%------------------------ Function end ------------------------------------ 



function edit8_Callback(hObject, eventdata, handles)
%------------------------ Function end ------------------------------------

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%------------------------ Function end ------------------------------------


% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
close(design_dh_);
op
%------------------------ Function end ------------------------------------

% --- Executes on button press in Joint_update.
function Joint_update_Callback(hObject, eventdata, handles)
%------------------------ Function end ------------------------------------
