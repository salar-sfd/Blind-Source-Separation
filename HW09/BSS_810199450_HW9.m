clc,clear,close all;

%% Preprocessing

load hw9.mat

X_raw = A*S;
X = A*S+Noise;

figure
for i = 1:size(X,1)
    subplot(3,3,3*i-2)
    plot(S(i,:))
    title(i)
    subplot(3,3,3*i-1)
    plot(X_raw(i,:))
    title(i)
    subplot(3,3,3*i)
    plot(X(i,:))
    title(i)
end

%% Question 1_1

miu = 0.1;
Threshold = 1-1e-10;

[U,L] = eig(X*X.');
W = L^-(1/2) * U.';
Z = W*X;

[B,S_hat,Similarity_Cell] = ICA_Deflation(Z,miu,Threshold);

Final_Matrix = B*W*A;

%% Question 1_2

S_hat = Scale_Permutation_Recovery(S,S_hat);

figure
for n = 1:size(S,1)
    subplot(3,1,n)
    plot(S(n,:)),hold on,plot(S_hat(n,:));
    title(n)
end

Error1 = (norm(S-S_hat,'fro')/norm(S,'fro'))^2;

%% Question 1_3

figure
hold on
for m = 1:numel(Similarity_Cell)
    plot(Similarity_Cell{m,1})
end
legend('b1','b2','b3')
xlabel('Number of iterations')
ylabel('b*b^{T}')

%% Question 2_1

miu = 0.01;
Threshold = 1e-6;

[B,S_hat,Norm_Grad_list] = ICA_Equivarient(X*100,miu,Threshold);

Final_Matrix = B*A;

%% Question 2_2

S_hat = Scale_Permutation_Recovery(S,S_hat);

figure
for n = 1:size(S,1)
    subplot(3,1,n)
    plot(S(n,:)),hold on,plot(S_hat(n,:));
    title(n)
end

Error2 = (norm(S-S_hat,'fro')/norm(S,'fro'))^2;

%% Question 2_3

figure
plot(Norm_Grad_list)
xlabel('Number of iterations')
ylabel('Norm of df/dB * BT')