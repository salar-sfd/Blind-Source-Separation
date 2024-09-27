clc,clear,close all;

%% Preprocessing

load hw3-2.mat

data = data - mean(data,2);

%creating template matrixes
sample_rate = 250;
total_samples = size(data,2);
max_harmonic_freq = 40;
t = (1 : total_samples) / sample_rate;

X = cell(1 , length(freq));

for i = 1 : length(freq)
    k = 1 : floor(40/freq(i));
    x1 = sin(2*pi*freq(i)*k.'*t);
    x2 = cos(2*pi*freq(i)*k.'*t);
    X{i} = [x1 ; x2];
end

%% Feature extracting

Y = data;
estimated_label = zeros(1 , size(data,3) );
for j = 1 : size(data,3)
    ro = zeros(1 , length(freq));
    
    for i = 1 : length(freq)
        
        Rx = X{i} * X{i}.';
        Ry = Y(:,:,j) * Y(:,:,j).';
        Rxy = X{i} * Y(:,:,j).';
        Ryx = Rxy.';
        
        Sigma1 = Rx^-0.5 * Rxy * Ry^-1 * Ryx * Rx^-0.5;
        Sigma2 = Ry^-0.5 * Ryx * Rx^-1 * Rxy * Ry^-0.5;
        [U1,L1] = eig(Sigma1);
        a = Rx^-0.5 * U1(: , 1);
        [U2,L2] = eig(Sigma2);
        b = Ry^-0.5 * U2(: , 1);
        
        ro(i) = abs(a.' * Rxy * b) / sqrt(a.'*Rx*a) / sqrt(b.'*Ry*b) ;
        
    end
    
    [~,index] = max(ro);
    estimated_label(j) = freq(index);
end

success = sum( estimated_label == label ) / length( estimated_label );

scatter(1:length(label),label,100,'o')
hold on
scatter(1:length(estimated_label),estimated_label,100,'*')
legend('Real Class' , 'Estimated Class')
title('Classifying Test Datas')
xlabel('Trial')