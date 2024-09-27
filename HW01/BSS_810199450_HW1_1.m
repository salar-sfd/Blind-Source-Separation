clc,clear,close all;

%% part 1
%% Question 1

subplot(2,2,1);

% creating sources
T=1000;
s_1=(rand(1,T)-0.5)*6;
s_2=(rand(1,T)-0.5)*4;
S=[s_1;s_2];

% creating mixture function
A=[0.6 0.8 ; 0.8 -0.6];

%creating observations
X=A*S;
% plotting observations
scatter(X(1,:),X(2,:));
title('Observations with boundries');

%% Question 2

%extracting mixture function
Sections=40;
A_star=extract_mixture_function(X,Sections);

%% Question 3

subplot(2,2,2);

% adding noise to the sources
S_n(1,:) = awgn(S(1,:),20);
S_n(2,:) = awgn(S(2,:),20);

%creating observations
X_n=A*S_n;

% plotting noisy observations
scatter(X_n(1,:),X_n(2,:));

%extracting mixture function
Sections=40;
A_star_noisy=extract_mixture_function(X_n,Sections);
title('Noisy observations with boundries');

similarity=mean([dot(A(:,1),A_star_noisy(:,1))/(norm(A(:,1))*norm(A_star_noisy(:,1))),dot(A(:,2),A_star_noisy(:,2))/(norm(A(:,2))*norm(A_star_noisy(:,2)))]);

%% Question 4

subplot(2,2,3);

nbins=20;
histogram(X(1,:),nbins);
title('x1 histogram');

%% Question 5

subplot(2,2,4);

nbins=20;
histogram(X(2,:),nbins);
title('x2 histogram');