function [s,alpha,tau] = SingleChannelSBD(x1,L,K,iterations)
    
    T = size(x1,2);
    alpha = rand(K,1);
    tau = floor(linspace(1,T,K+1));
    tau(end) = [];
    Y = zeros(K,L);

    for i = 1:iterations
        
        for k = 1:K
        
            Y(k,:) = x1(tau(k):tau(k)+L-1);
%             subplot(K,1,k)
%             plot(Y(k,:))

        end
        
        s = alpha.'*Y / (alpha.'*alpha);
        s = s/norm(s);

        [alpha,tau] = AlphaTauUpdate(x1,s,K,L,T);

    end

end
