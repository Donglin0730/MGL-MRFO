%--------------------------------------------------------------------------
% MRFO code v1.0.
% Developed in MATLAB R2011b
% The code is based on the following papers.
% W. Zhao, Z. Zhang and L. Wang, Manta ray foraging optimization: An
% effective bio-inspired optimizer for engineering applications.
% Engineering Applications of Artifical Intelligence (2019),
% https://dio.org/10.1016/j.engappai.2019.103300.
% -------------------------------------------------------------------------
% FunIndex: Index of function.
% MaxIt: The maximum number of iterations.
% PopSize: The size of population.
% PopPos: The position of population.
% PopFit: The fitness of population.
% Dim: The dimensionality of prloblem.
% Alpha: The weight coefficient in chain foraging.
% Beta: The weight coefficient in cyclone foraging.
% S: The somersault factor.
% BestF: The best fitness corresponding to BestX. 
% HisBestFit: History best fitness over iterations. 
% Low: The low bound of search space.
% Up: The up bound of search space.

function [BestX,BestF,HisBestFit]=MGLMRFO(Low,Up,Dim,MaxIt,nPop,problem)

         

    for i=1:nPop  
        z=rand(1)+1;
        y=sin((0.6*(2*cos(rand(1))+1))./z);
        PopPos(i,:)=y.*rand(1,Dim).*(Up-Low)+Low;
        
        PopFit(i)=benchmark_func( PopPos(i,:),problem);  
    end
%     figure(2)
%  l=plot(PopPos(:,1),PopPos(:,2),'o');
       BestF=inf;
       BestX=[];

    for i=1:nPop
        if PopFit(i)<=BestF
           BestF=PopFit(i);
           BestX=PopPos(i,:);
        end
    end

       HisBestFit=zeros(MaxIt,1);


for It=1:MaxIt %保证相同的评估次数时，可根据需要还加一个循环，while(FE<=MAXFE)


 
%Update of the optimal solution based on the Matching game
[BestX1] = match(PopPos,PopFit,nPop);

     Coef=It/MaxIt;
     %variable spiral factor
    if It<MaxIt/2
    a=1;
    l=1-2*It/MaxIt;
    k=MaxIt/10;
   else
    l=1-2*It/MaxIt;
    a=exp(l*5);
    k=MaxIt/10;
   end
       if rand<0.5
          r1=rand;                         
          Beta=2*exp(r1*((MaxIt-It+1)/MaxIt))*(sin(2*pi*r1));    
          if  Coef>rand                                                      
              newPopPos(1,:)=BestX1+rand(1,Dim).*(BestX1-PopPos(1,:))+Beta*(BestX1-PopPos(1,:))*a*cos(k*pi*l); 
          else
              IndivRand=rand(1,Dim).*(Up-Low)+Low;                                
              newPopPos(1,:)=IndivRand+rand(1,Dim).*(IndivRand-PopPos(1,:))+Beta*(IndivRand-PopPos(1,:))*a*cos(k*pi*l);       
          end              
       else 
            Alpha=2*rand(1,Dim).*(-log(rand(1,Dim))).^0.5;           
            newPopPos(1,:)=PopPos(1,:)+rand(1,Dim).*(BestX1-PopPos(1,:))+Alpha.*(BestX1-PopPos(1,:))*a*cos(k*pi*l);
       end
     
    for i=2:nPop
        if rand<0.5
           r1=rand;                         
           Beta=2*exp(r1*((MaxIt-It+1)/MaxIt))*(sin(2*pi*r1));    
             if  Coef>rand                                                      
                 newPopPos(i,:)=BestX+rand(1,Dim).*(PopPos(i-1,:)-PopPos(i,:))+Beta*(BestX-PopPos(i,:));
             else
                 IndivRand=rand(1,Dim).*(Up-Low)+Low;                                
                 newPopPos(i,:)=IndivRand+rand(1,Dim).*(PopPos(i-1,:)-PopPos(i,:))+Beta*(IndivRand-PopPos(i,:));       
             end              
        else
            Alpha=2*rand(1,Dim).*(-log(rand(1,Dim))).^0.5;           
            newPopPos(i,:)=PopPos(i,:)+rand(1,Dim).*(PopPos(i-1,:)-PopPos(i,:))+Alpha.*(BestX-PopPos(i,:)); 
       end         
    end
         
           for i=1:nPop        
               newPopPos(i,:)=SpaceBound(newPopPos(i,:),Up,Low);
                newPopFit1(i)=benchmark_func( newPopPos(i,:),problem);  
           end
               
           for i=1:nPop 
              if newPopFit1(i)<PopFit(i)
                 PopFit(i)=newPopFit1(i);
                 PopPos(i,:)=newPopPos(i,:);
              end
           end
%      
% S=2;
%adjustment of S
S=2.4-It/MaxIt;
        for i=1:nPop           
            newPopPos(i,:)=PopPos(i,:)+S*(rand*BestX-rand*PopPos(i,:)); %Equation (8)
        end
     

      for i=1:nPop        
               newPopPos(i,:)=SpaceBound(newPopPos(i,:),Up,Low);
               newPopFit(i)=benchmark_func( newPopPos(i,:),problem);  
      end
                
           for i=1:nPop 
              if newPopFit(i)<PopFit(i)
                 PopFit(i)=newPopFit(i);
                 PopPos(i,:)=newPopPos(i,:);
              end
           end
     
     for i=1:nPop
        if PopFit(i)<BestF
           BestF=PopFit(i);
           BestX=PopPos(i,:);            
        end
     end
%  Progressive learning
  [newPopPos] = Progressive(PopPos,newPopFit,newPopFit1,nPop,problem);
     HisBestFit(It)=BestF;
end
end
% figure(2)
%  l=scatter(PopPos(:,1),PopPos(:,2),'o');

