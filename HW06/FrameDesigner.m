function [D,u] = FrameDesigner(N,M,iterations) 
    
    K = 1000;
    N_list = 1:N;
    u = zeros(1,K);
    U = zeros(M,N,K);
    
    for k = 1:K
        D = normc(rand(M,N).*2-1);
        for i = 1:iterations
            for n = N_list
                R = D(:,N_list~=n) * D(:,N_list~=n).';
                [V,L] = eig(R);
                [~,index] = min(diag(L));
                D(:,n) = V(:,index);
            end

        end
        u(k) = MutCoh(D);
        U(:,:,k) = D;
    end
    
    [~,index] = min(u);
    D = U(:,:,index);
     
end
