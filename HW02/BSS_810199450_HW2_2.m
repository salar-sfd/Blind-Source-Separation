clc,clear,close all;

%% part 2
%% Question 1

%subplot(2,2,1);

%creating sources

T = 1000;
t = (1:T)*1e-6;
f1 = 20000;
f2 = 10000;
fc = 1.5e8;
teta1 = 10*pi/180;
teta2 = 20*pi/180;

s_1 = exp(1j*2*pi*f1*t);
s_2 = exp(1j*2*pi*f2*t);
S = [s_1;s_2];

%creating noise

N = wgn(10,T,1,'linear');

%creating mixture function

c = 3e8;
d = transpose(0:9);
a1 = exp(-1j*2*pi*fc*d*sin(teta1)/c);
a2 = exp(-1j*2*pi*fc*d*sin(teta2)/c);
A=[a1 , a2];

%creating observations

X = A*S + N;

%% Question 2

%svd 
[U , S , V] = svd(X);

subplot(2,2,1);
%finding u_sig v_sig
for i = (min(size(S)):-1:1)
    if (S(i,i)^2 / sum(sum(S))^2 > 0.01)
        L=i;
        break;
    end
end

U_sig = U(: , 1:L);
V_sig = V(: , 1:L);

%beamforming for mixture

teta = -pi/2 : 0.01 : pi/2;
a = exp(-1j*2*pi*fc*d*sin(teta)/c);
mapped_a = (a' * U_sig);
f_teta = teta;
for i = 1:length(teta)
    f_teta(i)=norm(mapped_a(i,:));
end
plot(teta*180/pi , f_teta)
xlabel('teta');
ylabel('f(teta)');
title('Beamforming method for finding teta');

%finding most significant peaks
[peaks , teta_index] = findpeaks(f_teta);
estimated_tetas_beam = [];
for i = 1:length(peaks)
    if peaks(i)/max(peaks) > 0.96
        estimated_tetas_beam = [estimated_tetas_beam , teta(teta_index(i))*180/pi];
    end
end
disp(estimated_tetas_beam);

%% Question 3

subplot(2,2,2);

U_null = U(: , L+1:end);
V_null = V(: , L+1:end);

%Music for mixture

teta = -pi/2 : 0.01 : pi/2;
a = exp(-1j*2*pi*fc*d*sin(teta)/c);
mapped_a = (a' * U_null);
f_teta = teta;
for i = 1:length(teta)
    f_teta(i)=norm(mapped_a(i,:));
end
plot(teta*180/pi , f_teta)
xlabel('teta');
ylabel('f(teta)');
title('Music method for finding teta');

%finding most significant peaks
[peaks , teta_index] = findpeaks(-f_teta);
peaks = -peaks;
estimated_tetas_music = [];
for i = 1:length(peaks)
    if min(peaks)/peaks(i) > 0.5
        estimated_tetas_music = [estimated_tetas_music , teta(teta_index(i))*180/pi];
    end
end
disp(estimated_tetas_music);

%% Question 4

subplot(2,2,3);
f = 0 : 100 : 50000 ;
s = exp(1j*2*pi*transpose(t)*f);
mapped_g = (transpose(s) * V_sig);
g_f = f;
for i = 1:length(f)
    g_f(i)=norm(mapped_g(i,:));
end
plot(f , g_f)
xlabel('f');
ylabel('g(f)');
title('Beamforming method for finding frequency');

%finding most significant peaks
[peaks , f_index] = findpeaks(g_f);
estimated_fs_beam=[];
for i = 1:length(peaks)
    if peaks(i)/max(peaks) > 0.96
        estimated_fs_beam = [estimated_fs_beam , f(f_index(i))];
    end
end
disp(estimated_fs_beam);

%% Question 5

subplot(2,2,4);
f = 0 : 100 : 50000 ;
s = exp(1j*2*pi*transpose(t)*f);
mapped_g = (transpose(s) * (V_null));
g_f = f;
for i = 1:length(f)
    g_f(i)=norm(mapped_g(i,:));
end
plot(f , g_f)
xlabel('f');
ylabel('g(f)');
title('Music method for finding frequency');

%finding most significant peaks
[peaks , f_index] = findpeaks(-g_f);
peaks = -peaks;
estimated_fs_music=[];
for i = 1:length(peaks)
    if min(peaks)/peaks(i) > 0.5
        estimated_fs_music = [estimated_fs_music , f(f_index(i))];
    end
end
disp(estimated_fs_music);