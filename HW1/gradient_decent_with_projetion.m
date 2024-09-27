function [f_values]=gradient_decent_with_projetion(f,x,X0,iterations,u)
    X=X0;
    grad=gradient(f,x);
    f_values=zeros(1,iterations);
    for i=1:iterations
        X=X/norm(X);
        f_values(i)=subs(f,x,X);
        X=vpa(X-u*subs(grad,x,X));
    end
    X=X/norm(X);
end