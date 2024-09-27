clc,clear,close all;

%% Preprocessing

load hw3-1.mat

TrainData_class1 = TrainData_class1 - mean(TrainData_class1,2);
TrainData_class2 = TrainData_class2 - mean(TrainData_class2,2);
TestData = TestData - mean(TestData,2);
%saving number of trials
not = size(TrainData_class1 , 3);

%% Question 1

Rx1 = mean(pagemtimes(TrainData_class1,'none',TrainData_class1,'transpose') , 3);

Rx2 = mean(pagemtimes(TrainData_class2,'none',TrainData_class2,'transpose') , 3);

[W , L] = eig(Rx1 , Rx2);
W = normc(W);
[~,ind] = sort(diag(L));
L = L(ind,ind);
W = W(:,ind);

Filtered_TrainData_class1 = pagemtimes(W,'transpose',TrainData_class1,'none');
Filtered_TrainData_class2 = pagemtimes(W,'transpose',TrainData_class2,'none');

figure

subplot(2,1,1)
trial = 49;
plot( W(:,1).'*TrainData_class1(:,:,trial))
hold on
plot( W(:,1).'*TrainData_class2(:,:,trial))
legend('class 1','class 2')
title(['Trail',string(trial),'image signal on W(1)'])
varX11 = var(W(:,1).'*TrainData_class1(:,:,trial));
varX12 = var(W(:,1).'*TrainData_class2(:,:,trial));

subplot(2,1,2)
plot( W(:,end).'*TrainData_class1(:,:,trial))
hold on
plot( W(:,end).'*TrainData_class2(:,:,trial))
legend('class 1','class 2')
title(['Trail',string(trial),'image signal on W(30)'])
varX21 = var(W(:,end).'*TrainData_class1(:,:,trial));
varX22 = var(W(:,end).'*TrainData_class2(:,:,trial));

%% Question 2

figure
plot(abs(W(:,1)))
hold on
plot(abs(W(:,30)))
legend('abs(W(1))','abs(W(30))')
title('Channels weight on output')

%% Question 3

%setting number of filters
nof = 14;
W = [ W( : , 1:nof/2 ) , W( : , end+1-nof/2 :end ) ];

set1 = squeeze( var(pagemtimes(W,'transpose',TrainData_class1,'none'),0,2) );
set2 = squeeze( var(pagemtimes(W,'transpose',TrainData_class2,'none'),0,2) );

% for nof=2 we can plot set datas
% figure
% scatter(set1(1,:),set1(2,:))
% hold on
% scatter(set2(1,:),set2(2,:))

u1 = mean(set1,2);
u2 = mean(set2,2);
sig1 = 1/not * (set1 - u1) * (set1 - u1).';
sig2 = 1/not * (set2 - u2) * (set2 - u2).';

V1 = (u1 - u2) * (u1 - u2).';
V2 = sig1 + sig2;

[W_lda , L_lda] = eig(V1 , V2);
W_lda = normc(W_lda);
[l,ind] = sort(diag(L_lda));
L_lda = L_lda(ind,ind);
W_lda = W_lda(:,ind);

w_lda = W_lda(:,end);
threshold = 0.5 * (mean(w_lda.' * set1) + mean(w_lda.' * set2));

%% Question 4

test_set = squeeze( var(pagemtimes(W,'transpose',TestData,'none'),0,2) );
image = w_lda.' * test_set;
estimated_label = (image>threshold) + 1;

%% Question 5

success = sum( estimated_label == TestLabel ) / length( estimated_label );

figure
scatter(1:length(TestLabel),TestLabel,100,'o')
hold on
scatter(1:length(estimated_label),estimated_label,100,'*')
legend('Real Class' , 'Estimated Class')
title('Classifying Test Datas')
xlabel('Trial')