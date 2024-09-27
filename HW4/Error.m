function [E,S_hat] = Error(S_hat,S)
    S_hat = S_hat .* (sum(abs(S),2)./sum(abs(S_hat),2));

    E1 = (norm(S-S_hat,'fro')/norm(S,'fro')).^2;
    S_hat(1,:) = -S_hat(1,:);

    E2 = (norm(S-S_hat,'fro')/norm(S,'fro')).^2;
    S_hat(2,:) = -S_hat(2,:);
    
    E3 = (norm(S-S_hat,'fro')/norm(S,'fro')).^2;
    S_hat(1,:) = -S_hat(1,:);
    
    E4 = (norm(S-S_hat,'fro')/norm(S,'fro')).^2;
    S_hat(2,:) = -S_hat(2,:);

    [E,i] = min([E1 E2 E3 E4]);
    
    switch i
        case 1
            S_hat = S_hat;
        case 2
            S_hat(1,:) = -S_hat(1,:);
        case 3
            S_hat(1,:) = -S_hat(1,:);
            S_hat(2,:) = -S_hat(2,:);
        case 4
            S_hat(2,:) = -S_hat(2,:);
    end
end
