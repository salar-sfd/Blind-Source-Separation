function [f_values,X_way]=alternation_minimization(f,x,X0,iterations,u)
    X=X0;
    grad=gradient(f,x);
    for i=1:length(x)
        eq(i,1)=solve(grad(i)==0,x(i));
    end
    f_values=zeros(1,iterations);
    for i=(1:iterations/length(x))-1
        for j=1:length(x)
            X_way(:,i*length(x)+j)=X;
            f_values(i*length(x)+j)=subs(f,x,X);
            X(j)=vpa(subs(eq(j),x(x~=x(j)),X(x~=x(j))));
        end
    end
end