clear
load('ORL_mtv.mat');
num_views = length(X);
for v=1:num_views
   X{v} = X{v}./(repmat(sqrt(sum(X{v}.^2,1)),size(X{v},1),1)+10e-10);
end

t1=cputime;
lambda = 0.1;
[acc,nmi,f,ri] = lt_msc(X, gt, lambda);
t2=cputime-t1;