clc,clear,close all;

%% part 1
%% Question 1

subplot(1,2,1);

x1=-10:0.5:10;
x2=x1;
[X1,X2]=meshgrid(x1,x2);

F=20*log(X1.^2 + X2.^2 - 4*X1 - 6*X2 + X1.*X2 + 13);
surf(X1,X2,F);

%% Question 2

subplot(1,2,2);

contour(X1,X2,F,'ShowText','on');
xlabel('x1');
ylabel('x2');

%% Question 4

syms x1 x2;
x=[x1;x2];
f=x1^2+x2^2-4*x1-6*x2+x1*x2+13;

grad=gradient(f,x);
arg_min=solve(grad==0);

%% Question 5

figure

[f_values]=gradient_decent(f,x,[6;6],100,0.01);

subplot(2,2,1);
plot(f_values);
title('Gradient decent with u=0.01');
xlabel('Iteration');
ylabel('f');

[f_values]=gradient_decent(f,x,[6;6],100,0.1);

subplot(2,2,2);
plot(f_values);
title('Gradient decent with u=0.1');
xlabel('Iteration');
ylabel('f');

%% Question 6

[f_values]=newton(f,x,[6;6],10);

subplot(2,2,[3,4]);
plot(f_values);
title('Newton');
xlabel('Iteration');
ylabel('f');

%% Question 7

[f_values,X_way]=alternation_minimization(f,x,[6;6],10);

figure

subplot(1,2,1);
contour(X1,X2,F,'ShowText','on');
title('x changes through minimization');
xlabel('x1');
ylabel('x2');
hold on
plot(X_way(1,:),X_way(2,:),'--','LineWidth',1,'Marker','*');

subplot(1,2,2);
plot(f_values);
title('Alternation Minimization');
xlabel('Iteration');
ylabel('f');

%% Question 8

figure

[f_values]=gradient_decent_with_projetion(f,x,[6;6],100,0.1);

plot(f_values);
title('Gradient decent with projection and u=0.1');
xlabel('Iteration');
ylabel('f');


