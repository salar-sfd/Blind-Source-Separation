function [D_hat,S_hat] = Scale_Permutation_Recovery(D,S,S_hat,D_hat) 
    
    D_temp = D_hat*0;
    S_temp = S_hat*0;
    
    N = size(D,2);
    for i = 1:N
        corr_list = (D_hat(:,i).'*D);
        [~,j] = max(abs(corr_list));
        if corr_list(j)<0
            D_temp(:,j) = -D_hat(:,i);
            S_temp(j,:) = -S_hat(i,:);
        else
            D_temp(:,j) = D_hat(:,i);
            S_temp(j,:) = S_hat(i,:);
        end
        D(:,j) = 0;
        S(j,:) = 0;
    end
    
    D_hat = D_temp;
    S_hat = S_temp;
    
end
