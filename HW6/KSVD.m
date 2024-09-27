function [D,S,Error] = KSVD(X,N,iterations,number_of_initialiations) 
    
    tic
    [M,T] = size(X);
    K = number_of_initialiations;
    D = zeros(M,N,K);
    S = zeros(N,T,K);
    Error = zeros(iterations,K);
    N_list = 1:N;
    
    for k = 1:K
        D(:,:,k) = normc(rand(M,N)*2-1);
        for i = 1:iterations
            for t = 1:T
                S(:,t,k) = OMP(D(:,:,k),X(:,t),2);
            end
            for n = N_list
                Xr = X - D(:,N_list~=n,k) * S(N_list~=n,:,k);
                mXr = Xr(:,S(n,:,k)~=0);
                [U,sig,V] = svd(mXr);
                V = V.';
                [~,index] = max(diag(sig));
                D(:,n,k) = U(:,index);
                S(n,S(n,:,k)~=0,k) = sig(index,index) * V(index,:);
            end
            Error(i,k) = (norm(X-D(:,:,k)*S(:,:,k),'fro')).^2;
        end
    end
    
    [~,index] = min(Error(end,:));
    Error = Error(:,index);
    D = D(:,:,index);
    S = S(:,:,index);
    toc
    
end
