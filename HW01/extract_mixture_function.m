function [A_star]=extract_mixture_function(X,Sections)
    X1=X(1,:);
    X2=X(2,:);
    X_border=zeros(2,Sections);

    steps1=(max(X1)-min(X1))/Sections;
    steps2=(max(X2)-min(X2))/Sections;
    for s=1:Sections
        filtered_X=X( :,(s-1)*steps2+min(X2) <= X2 & X2 < (s*steps2+min(X2)));
        [~,i]=min( filtered_X(1,:) );
        if(~isnan(filtered_X(:,i)))
            X_border(:,s)=filtered_X(:,i);
        end
    end

    % for i=2:Sections-1
    %     set1=X_border(:,1:i)-mean(X_border(:,1:i),2);
    %     set2=X_border(:,i:Sections)-mean(X_border(:,i:Sections),2);
    %     scatter(set1(1,:),set1(2,:));
    %     slope(1,i-1)=dot(set1(1,:),set1(2,:))/dot(set1(1,:),set1(1,:));
    %     slope(2,i-1)=dot(set2(1,:),set2(2,:))/dot(set2(1,:),set2(1,:));
    %     slope(3,i-1)=abs(slope(1,i-1)-slope(2,i-1));
    % end

    [~,i]=min(X_border(1,:));

    set1=X_border(:,i:Sections);
    set2=X_border(:,1:i);
    hold on
    scatter(set1(1,:),set1(2,:));
    scatter(set2(1,:),set2(2,:));
    
    set1=X_border(:,i:Sections)-mean(X_border(:,i:Sections),2);
    set2=X_border(:,1:i)-mean(X_border(:,1:i),2);
    sloop1=dot(set1(1,:),set1(2,:))/dot(set1(1,:),set1(1,:));
    sloop2=dot(set2(1,:),set2(2,:))/dot(set2(1,:),set2(1,:));

    a1=[1;sloop1]*0.6;
    a2=[1;sloop2]*0.8;
    A_star=[a1 a2];
end