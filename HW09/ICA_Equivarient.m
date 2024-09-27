function [B,S_hat,Norm_Grad_list] = ICA_Equivarient(X,miu,Threshold)

    [M,T] = size(X);
    B = normr(rand(M,M)*2-1);
    Psi = zeros(M,T);
    
    Norm_Grad_list(1) = Threshold;
    
    while Threshold <= Norm_Grad_list(end)
        Y = B*X;
        for m = 1:M
            y = Y(m,:);
            k = [y.*0+1 ; y ; y.^2 ; y.^3 ; y.^4 ; y.^5];
            Psi(m,:) = Psi_Extractor(k);
        end
        D = Psi*(Y.')/T;
        D( 1 == reshape((eye(size(D))),1,[]) ) =...
            [0 0 0];
%              ((1-diag(Y*Y.'/T)).');
        Norm_Grad_list = [Norm_Grad_list,norm(D,'fro')];
        B = normr(B - miu.*D*B);
    end
    
    S_hat = B*X;
    
end
