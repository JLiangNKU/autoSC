function CLU = fusion_rest(nCluster,clu_now,k,CLU,Tri_final)

sample_rest=1:nCluster*64;
for ii=1:size(clu_now,1)
    sample_rest(sample_rest==clu_now(ii))=[];
end

for ii=1:size(sample_rest,2)
    for jj=1:k
        s(jj,:)= Score(CLU{jj}, sample_rest(ii), Tri_final);
    end
   
    scores=s(:,1);
    [~,posi]=max(scores);
    CLU{posi}=[CLU{posi};sample_rest(ii)];
%     if max(s)==0
%         bbb=bbb+1;
%     end
end