function v = Matrix2Vector(M,unfolding_mode,dim1,dim2,dim3,K)
v = [];
if(unfolding_mode==1)
     M = M';
     v = reshape(M,[dim1*dim2*dim3 1]);
end
 if(unfolding_mode==2)
     for k=1:K
          T{k} =  M((k-1)*dim1+1:k*dim1,1:dim1)';
          vv{k} = reshape(T{k},[dim1*dim2 1]);
          v = [v;vv{k}];
     end
%      M1 = M(1:dim1,:);
%      M2 = M(dim1+1:2*dim2,:);
%      v1 = reshape(M1,[dim1*dim2 1]);
%      v2 = reshape(M2,[dim1*dim2 1]);
%      v = [v1;v2];
 end
  if(unfolding_mode==3)
     v = reshape(M,[dim1*dim2*dim3 1]);
 end
end