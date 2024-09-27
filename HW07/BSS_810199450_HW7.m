clc,clear,close all;

%% Preprocessing

load hw7.mat

%% Question 1

L = 100;
K = 5;
iterations = 20;

[s,alpha,tau] = SingleChannelSBD(x1,L,K,iterations);

s1 = x1*0;
for k = 1:K
    s1(tau(k):tau(k)+L-1) = s*alpha(k);
end

figure
subplot(2,1,1)
plot(x1)
title('x1')
subplot(2,1,2)
plot(s1)
title('s1')


%% Question 2

L = 100;
K = 5;
iterations = 20;

[s,alpha,tau] = SingleChannelSBD(x2,L,K,iterations);

s2 = x2*0;
for k = 1:K
    s2(tau(k):tau(k)+L-1) = s*alpha(k);
end

figure
subplot(2,1,1)
plot(x2)
title('x2')
subplot(2,1,2)
plot(s2)
title('s2')

%% Question 3

L = 100;
K = 5;
N = 2;
iterations = 50;

[A,S] = MultiChannelSBD(X,L,K,N,iterations);

figure
subplot(2,2,1)
plot(X(1,:))
title('x1')
subplot(2,2,2)
plot(X(2,:))
title('x2')
subplot(2,2,3)
plot(S(1,:))
title('s1')
subplot(2,2,4)
plot(S(2,:))
title('s2')

%% Question 4

[s,alpha,tau] = SingleTuneExtractor(x1,L,K);

s1 = x1*0;
for k = 1:K
    s1(tau(k):tau(k)+L-1) = s*alpha(k);
end

figure
subplot(2,1,1)
plot(x1)
title('x1')
subplot(2,1,2)
plot(s1)
title('s1')
