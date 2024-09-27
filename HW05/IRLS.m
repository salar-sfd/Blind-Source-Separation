function s = IRLS(D,x,iterations) 
    
    tic
    [~,N] = size(D);
    s = zeros(N,1);
    
    t = 1e-6;
    w = (rand(1,N));
    for i = 1:iterations
        y = pinv(D*(diag(w.^-0.5)))*x;
        s = (diag(w.^-0.5))*y;
        cond = abs(s)>t;
        w(cond) = 1./abs(s(cond));
        w(~cond) = 1/t;
    end
    s(~cond) = 0;
    toc
    
end
