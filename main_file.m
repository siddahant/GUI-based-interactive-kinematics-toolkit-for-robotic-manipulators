
function varargout = main_file(varargin)
%% This is the main file of project that combine all sub-files
% <<<<<<<<<<<<<<<<<< Only run this file >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_file_OpeningFcn, ...
                   'gui_OutputFcn',  @main_file_OutputFcn, ...
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


% --- Executes just before main_file is made visible.
function main_file_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
%------------------------ Function end ------------------------------------

function varargout = main_file_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

% DOF calling function
function dof_Callback(hObject, eventdata, handles)
%------------------------ Function end ------------------------------------

% - DoF block Executes during object creation, after setting all properties.
function dof_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%------------------------ Function end ------------------------------------

% --- Executes when entered data in editable cell(s) in uitable3.
function uitable3_CellEditCallback(hObject, eventdata, handles)
%------------------------ Function end ------------------------------------



% --- Executes when entered data in editable cell(s) in DH_Table.
function DH_Table_CellEditCallback(hObject, eventdata, handles)
%------------------------ Function end ------------------------------------


% --- Executes on button press in dof_b.
function dof_b_Callback(hObject, eventdata, handles)

Dof =str2double(handles.dof.String); % change string to double 
v = (1:Dof)'; % vector nx1 where n is DOF 
% initialization DH table with all zero values
set(handles.DH_Table,'Data',[v(:,:), v(:,:)*0, v(:,:)*0,v(:,:)*0,v(:,:)*0]);
%------------------------ Function end ------------------------------------


% --- Executes when entered data in editable cell(s) in uitable5.
function uitable5_CellEditCallback(hObject, eventdata, handles)
%------------------------ Function end ------------------------------------

% --- Executes on button press in b1.
function b1_Callback(hObject, eventdata, handles)
%% set parameters 
tableData=get(handles.DH_Table,'Data') % get data from DH table
a=tableData(:,[2:5]) % remove first coloum 
a(:,[1,4])=a(:,[1,4])*pi/180 % change angle value deg to red
robot=SerialLink(a,'name',' ') % Creat Serial Robot 
start=zeros(size(tableData,1),1)' % default initial angle values 0
%% plot 
cla(handles.axes1) % clear plot area
robot.plot(start) % plot robot at axes1 (plot area)
setappdata(0,'tableData',a) % store DH value in temp memory
% resize plot area
l=max(sum(a(:,[2,3])))*2 
xlim([-l, l])
ylim([-l, l])
%------------------------ Function end ------------------------------------

% --- chenge screen on button press in op.
function op_Callback(hObject, eventdata, handles)
close(main_file); % close main_file screen 
op % open operation screen 
%------------------------ Function end ------------------------------------


% --- chenge on button press in Ndh.
function Ndh_Callback(hObject, eventdata, handles)
close(main_file); % close main_file screen 
design_dh_  %open design  screen
%------------------------ Function end ------------------------------------

%---------------------------end code --------------------------------------