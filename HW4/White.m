function [Z] = White(X)
    [U,L] = eig(X*X.');
    Z = L^-0.5 * U.' * X;
end