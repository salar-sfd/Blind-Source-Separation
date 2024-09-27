clc,clear,close all;

%% Preprocessing

load hw5.mat

%% Question 1


N0 = 3;
s = SubSel(D,x,N0);

%% Question 2

s = pinv(D)*x;

%% Question 3

N0 = 3;
s1 = MP(D,x,N0);

T=0.1;
s2 = MP(D,x,T);

%% Question 4

N0 = 3;
s1 = OMP(D,x,N0);

T = 0.1;
s2 = OMP(D,x,T);

%% Question 5

tic
D_star = [D,-D];
s_star = linprog( ones(2*size(D,2),1) , [] , [] , D_star ...
                , x , zeros(2*size(D,2),1) , []);
s = s_star(1:size(D,2))-s_star(size(D,2)+1:end);
toc

%% Question 7

iterations = 50;
s = IRLS(D,x,iterations);

