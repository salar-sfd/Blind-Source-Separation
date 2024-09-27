function [Y] = Add_Noise(X,SNR)
    W = wgn(size(X,1),size(X,2),0);
    W = W/norm(W,'fro');
    sigma = norm(X,'fro')/sqrt(SNR);
    Y = X + sigma*W;
end
