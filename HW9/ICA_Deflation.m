function [B,S_hat,Similarity_Cell] = ICA_Deflation(Z,miu,Threshold)

    [M,T] = size(Z);
    B = normr(rand(M,M)*2-1);
    df_dB = B.*0;
    Psi = zeros(1,T);
    Similarity_Cell = cell(M,1);
    
    
    for m = 1:M
        Similarity =[];
        Similarity(1) = Threshold;
        while Similarity(end) <= Threshold
            y = B(m,:)*Z;
            k = [y.*0+1 ; y ; y.^2 ; y.^3 ; y.^4 ; y.^5];
            Psi = Psi_Extractor(k);
            
            df_db = Psi*(Z.')/T ;
            
            b = B(m,:) - miu*df_db;
            if m~=1
                b = ((eye(M)-B(1:m-1,:).'*B(1:m-1,:))*b.').';
            end
            b = normr(b);
            Similarity = [Similarity,B(m,:)*b.'];
            B(m,:) = b;
        end
        Similarity_Cell{m,1} = Similarity;
    end
    
    S_hat = B*Z;
    
end
