function f = benchmark_func(x, func_num)
fhd=str2func('cec22_test_func');
f=feval(fhd,x',func_num)';
%% 计算与最优值的误差
optimums=[300,400,600,800,900,1800,2000,2200 2300 2400 2600 2700];
[m,~]=size(f);
for i=1:m
    f(i,:)=f(i,:)-optimums(func_num);
end
end