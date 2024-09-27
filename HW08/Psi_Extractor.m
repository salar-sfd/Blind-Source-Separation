function Psi = Psi_Extractor(k)

    P = k*k'/size(k,2);
    k_p = zeros(size(k,1),1);
    k_p(2:end) = ((1:size(k)-1).').*mean( k(1:end-1,:),2);
    Teta = P^-1*k_p;
    Psi = Teta.' * k;

end
