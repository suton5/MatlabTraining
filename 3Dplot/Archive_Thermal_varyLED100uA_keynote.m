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

%Find all closest to 10mA PDout at 25 degC
diff=abs(PDout-PDout(6));
index=find(diff < 0.01*PDout(6));
y_ILED= ILED(index);
y_VfLED= VLED(index);

figure('Name','VPD, ILED, VfLED compare','NumberTitle','off');
x=Temp(index);
subplot(4,1,1)
plot(x,PDout(index),'*');
xlabel('Temp (degC)');
ylabel('PDout (V)');

title('PDout (V)');
subplot(4,1,2)
plot(x,ILED(index),'*');
hold on;
%curve fit
  p1 =   2.286e-06;
       p2 =  -6.043e-05;
       p3 =    0.001082;
       p4 =       10.03;
y=p1*x.^3 + p2*x.^2 + p3*x + p4;
plot(x,y);


title('ILED (mA)');
xlabel('Temp (degC)');
ylabel('ILED (mA)');
hold off;



subplot(4,1,3)
y=VLED(index);
plot(x,y,'*');
hold on;
%curve fit
p1 =   1.971e-06 ;
       p2 =   -0.001072;
       p3 =       1.268 ;
y=p1*x.^2 + p2*x + p3;
plot(x,y);
title('LED-V_f (V)');
xlabel('Temp (degC)');
ylabel('LED-V_f (V)');


subplot(4,1,4)
plot(y_VfLED,y_ILED,'*');
hold on;
%curve fit
   a =   3.036e+04  ;
   b =      -58.35 ;
   c =       9.953 ;


x=y_VfLED;
y = a*x.^b+c;
plot(x,y);
title('ILED (mA) vs LED-V_f (V)');
xlabel('LED-V_f (V)');
ylabel('ILED (mA)');
hold off;

figure('Name','ILED vs VLED - diff scales','NumberTitle','off');
%curve fit
   a =   3.036e+04  ;
   b =      -58.35 ;
   c =       9.953 ;
x=y_VfLED;
y = a*x.^b+c;
plot(x,y,'b');
hold on;
y = 2*a*x.^b+c;
plot(x,y,'r');
hold on;
y = 3*a*x.^b+c;
plot(x,y,'g');
hold on;


title('ILED (mA) vs LED-V_f (V)');
xlabel('LED-V_f (V)');
ylabel('ILED (mA)');
legend('1x','2x','3x')
hold off;



figure('Name','VPdOut Temp comp','NumberTitle','off');
indexA=find(ILED == 10);
y_10mA=PDout(indexA(1:10));
x_10mA=Temp(indexA(1:10));
plot(x_10mA,y_10mA,'b');
hold on;
y_10mA=PDout(indexA(10:19));
x_10mA=Temp(indexA(10:19));
plot(x_10mA,y_10mA, 'r');
hold on;

%ILED temp comp curve fit
  p1 =   2.286e-06;
       p2 =  -6.043e-05;
       p3 =    0.001082;
       p4 =       10.03;
y_ILEDcomp=[];
x_ILEDcomp=[];
       
for i=1:length(Temp)/40
    x=mean(Temp((i-1)*40+1:(i-1)*40+40));
    ILEDcomp=p1*x^3 + p2*x^2 + p3*x + p4;
    %find nearest
    y=ILED((i-1)*40+1:(i-1)*40+40);
    diff=abs(y-ILEDcomp);
    [M,I] = min(diff);
    y_ILEDcomp(i)=PDout((i-1)*40+I);
    x_ILEDcomp(i)=Temp((i-1)*40+I);
end
y_comp=y_ILEDcomp(1:10);
x_comp=x_ILEDcomp(1:10);
plot(x_comp,y_comp,'b');
hold on;
y_comp=y_ILEDcomp(10:19);
x_comp=x_ILEDcomp(10:19);
plot(x_comp,y_comp,'r');
hold on;

title('PDout vs PDout Temp Comp  (V)');
xlabel('Temp (degC)');
ylabel('PDout (V)');
legend('Original Temp ascending','Original Temp descending','Compensated Temp ascending','Compensated Temp descending')
hold off;