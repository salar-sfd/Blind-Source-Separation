function srr = SRR(D,D_hat,T) 
    
    N = size(D,2);
    srr = 0;
    for i = 1:N
        corr_list = abs(D_hat(:,i).'*D);
        [m,j] = max(corr_list);
        if m>T
            srr = srr+1;
            D(:,j) = [];
        end
    end
    srr = srr/N;
    
end
