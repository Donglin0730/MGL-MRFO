clc;
clear all;
tic;

%注：各算法的结构不同，需要统一最大评估次数，也就是说不同的算法，最大迭代次数有所不同。
problemSet = [1:12];
qq=1;
eval('load input_data/Rand_Seeds.txt');
for problemIndex = 1:12

    problem = problemSet(problemIndex);
Low=-100;Up=100;Dim=10;
nPop=50;
MaxIt=1000;%最大迭代次数
    % Define the dimension of the problem
    n = 10;problem_size=n;
    
    lu = [-100 * ones(1, problem_size); 100 * ones(1, problem_size)];
    % Record the best results
    outcome = [];
    % Main body
    popsize = 50;
    time = 1;
    
    % The total number of runs
    totalTime = 30;
    while time <= totalTime
       [BestX,BestF,HisBestFit]=MGLMRFO(Low,Up,Dim,MaxIt,nPop,problem);
% 
        fprintf('函数%d第%d次 结果 %d\n',problem,time,min(HisBestFit));
      ak(time,:)= HisBestFit;
      aa(problemIndex,time)=BestF;%数值情况

shuju(time)=BestF; 
        time = time + 1;
    end 
   Final_results(problemIndex,:)= [min(shuju),max(shuju),median(shuju), mean(shuju),std(shuju)];%指标
bb(problemIndex,:)=mean(ak);%平均收敛     
end
% save('code10.mat','code10')
toc;