function v = Tensor2Vector(T,dim1,dim2,dim3,K)
v = []; 
for k=1:K
    vv{k} = reshape(T{k},[dim1*dim2 1]);
    v = [v;vv{k}];
end

% v1 = reshape(T{1},[dim1*dim2 1]);
% v2 = reshape(T{2},[dim1*dim2 1]);
% v = [v1;v2];


% if(unfolding_mode==1)
%     z = [T{1};T{2}];
%     v = reshape(z',[1 dim1*dim2*dim3]);
% end
% if(unfolding_mode==2)
%     z = [T{1}';T{2}'];
%     v = reshape(z',[1 dim1*dim2*dim3]);
% end
% if(unfolding_mode==3)
%     z1 = reshape(T{1}',[1 dim1*dim2]);
%     z2 = reshape(T{2}',[1 dim1*dim2]);
%     v = [z1',z2'];
%     v = reshape(v',[1 dim1*dim2*dim3]);
% end
% v = v';
end