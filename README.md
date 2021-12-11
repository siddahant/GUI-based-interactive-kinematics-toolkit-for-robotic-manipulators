# GUI-based-interactive-kinematics-toolkit-for-robotic-manipulators
# introduction 
The main aim of this project is to create an interactive GUI which can be used create a 3D manipulator MATLAB. Operating this GUI does not require advance knowledge of mechanics or robotics.
For instance the user will be given a choice to enter DH parameters directly ,if known, in the table or by randomizing parameters and witnessing a small 3D manipulator made by those parameters.
The main objective of this project is simplify the process of solving various equations and mathematical models by using a user friendly GUI which performs all these calculations on the backend and depicts a manipulator based on those parameters in use. 
#  Working schematic
![image](https://user-images.githubusercontent.com/44742647/145686959-534d74e8-6c3e-48e6-bf78-d15802abb4ec.png)

# Contributor 
Nikita Tushar Joshi

# how to run 
Requirements: computer or laptop and MATLAB 2019 and up 
First, please make sure the path set to the MAE547 NJ SJ Project 2 folder location and the folder contains a total of 9 files 
1.	Test_file.m
2.	POLY.m
3.	op.m
4.	op.fig
5.	main_file.m
6.	main_file.fig
7.	DH.m
8.	design_dh_.m
9.	design_dh_.fig
![image](https://user-images.githubusercontent.com/44742647/145686830-67b1d894-94df-4127-8218-bcdd4d7e1990.png)

Before running the main_file, please use the following command in the command window for smooth extrusion.
>> clear all
>> close all
>> clc  
Now to run the code, by either writing main_file.m in the command window or press the run button; both will work as shown in fig below

![image](https://user-images.githubusercontent.com/44742647/145686838-a35b8c45-35c9-46ad-869d-c2301d48b6ce.png)





As running the code, the first GUI screen will pop up shown below 
 ![image](https://user-images.githubusercontent.com/44742647/145686847-9d95faeb-63ce-492e-8e88-4f605c8670dd.png)


The program's first screen built a serial link robot based on DH parameters. In this part, enter the DOF in the given box and then press the set DOF button. Then after if the DH parameters are known, fill the DH table on the right side, then click on Apply DH Parameter and move to the next; if not, click on the bottom left button.
![image](https://user-images.githubusercontent.com/44742647/145686854-e97695b4-3a77-467f-9546-5bbfecc3c9b4.png)

 
If the DH parameter is not known, we allow to build up the robot by visualizing, which allows the user to see the robot, add and remove the link or update the link parameter. Based on that, we generalized the DH parameter of the robot. 
![image](https://user-images.githubusercontent.com/44742647/145686861-55ec696f-fc52-4843-a2b7-cb8e2faf38d8.png)

 
After setting up the robot, we move to the next window called operation windows op
We can perform forward and inverse kinematics algorithms onto the created manipulator in this window.
To perform the Forward kinematics, we need to define the joint variable into the table given and press the forward kinematics button. After pressing the forward kinematics button, the manipulator moves and achieves desired X Y Z coordinate points with a constant velocity trajectory. 
![image](https://user-images.githubusercontent.com/44742647/145686867-136942fe-2a0d-4066-b119-93ac4e572004.png)

 

For inverse kinematics algorithm, we need to give the X Y Z points and press the inverse kinematics button, 
As a result, follow the constant velocity trajectory and achieve the desired position and orientation. On the right side of the screen, we can see the behavior of the robot while following the trajectory 
 
![image](https://user-images.githubusercontent.com/44742647/145686872-78d1ec04-ad12-4b11-83c5-197759c4219c.png)


