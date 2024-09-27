function [S_hat] = Extract_S(X,initial_B,iterations,mode,K)
    Z = White(X);

    if(mode == 'Uncorl')
        pages = 5;
        for p = 1:K
            Zp = Z(:,floor((p-1)/pages * size(Z,2) + 1 : p/pages * size(Z,2)));
            R_Z(:,:,p) = Zp*Zp.';
        end
    end
    if(mode == 'Mutual')
        %K is (length of each window) / (length of Z )
        L = floor((K).*size(Z,2));
        tau = 31;
        i = 0;
        Z1 = Z(:,1:L);
        while(i*tau+L < size(Z,2))
            Zp = Z(:,i*tau+1:i*tau+L);
            i = i+1;
            R_Z(:,:,i) = Z1*Zp.';
        end
    end
    
    B = initial_B;
    for iter = 1:iterations
        T = [];
        for i = 1:size(B,1)

            Bc = B.';
            Bc(:,i) = [];
            Bc = Bc*Bc.';
            Ri = sum( pagemtimes(pagemtimes(R_Z,Bc),R_Z) , 3);

            [U,L] = eig(Ri);
            [~,ind] = min(diag(L));
            bi = U(:,ind);
            if(i~=1)
                bi = bi - (T*T.') * bi;
            end
            bi = bi / norm(bi);
            T = [T bi];
            B(:,i) = bi;
        end
    end

    S_hat = B * Z;
end