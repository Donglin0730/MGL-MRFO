clc;
clear all;
tic;

%ע�����㷨�Ľṹ��ͬ����Ҫͳһ�������������Ҳ����˵��ͬ���㷨������������������ͬ��
problemSet = [1:12];
qq=1;
eval('load input_data/Rand_Seeds.txt');
for problemIndex = 1:12

    problem = problemSet(problemIndex);
Low=-100;Up=100;Dim=10;
nPop=50;
MaxIt=1000;%����������
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
        fprintf('����%d���%d�� ��� %d\n',problem,time,min(HisBestFit));
      ak(time,:)= HisBestFit;
      aa(problemIndex,time)=BestF;%��ֵ���

shuju(time)=BestF; 
        time = time + 1;
    end 
   Final_results(problemIndex,:)= [min(shuju),max(shuju),median(shuju), mean(shuju),std(shuju)];%ָ��
bb(problemIndex,:)=mean(ak);%ƽ������     
end
% save('code10.mat','code10')
toc;