close all; clear all; clc;

load('thermal100uA.mat');

ILED=data(:,1);
Temp=data(:,2);
VLED=data(:,3);
PDout=data(:,4);
NumILEDsteps=40;

X_ILED=ILED(1:NumILEDsteps);

Temptemp=[];
Y_Temp=[];
for i=1:length(Temp)/NumILEDsteps
    Temptemp=Temp((i-1)*NumILEDsteps+10);
    Y_Temp=[Y_Temp;Temptemp];
    
end

PDoutrow=PDout.'; 
rowtemp=[];
Z_PDout=[];
for i=1:length(ILED)/NumILEDsteps
    rowtemp=PDoutrow((i-1)*NumILEDsteps+1:(i-1)*NumILEDsteps+NumILEDsteps);
    Z_PDout=[Z_PDout;rowtemp];
    
end


figure('Name','3D plot','NumberTitle','off');
surf(X_ILED,Y_Temp,Z_PDout);
xlabel('ILED (mA)');
ylabel('Temperature (degC)');
zlabel('PDout (V)');
%shading interp
colorbar