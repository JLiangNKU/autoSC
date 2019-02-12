
function [clu_one1,Tri_One_rest1,tt] = combine_One_same(clu,Tri_rest,Tri_all)


tic;
min_score=3;
for i=1:size(clu,1)%3
    
    AA = mod(find(Tri_rest==clu(i)),size(Tri_rest,1));
    AA(AA==0)=size(Tri_rest,1);
    BB=Tri_rest(AA,:);

    for j=1:size(BB,1)
        bb = BB(j,:);
        bb(bb==clu(i))=[];
        score = Score(clu,bb,Tri_all);
        
        if score(1)>min_score
%             A = mod(find(Tri_rest==bb(1)),size(Tri_rest,1));
%             A(A==0)=size(Tri_rest,1);
%             A=unique(A);
            
            clu=unique([clu(:);bb(1)]); 
%             Tri_rest(A,:)=[];
            Tri_rest(AA(j),:)=[];
        end
       
        if score(2)>min_score
            clu=unique([clu(:);bb(2)]);
            Tri_rest(AA(j),:)=[];
        end
        
    end
end

clu_one1=clu;
Tri_One_rest1=Tri_rest;
tt=toc;