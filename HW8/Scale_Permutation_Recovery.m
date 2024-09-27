function [S_hat] = Scale_Permutation_Recovery(S,S_hat) 
    
    S_temp = S_hat.*0;
    N = size(S,1);
    
    corr_matrix = (S_hat*S.');

    for n = 1:N
        [~,i] = max(abs(corr_matrix(n,:)));
        scale = corr_matrix(n,i) /...
               (S_hat(n,:)*S_hat(n,:).');
        S_temp(i,:) = S_hat(n,:)*scale;
    end
    
    S_hat = S_temp;

end
