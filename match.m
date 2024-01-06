function [best] = match(PopPos,PopFit,nPop)
%LIANLIANKAN 此处显示有关此函数的摘要
%   此处显示详细说明
fit=PopFit;
e=0.00001;
[a,b]=max(PopFit);
worst=PopPos(b,:);

for i=1:nPop
    h=0;
    for j=2:nPop
        q=fit(i)-PopFit(j);
      if (q<=e & i~=j &i<j)
          
       if (fit(i)~=inf)
 
            A(j)=inf;
% B(j)=inf;
                h=h+1;
       end 
        if  (mod(h,2)==1)
        fit(i)=inf;
         end  
      end
    
    end
    
end
% for 
[ccc,hh]=min(fit);
best=PopPos(hh,:);


end

