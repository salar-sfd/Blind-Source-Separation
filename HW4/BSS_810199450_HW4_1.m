clc,clear,close all;

%% Preprocessing

c = [0.2 0.4 0.6 -0.1 -0.3];
d = [0.1 0.3 -0.2 0.5 -0.3];
pages = length(c);
fs = 20;

t = 0:1/fs:5-1/fs;

c_extend = t;
d_extend = t;
for p = 1:pages
    c_extend(floor((p-1)/pages * length(t) + 1 : p/pages * length(t))) = c(p);
    d_extend(floor((p-1)/pages * length(t) + 1 : p/pages * length(t))) = d(p);
end

S = [c_extend.*sin(2*pi*t) ; d_extend.*sin(4*pi*t)];

A = [0.8 -0.6 ; 0.6 0.8];

X = A*S;

%% Question 1

figure
subplot(2,1,1);
plot(t,S);
legend('s_{1}(t)','s_{2}(t)')
xlabel('t(sec)');
title('Sources');
subplot(2,1,2);
plot(t,X);
legend('x_{1}(t)','x_{2}(t)')
xlabel('t(sec)');
title('Observations');

%% Question 2

for p = 1:pages
    Xp = X(:,floor((p-1)/pages * length(t) + 1 : p/pages * length(t)));
    R_X(:,:,p) = Xp*Xp.';
end

[U,L] = eig(R_X(:,:,1),R_X(:,:,2));

B = U.';


S_hat = B*X;
S_hat = S_hat(end:-1:1,:);

[E,S_hat] = Error(S_hat,S);

figure
subplot(2,1,1);
plot(t,S);
legend('s_{1}(t)','s_{2}(t)')
xlabel('t(sec)');
title('Sources');
subplot(2,1,2);
plot(t,S_hat);
legend('s_{1}(t) estimation','s_{2}(t) estimation')
xlabel('t(sec)');
title('Sources estimation');


%% Question 3

iterations = 50;
initial_B = [1 0;0 1];
K = pages;
S_hat = Extract_S(X,initial_B,iterations,'Uncorl',K);

S_hat = S_hat(end:-1:1,:);

[E,S_hat] = Error(S_hat,S);

figure
subplot(2,1,1);
plot(t,S);
legend('s_{1}(t)','s_{2}(t)')
xlabel('t(sec)');
title('Sources');
subplot(2,1,2);
plot(t,S_hat);
legend('s_{1}(t) estimation','s_{2}(t) estimation')
xlabel('t(sec)');
title('Sources estimation');

%% Question 4

SNR = 100;
Y = Add_Noise(X,SNR);

iterations = 500;
initial_B = [1 0;0 1];
K = pages;
S_hat = Extract_S(Y,initial_B,iterations,'Uncorl',K);

S_hat = S_hat(end:-1:1,:);

[E,S_hat] = Error(S_hat,S);

figure
subplot(2,1,1);
plot(t,S);
legend('s_{1}(t)','s_{2}(t)')
xlabel('t(sec)');
title('Sources');
subplot(2,1,2);
plot(t,S_hat);
legend('s_{1}(t) estimation','s_{2}(t) estimation')
xlabel('t(sec)');
title('Sources estimation');

%% Question 5

E = zeros(100,4);
SNR = 10;
iterations = 50;
initial_B = [1 0;0 1];
for n = 1:100
    for K = 2:5
        Y = Add_Noise(X,SNR);
        S_hat = Extract_S(Y,initial_B,iterations,'Uncorl',K);

        S_hat = S_hat(end:-1:1,:);

        [E(n,K-1),~] = Error(S_hat,S);
    end
end
E = mean(E,1);

figure
stem(2:5,E)
title('Error Values')
xlabel('K')

%% Question 6

E = zeros(100,4);
K = 5;
iterations = 50;
initial_B = [1 0;0 1];
SNR = [5 10 15 20];
for n = 1:100
    for i = 1:4
        Y = Add_Noise(X,SNR(i));
        S_hat = Extract_S(Y,initial_B,iterations,'Uncorl',K);

        S_hat = S_hat(end:-1:1,:);
        
        [E(n,i),~] = Error(S_hat,S);
    end
end
E = mean(E,1);

figure
stem([5 10 15 20],E)
title('Error Values')
xlabel('SNR')