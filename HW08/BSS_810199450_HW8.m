clc,clear,close all;

%% Preprocessing

load hw8.mat

X_raw = A*S;
X = A*S+Noise;

figure
for i = 1:size(X,1)
    subplot(3,2,2*i-1)
    plot(X_raw(i,:))
    title(i)
    subplot(3,2,2*i)
    plot(X(i,:))
    title(i)
end

%% Question 1

miu = 0.001;
Threshold = 1e-6;
[B,S_hat,Norm_Grad_list] = ICA(X*100,miu,Threshold);

Final_Matrix = B*A;

%% Question 2

S_hat = Scale_Permutation_Recovery(S,S_hat);

figure
for n = 1:size(S,1)
    subplot(3,1,n)
    plot(S(n,:)),hold on,plot(S_hat(n,:));
    title(n)
end

Error = (norm(S-S_hat,'fro')/norm(S,'fro'))^2;

%% Question 3

figure
plot(Norm_Grad_list)
xlabel('Number of iterations')
ylabel('Norm of df/dB')