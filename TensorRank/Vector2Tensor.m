function t = Vector2Tensor(v,dim1,dim2,dim3,K)
% v (input) is the vectorization of tensor t (output, 3-way:dim1,dim2,dim3) 
% according the  undfolding_mode (input)
%

    L =size(v,1)/K;
    for k=1:K
        T{k} =  reshape(v((k-1)*L+1:k*L),[dim1,dim2]);
        t{k} = T{k};
    end
    
%     M = reshape(v,[dim1 dim2*dim3]);
%     M = M';
%     
%     for k=1:K
%         T{k} =  M((k-1)*dim1+1:k*dim1,1:dim1)';
%         t{k} = T{k};
%     end
    
    
    
    %     T{1} =  M(1:dim1,1:dim1)';
%     T{2} =  M(dim1+1:dim1*2,1:dim1)';
%     t{1} = T{1};
%     t{2} = T{2};
%     if(unfolding_mode==1)
%          M = reshape(v,[dim2*dim3 dim1]);
%          T{1} =  M(1:dim1,1:dim1);
%          T{2} =  M(dim1+1:dim1*2,1:dim1);
%     end
%     if(unfolding_mode==2)
%          M = reshape(v,[dim1*dim3 dim2]);
%          T{1} =  M(1:dim1,1:dim1)';
%          T{2} =  M(dim1+1:dim1*2,1:dim1)';
%     end
%     if(unfolding_mode==3)
%          M = reshape(v,[dim1*dim2 dim3]);
%          z1 = M(:,1);
%          z2 = M(:,2);
%          T{1} =  reshape(z1,[dim1 dim2]);
%          T{2} =  reshape(z2,[dim1 dim2]);
%     end
%     t{1} = T{1};
%     t{2} = T{2};
end

