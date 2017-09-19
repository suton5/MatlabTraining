close all; clear all; clc;

load('thermalLEDonly.mat');

ILED=data(:,1);
Temp=data(:,2);     %T(K) = T(�C) + 273.15
VLED=data(:,3);
PDout=data(:,4);


X_ILED=ILED(1:20);
i=1;

Temptemp=[];
Y_Temp=[];
for i=1:length(Temp)/20
    Temptemp=Temp((i-1)*20+10);
    Y_Temp=[Y_Temp;Temptemp];
    
end


Y_Vf=[];
p_fit=[];
figure('Name','Plot Vf lines','NumberTitle','off');

for j=1:20
    for i=1:length(Temp)/20
        Y_Vftemp=VLED((i-1)*20+j);
        Y_Vf=[Y_Vf;Y_Vftemp];
    end
    plot(Y_Temp,Y_Vf);
    hold on;
      
    Y_Vf=[];
end
title('Vf vs Temp at ILED = 1mA to 20mA');
xlabel('Temp (degC)');
ylabel('Vf (V)');
hold off;

figure('Name','Plot Temp vs Poly Fitted Curve for ILED=10mA','NumberTitle','off');

for j=10
    for i=1:length(Temp)/20
        Y_Vftemp=VLED((i-1)*20+j);
        Y_Vf=[Y_Vf;Y_Vftemp];
    end
        
    p=polyfit(Y_Vf,Y_Temp,1);
    p_fit=[p_fit;p];
    Tcal=polyval(p,Y_Vf);
    plot(Y_Temp,Tcal,'r');
    
    hold on;
    
    Y_Vf=[];
    
end
plot(Y_Temp,Y_Temp,'k--');
title('Plot Temp vs Poly Fitted Curve for ILED=10mA');
xlabel('Temp (degC)');
ylabel('Calibrated Temp (degC)');
hold off;




figure('Name','Plot Error (degC) lines Fit each','NumberTitle','off');

for j=1:20
    for i=1:length(Temp)/20
        Y_Vftemp=VLED((i-1)*20+j);
        Y_Vf=[Y_Vf;Y_Vftemp];
    end
        
    p=polyfit(Y_Vf,Y_Temp,1);
    p_fit=[p_fit;p];
    Tcal=polyval(p,Y_Vf);
    Err=Tcal-Y_Temp;
    plot(Y_Temp,Err);
    
    hold on;
    
    Y_Vf=[];
     Tcal=[];
     Err=[];
    
end
title('Error vs Temp at ILED (fit each) = 1mA to 20mA');
xlabel('Temp (degC)');
ylabel('Error (degC)');
hold off;



