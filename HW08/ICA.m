function [B,S_hat,Norm_Grad_list] = ICA(X,miu,Threshold)

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
        df_dB = Psi*(X.')/T - (B^-1).';
        Norm_Grad_list = [Norm_Grad_list,norm(df_dB,'fro')];
        B = normr(B - miu.*df_dB);
    end
    
    S_hat = B*X;
    
end
