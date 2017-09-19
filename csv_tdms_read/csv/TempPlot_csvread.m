clear all; close all;
plotfigs = 1;

X = csvread('b141511.csv',1,0); 
TMP=X(:,1);
LED=X(:,2);
PD=X(:,3);

% plot(TMP,'r');
% hold on;
% plot(LED,'b');
% hold on;
% plot(PD,'b');
% hold off; 
% title('TMP, LED, PD vs Time');
% xlabel('Time');
% ylabel('Volts or degC');
% legend('TMP','LED','PD');
figure();
subplot(3,1,1);
plot(TMP,'r');
title('TMP (degC) vs Time (mins)');
subplot(3,1,2);
plot(LED,'b');
title('LED voltage (V) vs Time (mins)');
subplot(3,1,3);
plot(PD,'b');
title('PDout (V) vs Time (mins)');