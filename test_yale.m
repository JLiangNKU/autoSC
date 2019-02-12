clear;
addpath(genpath('./Smooth Representation Clustering'));

load pick_3_5_8_10_15_20_25_30_35.mat;
picked=[picked_3,picked_5,picked_10,picked_15,picked_30];
idx=find(picked==14);
picked(idx)=39;

howmuch=64;
num_clusters=[3,5,10,15,30];
num_closer=8;
num_judge=20;
temp=0;

for i=1:5
%     bbb=0;
    nCluster=num_clusters(i);

%     nCluster=38;
%     for j=1:size(picked_3,1)%1:50
      for j=1:5%1:50
%         picked=[1:3];
        for k=1:nCluster%3,5,10
%         for k=1:38 %3,5,10
%             X(:,howmuch*(k-1)+1:howmuch*k)=dataset(:,num_everycla*(picked(j,temp+k)-1)+1:num_everycla*(picked(j,temp+k)-1)+howmuch);
%             X(:,howmuch*(k-1)+1:howmuch*k)=dataset(:,num_everycla*(picked(k)-1)+1:num_everycla*(picked(k)-1)+howmuch);
            X(:,64*(k-1)+1:64*k)=load_faces(strcat('B',num2str(picked(j,temp+k),'%6.2d')));
        end
        X = X/255;
        
        j
        i
        
%         [Z] = demo_smr(X,nCluster,64);
%         t1=clock;
%         [S_weight,S_number]=choose_value11(Z,num_closer,num_judge);
        
        Z = NSN(X,8,8,1e-4);
        S_number = [];
        for ii = 1:size(Z,1)
            tem = find(Z(:,ii)==1);
            S_number(ii,1:8) = tem(1:8);
        end
        
        
        [Tri_final]=get_Triangle(S_number,6);
        
        groundtruth=[];
        
        for kk=1:nCluster
            groundtruth1=kk*ones(1,64);
            groundtruth=[groundtruth,groundtruth1];
        end

        acc_tri = err_triangle(Tri_final,groundtruth);
        acc_tri_all(i,j)=acc_tri;


        Tri_rest=Tri_final;
        clu_now=[];
        Num_esti=0;
        while true
            [Tri_1,seri] = find_First_Tri(Tri_rest);
            m=0;
            for ii=1:3 
                s_first= Score(clu_now, Tri_1(ii), Tri_rest);
                if s_first(1)> 10 
                    m=m+1;
                end
            end
            if m>1
                hhh(i,j)=0;
                break;
            end
            [clu,Tri_rest] = Cluster(Tri_rest,Tri_1,seri);
            try
                [clu,Tri_rest] = Cluster(Tri_rest,Tri_1,seri);
                Num_esti=Num_esti+1;
                CLU{Num_esti}=clu;
                clu_now=[clu_now;clu];
                clu_now=unique(clu_now);
            catch
                hhh(i,j)=1;
                break;
            end
        end
        
        %estimate the number or clusters
        Num_estis_before_combine(i,j)=Num_esti;
        CLU = combine(CLU,Tri_final);
        Num_estiss(i,j)=size(CLU,2);

        %fuse the rest samples into clusters
        CLU = fusion_rest(nCluster,clu_now,Num_estiss(i,j),CLU,Tri_final);

        Label=[];
        for ii=1:Num_estiss(i,j)
            Label(CLU{ii},ii)=ii;
        end
        label=max(Label,[],2);

        ACC = compacc(label,groundtruth')
        NMI = MutualInfo(label,groundtruth')
        RI = compare_segmentations(label, groundtruth')
%         t_Esti=etime(clock,t1);

        ACCs(i,j)=ACC;
        NMIs(i,j)=NMI;
        RIs(i,j)=RI;
%         tt_all(i,j)=t_Esti;
        clear X s;
   
    end
    temp=temp+num_clusters(i);
end
