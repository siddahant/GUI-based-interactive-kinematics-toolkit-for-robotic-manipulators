function dh = DH(DH_Parameter_Matrix)
%% This function helps to calculate DH paramter matrix 
% input  --> DH table 
% outpot --> T0_e
% DH parameter symbolic matrix

%% initilization of parameters 
syms  theta d a alpha1
A = [cos(theta),-cos(alpha1)*sin(theta),sin(theta)*sin(alpha1),a*cos(theta);
     sin(theta),cos(theta)*cos(alpha1),-cos(theta)*sin(alpha1),a*sin(theta);
     0         , sin(alpha1)          , cos(alpha1)           ,d           ;
     0         , 0                   , 0                    ,1           ];
n=size(DH_Parameter_Matrix,1); % no of time loop run 
d0=DH_Parameter_Matrix; % DH parameters 
T = sym('theta', [n,1]); % make theta variable     
dh=eye(4); % 4x4 identity matrix for x0,y0,z0 coordinate 

%% loop for calculate T0_e
for i=1:n
  dh_next= subs(A,{theta d a alpha1},{T(i),d0(i,2),d0(i,3),d0(i,4)}); %dh for current frame 
  dh=dh*dh_next;% post multiplication 
  fprintf("Calculating the DH parameters...\n")
end
end
%----------------------------end code--------------------------------------
