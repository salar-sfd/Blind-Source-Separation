clc,clear,close all;

%% Preprocessing


fs = 100;

load hw4-X1
load hw4-X2


%% Question 1

t = (0:size(X1,2)-1)/fs;

iterations = 50;
initial_B = [1 0;0 1];
S1_hat = Extract_S(X1,initial_B,iterations,'Mutual',0.15);

figure
subplot(2,1,1);
plot(t,X1);
legend('x1_{1}(t)','x1_{2}(t)')
xlabel('t(sec)');
title('Observations');
subplot(2,1,2);
plot(t,S1_hat);
legend('s1_{1}(t)','s1_{2}(t)')
xlabel('t(sec)');
title('Sources Estimation');

%% Question 2

L1 = size(S1_hat,2);

I1(1,:) = fft(S1_hat(1,:))/L1;
I1(2,:) = fft(S1_hat(2,:))/L1;

P2 = abs(I1/L1);
P1 = P2(:,1:L1/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);
f = fs*(0:(L1/2))/L1;

figure
plot(f,P1)
xlabel('f(Hz)')
ylabel('|2S_{1}(f)|')

L1 = size(X1,2);

Y1(1,:) = fft(X1(1,:))/L1;
Y1(2,:) = fft(X1(2,:))/L1;

P2 = abs(Y1/L1);
P1 = P2(:,1:L1/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);
f = fs*(0:(L1/2))/L1;

figure
plot(f,P1)
xlabel('f(Hz)')
ylabel('|2X_{1}(f)|')
%% Question 3

t = (0:size(X2,2)-1)/fs;

iterations = 50;
initial_B = [1 0;0 1];
S2_hat = Extract_S(X2,initial_B,iterations,'Mutual',0.5);

figure
subplot(2,1,1);
plot(t,X2);
legend('x2_{1}(t)','x2_{2}(t)')
xlabel('t(sec)');
title('Observations');
subplot(2,1,2);
plot(t,S2_hat);
legend('s2_{1}(t)','s2_{2}(t)')
xlabel('t(sec)');
title('Sources Estimation');

%% Question 4

L2 = size(S2_hat,2);

I2(1,:) = fft(S2_hat(1,:))/L2;
I2(2,:) = fft(S2_hat(2,:))/L2;

P2 = abs(I2/L2);
P1 = P2(:,1:L2/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);
f = fs*(0:(L2/2))/L2;

figure
plot(f,P1)
xlabel('f(Hz)')
ylabel('|2S_{2}(f)|')

L2 = size(X2,2);

Y2(1,:) = fft(X2(1,:))/L2;
Y2(2,:) = fft(X2(2,:))/L2;

P2 = abs(Y2/L2);
P1 = P2(:,1:L2/2+1);
P1(:,2:end-1) = 2*P1(:,2:end-1);
f = fs*(0:(L2/2))/L2;

figure
plot(f,P1)
xlabel('f(Hz)')
ylabel('|2X_{2}(f)|')