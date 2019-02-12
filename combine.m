
function CLU_new = combine(CLU,Tri_all)
% clear
% load test1.mat;
% Tri_all=Tri_final;


kk=0;
% iii=0;
while size(CLU,2)>=kk+1
    
    CLU_save=CLU;
    clear Siz Siz_inter;

    for i=1:size(CLU,2)
        Siz(i)=size(CLU{i},1);
    end
    [~,Sorts]=sort(Siz);
    
    A=1:size(CLU,2);
    A(A==Sorts(kk+1))=[];
    clu_current=CLU{Sorts(kk+1)};
    
    AAA=[];
    for j=1:size(clu_current,1)
        AA = mod(find(Tri_all==clu_current(j)),size(Tri_all,1));
        AA(AA==0)=size(Tri_all,1);
        AAA=[AAA;AA];
        AAA=unique(AAA);
    end
    
    BB=Tri_all(AAA,:);
    BB=unique(BB(:));
    CCC=[];
    for j=1:size(BB,1)
        CC = mod(find(Tri_all==BB(j)),size(Tri_all,1));
        CC(CC==0)=size(Tri_all,1);
        CCC=[CCC;CC];
        CCC=unique(CCC);
    end
    DD=Tri_all(CCC,:);
    DD=DD(:);
%     DD=unique(DD(:));
    
    for j=1:size(CLU,2)-1
        clu_other=CLU{A(j)};
        Inter=intersect(clu_other,DD);
        Siz_inter(j)=size(Inter,1);
    end
    
    [max_inter,posi]=max(Siz_inter);
    
    if max_inter>=10%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        CLU{1}=[CLU{A(posi)};clu_current];
        bb=1:size(CLU,2);
        bb(bb==A(posi))=[];
        bb(bb==Sorts(kk+1))=[];
        k=1;
        
        for j=2:size(CLU,2)-1
            CLU{j}=CLU_save{bb(k)};
            k=k+1;
        end
        CLU(size(CLU,2))=[];
    else
        kk=kk+1;
    end
    if size(CLU,2)==1
        break;
    end
end   
        
CLU_new=CLU;
        
    
