clc,clear,close all;

%% part 1
%% Question 1

figure

% creating sources
T = 1000;
s_1 = (rand(1,T) - 0.5) * 6;
s_2 = (rand(1,T) - 0.5) * 4;
S = [s_1 ; s_2];
S = S - mean(S,2);

%creating mixture function
A = [1 -2 ; 2 -1 ; 3 -2];

%creating observations
X = A*S;

%plotting observations
scatter3(X(1,:) , X(2,:) , X(3,:));
title('Observations');

%finding Rx eigen vectors and values
Rx = X * transpose(X);
[U,D] = eig(Rx);

%rearranging matrixes from bigger to smaller lambdas
U = flip(U,2);
D = diag(flip(diag(D)));

%% Question 2

U_new = U;
D_new = D;
for i = 1:length(D)
    if (D(i,i) / sum(sum(D)) < 1e-8)
        U_new(:,i) = [];
        D_new(:,i) = [];
        D_new(i,:) = [];
    end
end

C = transpose(U_new) * A;

%% Question 3

figure

Z = ((D_new^-0.5) * transpose(U_new)) * X;
scatter(Z(1,:) , Z(2,:));
title('Observations mapped on 2d surface');

%% Question 4

[Q , G , V] = svd (X);

%% Question 5

F = S * transpose(V([1 , 2] , :));

%% Question 6

figure

%finding most signifacnt eigen values
for i = 1:length(D)
    if( sum(sum(D(1:i , 1:i))) / sum(sum(D)) > 0.9 )
        l=i;
        break;
    end
end

%eliminating non important vectors and values
U_new = U(: , 1:i);
D_new = D(1:i , 1:i);

%mapping X on the new space
X_new = transpose(U_new) * X ;

%plotting compressed observations
subplot(1,2,1);
scatter(X_new , zeros(1,length(X_new)));
title('Observations mapped on 1d space');
subplot(1,2,2);
histogram(X_new);
title('Histogram of compressed observations');