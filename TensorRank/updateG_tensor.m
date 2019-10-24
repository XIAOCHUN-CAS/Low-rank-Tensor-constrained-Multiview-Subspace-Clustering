function [my_tensor] = updateG_tensor(WT,K,sX,mu,gamma,V,mode)
%mode = 3;
for v=1:V
    W{v} = WT(:,:,v);
end

w = Tensor2Vector(W,sX(1),sX(2),sX(3),V);
k = Tensor2Vector(K,sX(1),sX(2),sX(3),V);
wk = k+w/mu;
WKten = Vector2Tensor(wk,sX(1),sX(2),sX(3),V);

WK = Tensor2Matrix(WKten,mode,sX(1),sX(2),sX(3));
WK1 = softth(WK,gamma{mode}/mu);
my_tensor = reshape(WK1,sX);

% %----------DEBUG------------%
% kk = reshape(WK,[1,360*360*3])';
% for v=1:V
%     TMP{v} = my_tensor(:,:,v);
% end
% a = 1;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%

