
function [clu1,Tri_rest1,Row_seri_com] = combine_Two_same(clu,Tri_rest)

Row_seri_com=[];
Row=[];
for i=1:size(clu,1)%3
    AA = mod(find(Tri_rest==clu(i)),size(Tri_rest,1));
    AA(AA==0)=size(Tri_rest,1);
    BB=Tri_rest(AA,:);
    clu_temp=clu; clu_temp(clu_temp==clu(i))=[];
    
    for j=1:size(clu_temp,2)%2
        row_seri = mod(find(BB==clu_temp(j)),size(BB,1));
        row_seri(row_seri==0)=[];
        Row=[Row;AA(row_seri)];
        to_combine=BB(row_seri,:);
        to_combine=unique(to_combine(:));
        clu=[clu(:);to_combine];
        clu=unique(clu);
    end
    Row_seri_com=[Row_seri_com;Row];
    Row_seri_com=unique(Row_seri_com);
end
clu1=sort(clu);
Tri_rest(Row_seri_com,:)=[];
Tri_rest1=Tri_rest;