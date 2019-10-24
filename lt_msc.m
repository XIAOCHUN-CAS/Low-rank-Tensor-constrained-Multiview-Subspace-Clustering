function [acc,nmi,f,ri] = lt_msc(X, gt, lambda)
V = length(X);
cls_num = length(unique(gt));
%% Note: each column is an sample (same as in LRR)
%% 
K = length(X); N = size(X{1},2); %sample number

for k=1:K
    Z{k} = zeros(N,N); %Z{2} = zeros(N,N);
    W{k} = zeros(N,N);
    G{k} = zeros(N,N);
    E{k} = zeros(size(X{k},1),N); %E{2} = zeros(size(X{k},1),N);
    Y{k} = zeros(size(X{k},1),N); %Y{2} = zeros(size(X{k},1),N);
end

w = zeros(N*N*K,1);
g = zeros(N*N*K,1);
dim1 = N;dim2 = N;dim3 = K;
myNorm = 'tSVD_1';
sX = [N, N, K];
%set Default
parOP         =    false;
ABSTOL        =    1e-6;
RELTOL        =    1e-4;


Isconverg = 0;epson = 1e-7;
ModCount = 3; %unfold_mode_number
for v=1:ModCount
    para_ten{v} = lambda;
end
iter = 0;
mu = 10e-5; max_mu = 10e10; pho_mu = 2;
rho = 10e-5; max_rho = 10e12; pho_rho = 2;
tic;

Z_tensor = cat(3, Z{:,:});
G_tensor = cat(3, G{:,:});
W_tensor = cat(3, W{:,:});

for i=1:ModCount
    WT{i} = W_tensor;
end
while(Isconverg == 0)
    fprintf('----processing iter %d--------\n', iter+1);
    for k=1:K
        %1 update Z^k
        
        %Z{k}=inv(eye(N,N)+X{k}'*X{k})*(X{k}'*X{k} - X{k}'*E{k}+ F3_inv(G_bar){k}
        %                               + (X{k}'*Y{k} - W{k})/\mu);
        tmp = (X{k}'*Y{k} + mu*X{k}'*X{k} - mu*X{k}'*E{k} - W{k})./rho +  G{k};
        Z{k}=inv(eye(N,N)+ (mu/rho)*X{k}'*X{k})*tmp;
        
        %2 update E^k
         F = [];
        for v=1:K
             F = [F;X{v}-X{v}*Z{v}+Y{v}/mu];
        end
        %F = [X{1}-X{1}*Z{1}+Y{1}/mu;X{2}-X{2}*Z{2}+Y{2}/mu;X{3}-X{3}*Z{3}+Y{3}/mu];
        [Econcat] = solve_l1l2(F,lambda/mu);
        
        beg_ind = 0;
        end_ind = 0;
        for v=1:K
            if(v>1)
                beg_ind = beg_ind+size(X{v-1},1);
            else
                beg_ind = 1;
            end
            end_ind = end_ind+size(X{v},1);
            E{v} = Econcat(beg_ind:end_ind,:);
        end
        %3 update Yk
        %Y{k} = Y{k} + mu*(X{k}-X{k}*Z{k}-E{k});
        Y{k} = Y{k} + mu*(X{k}-X{k}*Z{k}-E{k});
    end
    
    %4 update G
    Z_tensor = cat(3, Z{:,:});
    W_tensor = cat(3, W{:,:});
    z = Z_tensor(:);
    w = W_tensor(:);
%     %twist-version
%    [g, objV] = wshrinkObj(z + 1/rho*w,1/rho,sX,0,3) ;
%     G_tensor = reshape(g, sX);  
%     %5 update W
%     w = w + rho*(z - g);

    for umod=1:ModCount
        G_tensor = updateG_tensor(WT{umod},Z,sX,mu,para_ten,V,umod);
        WT{umod} = WT{umod}+mu*(Z_tensor-G_tensor);
    end
    
%     %record the iteration information
%     history.objval(iter+1)   =  objV;
% objVal(iter+1) = objV;
    %% coverge condition
    Isconverg = 1;
    for k=1:K
        if (norm(X{k}-X{k}*Z{k}-E{k},inf)>epson)
            history.norm_Z = norm(X{k}-X{k}*Z{k}-E{k},inf);
           % fprintf('    norm_Z %7.10f    ', history.norm_Z);
            Isconverg = 0;
        end
        
        G{k} = G_tensor(:,:,k);
        W_tensor = cat(3, WT{:,:});
        W{k} = W_tensor(:,:,k);
        if (norm(Z{k}-G{k},inf)>epson)
            history.norm_Z_G = norm(Z{k}-G{k},inf);
            %fprintf('norm_Z_G %7.10f    \n', history.norm_Z_G);
            Isconverg = 0;
        end
    end
   
    if (iter>50)
        Isconverg  = 1;
    end
    iter = iter + 1;
    mu = min(mu*pho_mu, max_mu);
    rho = min(rho*pho_rho, max_rho);
end
S = 0;
for k=1:K
    S = S + abs(Z{k})+abs(Z{k}');
end
% figure(1); imagesc(S);
% S_bar = CLR(S, cls_num, 0, 0 );
% figure(2); imagesc(S_bar);
C = SpectralClustering(S,cls_num);
[A nmi avgent] = compute_nmi(gt,C);
%C = SpectralClustering(abs(Z{1})+abs(Z{1}'),cls_num);
%[A nmi avgent] = compute_nmi(gt,C)
% C = SpectralClustering(abs(Z{2})+abs(Z{2}'),cls_num);
% [A nmi avgent] = compute_nmi(gt,C)
% C = SpectralClustering(abs(Z{3})+abs(Z{3}'),cls_num);
 [A nmi avgent] = compute_nmi(gt,C);
acc = Accuracy(C,double(gt));
[f,p,r] = compute_f(gt,C);
[ar,ri,MI,HI]=RandIndex(gt,C);
toc;
%save('my_new_COIL20MV_res.mat','S','ACC','nmi','AR','f','p','r');




