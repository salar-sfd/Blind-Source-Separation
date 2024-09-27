function s = LASSO(D,x,iterations,lambda) 
    
    [~,N] = size(D);
    s = rand(N,1);
    N_list = 1:N;
    
    for i = 1:iterations
        for n = N_list
            rho = (x - D(:,N_list~=n) * s(N_list~=n)).' * D(:,n);
            
            if rho>lambda/2
                s(n) = rho - lambda/2;
            elseif rho<-lambda/2
                s(n) = rho + lambda/2;
            else
                s(n) = 0;
            end
            
        end
    end
    
end
