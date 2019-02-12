function score = Score (clu, to_Dicide, Tri_all)

score=[0,0,0];
tic;
for i=1:size(to_Dicide,2)
%     for j=1:size(clu,1)
%         for k=1:size(Tri_all,1)

        AA = mod(find(Tri_all==to_Dicide(i)),size(Tri_all,1));
        AA(AA==0)=size(Tri_all,1);
        AA=unique(AA);
        AAs=Tri_all(AA,:);
        AAs=AAs(:);
        AAs=unique(AAs);
        
        AAAs=[];
        for k=1:size(AAs,1)
            AAA = mod(find(Tri_all==AAs(k)),size(Tri_all,1));
            AAA(AAA==0)=size(Tri_all,1);
            AAAs=[AAAs;AAA];
            AAAs=unique(AAAs);
        end
        AAAs=AAAs(:);
        
        BB=Tri_all(AAAs,:);
        BB=BB(:);
        
        Inter=intersect(clu,BB);
        
        score(i)=0;
        if size(Inter,1)~=0
            for j=1:size(Inter,1)
                m=size(find(BB==Inter(j)),1);
                score(i)=score(i)+m;
            end
        end
            
end%i
t=toc;
