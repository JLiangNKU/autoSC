%% demo for motion segmentation
% released on 14/06/12
% author: Han Hu (ancientmooner@gmail.com)

warning off all
data_dir = './data/hopkins155';
addpath(genpath(data_dir));

% Hopkins 155 datasets

exp_name = 'MotionSegmentation';

NumOfVideos = [78,31,11,26,7,2];
Total2Num = sum(NumOfVideos(1:3));
Total3Num = sum(NumOfVideos(4:6));
TotalNumber = sum(NumOfVideos);
ngroups_all = [2*ones(1,120) 3*ones(1,35)];

fid = fopen('total.txt','r');
startN=0;
for i=1:startN
    name =fgetl(fid);   % get the data set name
end

for i=startN+1:TotalNumber
    ngroups = ngroups_all(i);
    sequencename =fgetl(fid);
    fullpath = sprintf('%s/%s',sequencename,sequencename);
    eval(['load ' fullpath '_truth.mat']);
    % read data
    gnd = s;
    [~, N, F] = size(x);
    Xp = reshape(permute(x(1:2,:,:),[1 3 2]),2*F,N);    
    dim =12;
    [ eigvector , eigvalue ] = PCA( Xp );
    ProjX = eigvector(:,1:min(dim,length(eigvalue)))' * Xp ; 
    data = [ProjX ; ones(1,size(ProjX,2))] ;
    para.alpha = 20;
    para.knn = 4;
    para.gamma = 1;
    para.elpson =0.01;
    para.aff_type = 'J2';
    W = smr(data,para);
    [groups] = clu_ncut(W,ngroups);
    ce_all(i) = compacc_ce(groups,gnd);
    fprintf(1,'the %d th dataset, error = %.4f\n',...
                    i,ce_all(i));
end

