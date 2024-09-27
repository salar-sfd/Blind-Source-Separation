function [s,alpha,tau]=SingleTuneExtractor(x1,L,K)
    
    len = length(x1);
    x1_hat = fftshift(fft(x1))/len;
    f = (-len/2 : len/2-1)/len;
    
%     figure
%     plot(f,abs(x1_hat));

    i = find(abs(x1_hat) == max(abs(x1_hat)));
    t = 1:L;

    A = imag(x1_hat(i(1)));
    s = A*sin(2*pi*f(max(i)).*t);
    s = s/norm(s);
    
    [alpha,tau] = AlphaTauUpdate(x1,s,K,L,length(x1));
end
