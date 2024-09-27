clc,clear,close all;

%% Preprocessing

load hw6-part1

%% Question 1

D_star = [D,-D];
s_star = linprog( ones(2*size(D,2),1) , [] , [] , D_star ...
                , x , zeros(2*size(D,2),1) , []);
s = s_star(1:size(D,2))-s_star(size(D,2)+1:end);

%% Question 2

N0 = 2;
s = MP(D,x,N0);

%% Question 3

D_star = [D,-D];
s_star = linprog( ones(2*size(D,2),1) , [] , [] , D_star ...
                , x_noisy , zeros(2*size(D,2),1) , []);
s = s_star(1:size(D,2))-s_star(size(D,2)+1:end);

%% Question 4

lambda = 0.6663;
iterations = 1000;
s1 = LASSO(D,x_noisy,iterations,lambda);

lambda = 4.3001;
iterations = 1000;
s2 = LASSO(D,x_noisy,iterations,lambda);
