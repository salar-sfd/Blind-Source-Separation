function s = MP(D,x,N0_or_T) 

    tic
    [~,N] = size(D);
    s = zeros(N,1);
    
    if N0_or_T>1
        N0 = N0_or_T;
        for n = 1:N0
            inner_product = D.' * x;
            [~ , i] = max(abs(inner_product));
            s(i) = inner_product(i);
            x = x-s(i)*(D(:,i));
        end
    else
        T = N0_or_T;
        E = 1;
        norm_x1 = norm(x);
        while (T < E)
            inner_product = D.' * x;
            [~ , i] = max(abs(inner_product));
            s(i) = inner_product(i);
            x = x-s(i)*(D(:,i));
            E = norm(x)/norm_x1;
        end
    end
    toc 
    
end
