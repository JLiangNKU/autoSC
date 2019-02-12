
function [Tri_1,seri,t_first_tri] = find_First_Tri(Tri_final)
%O(N)
% Tri_final=Tri_rest;
tic;

[num_row,num_col]=size(Tri_final);


Frequency=tabulate(Tri_final(:));
[~,max_1]=max(Frequency(:,2));


A = find(Tri_final==max_1);
A=mod(A,num_row);
A(A==0)=num_row;


BB=Tri_final(A,:);
B=BB(:);B=unique(B);B(B==max_1)=[];


[~,max_2_tem]=max(Frequency(B,2));
max_2=B(max_2_tem);


num_row_BB=size(BB,1);
Tri_1_seri = mod(find(BB==max_2),num_row_BB);
Tri_1_seri(Tri_1_seri==0)=num_row_BB;
Tri_1 = BB(Tri_1_seri(1),:);

seri=A(Tri_1_seri(1));
t_first_tri=toc;