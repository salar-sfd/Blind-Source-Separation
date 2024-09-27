function [f_values]=newton(f,x,X0,iterations)
    X=X0;
    G=gradient(f,x);
    H=hessian(f,x);
    f_values=zeros(1,iterations);
    for i=1:iterations
        f_values(i)=subs(f,x,X);
        X=X-(subs(H,x,X))\subs(G,x,X);
    end
end