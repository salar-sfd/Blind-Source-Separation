function [D,S,Error] = MOD(X,N,iterations,number_of_initialiations) 
    
    tic
    [M,T] = size(X);
    K = number_of_initialiations;
    D = zeros(M,N,K);
    S = zeros(N,T,K);
    Error = zeros(iterations,K);
    
    for k = 1:K
        D(:,:,k) = normc(rand(M,N)*2-1);
        for i = 1:iterations
            for t = 1:T
                S(:,t,k) = OMP(D(:,:,k),X(:,t),2);
            end
            D(:,:,k) = X*pinv(S(:,:,k));
            D(:,:,k) = normc(D(:,:,k));
            Error(i,k) = (norm(X-D(:,:,k)*S(:,:,k),'fro')).^2;
        end
    end
    
    [~,index] = min(Error(end,:));
    
    Error = Error(:,index);
    D = D(:,:,index);
    S = S(:,:,index);
    toc
    
end
