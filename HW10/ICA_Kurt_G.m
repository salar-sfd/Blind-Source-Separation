function [B,S_hat,Similarity_Cell] = ICA_Kurt_G(Z,miu,Threshold,B)

    [M,T] = size(Z);

    Similarity_Cell = cell(M,1);
    
    
    for m = 1:M
        Similarity =[];
        Similarity(1) = Threshold;
        while Similarity(end) <= Threshold
            y = B(m,:)*Z;
            
            g_y = y.*exp(-y.^2./2);
            
            df_db = (( Z*(g_y).'/T )).';
            
            b = B(m,:) + miu*df_db;
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

