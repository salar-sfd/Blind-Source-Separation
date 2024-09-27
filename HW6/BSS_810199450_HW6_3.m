clc,clear,close all;

%% Preprocessing

load hw6-part3

%% Question 1

u = MutCoh(D);

%% Question 2&4

    %% MOD
    iterations = 50;
    number_of_initialiations = 1;
    [D_hat1,S_hat1,Error1] = MOD(X,size(S,1),iterations,number_of_initialiations);

    %% KSVD

    iterations = 50;
    number_of_initialiations = 1;
    [D_hat2,S_hat2,Error2] = KSVD(X,size(S,1),iterations,number_of_initialiations);

%% Question 

figure
subplot(2,1,1);
plot(Error1)
title('MOD Representation Error per Iteration')
subplot(2,1,2);
plot(Error2)
title('KSVD Representation Error per Iteration')

%% Question 5

srr1 = SRR(D,D_hat1,0.98);
srr2 = SRR(D,D_hat2,0.98);

%% Question 6

[D_hat1,S_hat1] = Scale_Permutation_Recovery(D,S,S_hat1,D_hat1);
E1 = (norm(S-S_hat1,'fro')^2)/(norm(S,'fro')^2);

[D_hat2,S_hat2] = Scale_Permutation_Recovery(D,S,S_hat2,D_hat2);
E2 = (norm(S-S_hat2,'fro')^2)/(norm(S,'fro')^2);

