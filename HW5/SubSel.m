function s = SubSel(D,x,N0) 

    tic
    [M,N] = size(D);
    subsets_index = nchoosek(1:N,N0);
    
    D_3d = zeros(M,N0,length(subsets_index));
    D_3d_pseudo = zeros(N0,M,length(subsets_index));
    for i = 1:length(subsets_index)
        D_3d(:,:,i) = D(:,subsets_index(i,:));
        D_3d_pseudo(:,:,i) = pinv(D(:,subsets_index(i,:)));
    end
    
    S = pagemtimes(D_3d_pseudo,x);
    E = vecnorm(squeeze(pagemtimes(D_3d,S) - x));
    
    s = zeros(N,1);
    [~ , i] = min(E);
    s(subsets_index(i,:)) = S(:,1,i);
    toc
    
end
