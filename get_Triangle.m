function [Tri_final,Triangles,TEMP]=get_Triangle(S,num)
% 
% S=S_number;
% num=5;

Triangles = [];
TEMP = [];
for i = 1:size(S,1)
    Loop = S(i,:);
    Loop(Loop==i) = [];
    for j=1:size(Loop,2)
        S1(i,j)=Loop(j);
    end
end

S=S1(:,1:size(S,2)-1);

clear i j;
for i = 1:size(S,1)
    Loop1 = S(i,:);
    Loop1(Loop1==0)=[];
    for j = 1:size(Loop1,2)
        Loop2 = S(Loop1(j),:);
        Loop2(Loop2==0)=[];
        for k = 1:size(Loop2,2)
            if find((S(Loop2(k),:))==i)
                Triangles(i,j) = Loop1(j);
                TEMP(i,j) = Loop2(k);
                break;
            end
            
        end
        if k==size(Loop2,2)
            break;
        end
        A=find(TEMP(i,:)~=0);
        if size(A,2)==num
            break;
        end
    end
end

Triangles=Triangles(:,1:num);
TEMP=TEMP(:,1:num);

Label=[];
for i=1:size(S,1)
    label=i.*ones(num,1);
    Label=[Label;label];
end

Tri2=Triangles';
Tri2=Tri2(:);
Tri3=TEMP';
Tri3=Tri3(:);
l1=size(Tri2,1);
l2=size(Label,1);
if l1~=l2
    Label=Label(1:l1,:);
end
Tri_final=[Label,Tri2,Tri3];

Zero=find(Tri_final(:,2)==0);
Tri_final(Zero,:)=[];

