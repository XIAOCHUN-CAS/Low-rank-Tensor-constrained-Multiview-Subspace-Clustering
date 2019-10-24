function m = Tensor2Matrix(T,unfolding_mode,dim1,dim2,dim3)
m = [];
if(unfolding_mode==1)
    for k=1:length(T)
        m = [m,T{k}];
    end
end
if(unfolding_mode==2)
    for k=1:length(T)
        m = [m;T{k}'];
    end
end
if(unfolding_mode==3)
    for k=1:length(T)
        z{k} = reshape(T{k}',[1 dim1*dim2]);
        m = [m,z{k}'];
    end
end
end