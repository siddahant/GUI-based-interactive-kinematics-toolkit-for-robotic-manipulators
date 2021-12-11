function varargout = op(varargin)
%% This code execuide Forward or Inverse kinamatics algorithm 
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @op_OpeningFcn, ...
                   'gui_OutputFcn',  @op_OutputFcn, ...
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


% --- Executes just before op is made visible.
function op_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = op_OutputFcn(hObject, eventdata, handles) 
%% DATA Transfer
varargout{1} = handles.output; 
a = getappdata(0,'tableData'); % get DH  parameters  from temp memory
set(handles.dh_f,'Data',[[1:size(a,1)]', a ]); % set DH parameters 
joint_variables=(1:size(a,1))'; % define veriable vector
% Initialization joint variable table Theta Table
set(handles.theta_table,'Data',[joint_variables(:,:), joint_variables(:,:)*0]);
fprintf("Data collected")


%% --- PerformForword Kinematics on button press in fwd_k.
function fwd_k_Callback(hObject, eventdata, handles)
%% Forword Kinematics Block 
cla(handles.axes2); % clear plot area 2 
axes(handles.axes2); % set plot area 2
thetas=get(handles.theta_table,'Data'); % get valuse from table
tvactor=thetas(:,2)*pi/180 % vector of joint variables
a = getappdata(0,'tableData'); % DH parametersfrom pervious Screen 
a(:,[1,4])=a(:,[1,4]); % remove first column of joints no. for calculations
rF=SerialLink(a,'name',' '); % Described serial-link arm-type robot.
start=zeros(size(a,1),1)'; % initial joint variables
rF.plot(start); % plot robot with initial joint variables
% resize plot axes
l=max(sum(a(:,[3,2])))*2;
xlim([-l, l]);
ylim([-l, l]);
% DH parameter algorithm
spacevactor=zeros(size(tvactor,1),max(round(thetas(:,2))));

for i=1:size(tvactor,1)
    spacevactor(i,:)=linspace(0,tvactor(i),max((round(thetas(:,2)))))
end
T = sym('theta', [1,size(a,1)]); % Joints Vector
for i=1:max(abs(round(thetas(:,2))))
    hold on
    points=DH(a); % DH Matrix calculation
    x_e(:,i)=double(subs(points(:,4),T,spacevactor(:,i)')); %Px Py PZ values 
    rF.plot(spacevactor(:,i)'); % plot robot 
    plot3(x_e(1,:),x_e(2,:),x_e(3,:),'r','LineWidth',2) % plot points 
    %pause(0.01);
    fprintf("Calculating the Forward Kinematics...\n")
end
fprintf("\nForward Kinematics Calculated.\n")
hold off

handles.x.String=num2str(x_e(1,end)) % display x positon.
handles.y.String=num2str(x_e(2,end)) % display y positon.
handles.z.String=num2str(x_e(3,end)) % display z positon.
%% Plots 
axes(handles.axes5);
t=1:max(abs(round(thetas(:,2))))
plot(t,x_e(1,:))
xlabel('Time in sec.');
ylabel('Px');
title('Position of x');
axes(handles.axes6);
plot(t,x_e(2,:))
xlabel('Time in sec.');
ylabel('Py');
title('Position of y');
axes(handles.axes4);
plot(t,x_e(3,:))
xlabel('Time in sec.');
ylabel('Pz');
title('Position of z');

% --- Executes on button press in inv_k.
function inv_k_Callback(hObject, eventdata, handles)
%% Inverse Kinematics Block 
handles.cov.String = ""
cla(handles.axes2) % clear plot area
axes(handles.axes2);
a = getappdata(0,'tableData') % DH parametersfrom pervious Screen 
a(:,[1,4])=a(:,[1,4]) % remove first column of joints no. for calculations
rF=SerialLink(a,'name',' '); % Described serial-link arm-type robot.
start=zeros(size(a,1),1)' % initial joint variables
rF.plot(start); % plot robot with initial joint variables
% resize plot axes
l=max(sum(a(:,[3,2])))*2
xlim([-l, l])
ylim([-l, l])
% user inputs
X=str2double(handles.x.String)
Y=str2double(handles.y.String)
Z=str2double(handles.z.String)
%% Initialization of DH 
syms t 
dh=DH(a)
% End effactor matrix
xe=simplify(dh(1:3,4)); % [PX PY PZ]
n=size(a,1)
T = sym('theta', [n,1]); % joint vactor
analytica_jacobian=jacobian(xe,T) % analytical jacobian
analytica_jacobian(:, all(analytica_jacobian==0))=[] % remove all zero coloum
%% Initial conditions
delta_t = 0.01; % time Step
te = 5; % End Time
time=0:delta_t:te;
start_position = double(subs(xe,T,zeros(n,1))) % default when all thetas at 0
x=POLY(start_position(1),X,te); % 5th oder trajectory equation for x postions 
y=POLY(start_position(2),Y,te); % 5th oder trajectory equation for y postions 
z=POLY(start_position(3),Z,te); % 5th oder trajectory equation for z postions 
p_d = [x;y;z]; % Desired positon vector
p_ddot = diff(p_d); % Differentiation  of desired positon
p_d=double(subs(p_d,t,time)) % substitute time
p_ddot = double(subs(p_ddot,t,time)) % substitute time
q(:,1) = a(:,1); % initial angle values
% clear plot areas
cla(handles.axes4)
cla(handles.axes5)
cla(handles.axes6)
axes(handles.axes2)
%% inverse kinamatics algorithm
K=str2double(handles.k.String)*eye(3) %  positive definite (usually diagonal)  Gain matrix
for i = 1:length(time)    
 x_e(:,i)= double(subs(xe,T,q(:,i))); % getting 4th coloum of dH parameter
 J_A = double(subs(analytica_jacobian,T,q(:,i))); % calculate analytical jacobian 
 desired_position = p_d(:,i); % desired postion 
 e(:,i) = desired_position - x_e(:,i);  % operational space error
 x_ddot=p_ddot(:,i);  
 q_dot = pinv(J_A)*(x_ddot+K*e(:,i)) % Jacobian (Pseudo-)inverse
 if size(q_dot,1)==size(q,1) % condition for matrix sixe equal 
  q(:,i+1)=q(:,i)+delta_t*q_dot; 
 else
 q(:,i+1)=q(:,i)+delta_t*[q_dot;zeros((size(q,1)- size(q_dot,1)),1)];
 end
% plot robot
rF.plot(q(:,i)') ; 
l=max(sum(a(:,[2,3])))*2;
xlim([-l, l]);
ylim([-l, l]);
hold on
plot3(x_e(1,:),x_e(2,:),x_e(3,:),'r','LineWidth',2);
hold off
set(handles.theta_table,'data',[[1:size(q,1)]', wrapTo180(rad2deg(q(:,i)))]);
fprintf("Calculating the Inverse Kinematics...\n");
end
fprintf("end of theInverse Kinematics claclualtion.\n")
change = 100*(x_e(:,end)-p_d(:,end))./p_d(:,end)
change(isnan(change))=0
handles.cov.String = "point reached"
if max(abs(change)) > 30
     handles.cov.String="Not able to coverage after certain iteration"
end
%% PLOT
axes(handles.axes4);
plot(time,p_d(1,:),'--');
hold on 
plot(time,x_e(1,:))
hold off
legend('Desired','Actual');
xlabel('Time in sec.');
ylabel('Px');
title('Position of x');

axes(handles.axes6);
plot(time,p_d(2,:),'--');
hold on
plot(time,x_e(2,:))
hold off
legend('Desired','Actual')
ylabel('Py');
xlabel('Time in sec.'); 
title('Position y');

axes(handles.axes5);
plot(time,p_d(3,:),'--');
hold on
plot(time,x_e(3,:))
hold off
legend('Desired','Actual')
ylabel('Pz');
xlabel('Time in sec.'); 
title('Position z');


%% ------------------------ Do not edit ------------------------------------
function x_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function x_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function y_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function y_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function z_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function z_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in mm.
function mm_Callback(hObject, eventdata, handles)

close(op);
main_file



function k_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function k_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
