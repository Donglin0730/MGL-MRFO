
function [x] = Progressive(x,fit,fit1,pop,problem)
%JINBUXUEXI 此处显示有关此函数的摘要
%   此处显示详细说明
[a,qq]=sort(fit);
[c,oo]=sort(fit1);
for i=1:pop
    aa=find(a==fit(i));% Find the ranking of individual i in fit
 bb=find(c==fit1(i));% Find the ranking of individual i in lastfit
  if (aa>bb)
      q=find(fit==a(bb(1)));% Find out who is ranked as bb.Here b(1) is chosen as only one, as the fitness values may be the same and the rankings the same.
      zz=x(i,:)+x(q(1),:).*rand(1).*exp(-(aa(1)-bb(1)));%Update according to the equation
  
      if (benchmark_func( zz,problem)<benchmark_func( x(i,:),problem))
            x(i,:)=zz;
      end
  end
end
end


