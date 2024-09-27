function s = OMP(D,x,N0_or_T) 

    [~,N] = size(D);
    s = zeros(N,1);
    
    if N0_or_T>=1
        N0 = N0_or_T;
        for n = 1:N0
            
            if(mod(n,2)==1)
                inner_product = D.' * x;
                [~ , i] = max(abs(inner_product));
                s(i) = inner_product(i);
                xr = x-s(i)*(D(:,i));
                j = i;
            else
                inner_product = D.' * xr;
                [~ , i] = max(abs(inner_product));
                s([i j]) = pinv(D(:,[i j]))*x;
                x = x-D(:,[i j])*s([i j]);
            end
                
        end
    else
        T = N0_or_T;
        E = 1;
        n = 1;
        norm_x1 = norm(x);
        while (T < E)
            if(mod(n,2)==1)
                inner_product = D.' * x;
                [~ , i] = max(abs(inner_product));
                s(i) = inner_product(i);
                xr = x-s(i)*(D(:,i));
                j = i;
                E = norm(xr)/norm_x1;
            else
                inner_product = D.' * xr;
                [~ , i] = max(abs(inner_product));
                s([i j]) = pinv(D(:,[i j]))*x;
                x = x-D(:,[i j])*s([i j]);
                E = norm(x)/norm_x1;
            end
            n = n+1;
        end
    end
        
end
