function [A,S] = MultiChannelSBD(X,L,K,N,iterations)
    
    [M,T] = size(X);
    A = normc(2*rand(M,N)-1);
    
    for i = 1:iterations
        S = pinv(A)*X;
        for  n = 1:N
            [s,alpha,tau] = SingleChannelSBD(X(n,:),L,K,iterations);
            S(n,:) = zeros(1,T);
            for k = 1:K
                S(n,tau(k):tau(k)+L-1) = s*alpha(k);
            end
        end
        A = normc(X*pinv(S));
    end
end
