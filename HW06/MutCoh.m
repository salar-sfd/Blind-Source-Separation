function u = MutCoh(D) 
    
    [~,N] = size(D);
    U = abs(D.' * D);
    U(eye(N,'logical')) = 0;
    u = max(max(U));
     
end
