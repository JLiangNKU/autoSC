


function [clu,Tri_rest] = Cluster(Tri_all,Tri_1,seri)
% Tri_all=Tri_final;


% [Tri_1,seri] = find_First_Tri(Tri_all);

clu=Tri_1;
Tri_rest=Tri_all;
Tri_rest(seri,:)=[];

Row_seri_com=[1];
while Row_seri_com
    [clu,Tri_rest,Row_seri_com] = combine_Two_same(clu,Tri_rest);
end

[clu_one1,Tri_One_rest1,t_one] = combine_One_same(clu,Tri_rest,Tri_all);

clu=clu_one1;
Tri_rest=Tri_One_rest1;





