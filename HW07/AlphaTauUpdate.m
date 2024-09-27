function [alpha,tau] = AlphaTauUpdate(x1,s,K,L,T)

    alpha = zeros(K,1);
    tau = alpha;

    [corr,lags] = xcorr(x1,s);
    corr = corr(lags>=0 & lags<=T-L);
%     plot(lags(lags>=0 & lags<=T-L),corr)

    for k = 1:K
        [alpha(k),tau(k)] = max(corr);
        corr(max(1,tau(k)-L+1):min(T-L,tau(k)+L-1)) = 0;
    end
    
end
