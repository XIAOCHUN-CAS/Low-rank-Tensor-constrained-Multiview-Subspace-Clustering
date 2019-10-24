function [my_tensor] = updateG_unfold(W,K,sX,mu,gamma,M,V)
 K_tensor = cat(3, K{:,:});
 W_tensor = cat(3, W{:,:});
 k = K_tensor(:);
 w = W_tensor(:);
%  
%  a = k+w/mu;
%  A_tensor = reshape(a, sX);
%  for m=1:M
%      if m<=2
%      X = reshape(A_tensor,[360*360,3]);
%      K_unfold = softth(X,gamma{m}/mu);
%      end
%  end
 
for m=1:1
        %5 update Gm
        W_mat = Tensor2Matrix(W,m,sX(1),sX(2),sX(3));
        K_mat = Tensor2Matrix(K,m,sX(1),sX(2),sX(3));
        if m==1
           K_mat = K_mat+(1/mu*W_mat);
        end
         K_mat = softth(K_mat,gamma{m}/mu);
         
         vec = Matrix2Vector(K_mat,m,sX(1),sX(2),sX(3),V);
         Kmat = Vector2Tensor(vec,sX(1),sX(2),sX(3),V);
end
vec = Tensor2Vector(Kmat,sX(1),sX(2),sX(3),V);
my_tensor = reshape(vec,sX);
%%%%%%%%%%%%%%%%%%%%%%%%%%%

