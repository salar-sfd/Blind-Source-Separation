function [B,S_hat,Similarity_Cell] = ICA_FP(Z,Threshold,B)

    [M,T] = size(Z);

    Similarity_Cell = cell(M,1);
    
    
    for m = 1:M
        Similarity =[];
        Similarity(1) = Threshold;
        while Similarity(end) <= Threshold
            y = B(m,:)*Z;
            
            df_db = ((Z*(y.^3).')).'/T - 3*(B(m,:));
            
            b = df_db;
            if m~=1
                b = ((eye(M)-B(1:m-1,:).'*B(1:m-1,:))*b.').';
            end
            b = normr(b);
            Similarity = [Similarity,abs(B(m,:)*b.')];
            B(m,:) = b;
        end
        Similarity_Cell{m,1} = Similarity;
    end
    
    S_hat = B*Z;
    
end

