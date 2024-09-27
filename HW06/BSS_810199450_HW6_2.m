clc,clear,close all;

%% Preprocessing

N = 5;

%% Question 1

    %% First solution
    
    iterations = 40;
    [D,u] = FrameDesigner(N,2,iterations); 
    
    figure
    
    subplot(1,2,1)
    quiver(zeros(1,N),zeros(1,N),D(1,:),D(2,:));
    axis equal
    title('Frame')
    
    subplot(1,2,2)
    plot(u);
    title('Mutual Coherense For Each Initialization')
    
    disp(min(u))

    %% Second Solution
    
    K = 50;
    for k = 1:K
        phi = linspace(0,pi,k+1);
        phi(end) = [];
        D = [cos(phi) ; sin(phi)];
        u(k) = MutCoh(D);
    end
    plot(u)
    title('Mutual Coherence Per N')

%% Question 2

iterations = 40;
[D,u] = FrameDesigner(N,3,iterations); 

figure

subplot(1,2,1)
quiver3(zeros(1,N),zeros(1,N),zeros(1,N),D(1,:),D(2,:),D(3,:));
axis equal

subplot(1,2,2)
plot(u);
title('Mutual Coherense For Each Initialization')

disp(min(u))

