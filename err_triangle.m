
function err = err_triangle(Tri_final,groundtruth)
sum_error=0;

for i=1:size(Tri_final,1)
    num_error=0;
    lable_first = groundtruth(Tri_final(i,1));
    lable_second = groundtruth(Tri_final(i,2));
    lable_third = groundtruth(Tri_final(i,3));
    
%     if (lable_second == lable_first) && (lable_third ~= lable_first)
%         num_error=num_error+1;
%     end
    if (lable_second ~= lable_first) && (lable_third == lable_first)
        num_error=num_error+0.5;
    end
    if (lable_second ~= lable_first) && (lable_third ~= lable_first) && (lable_third ~= lable_second)
        num_error=num_error+1;
    end
    if (lable_second ~= lable_first) && (lable_third ~= lable_first) && (lable_third == lable_second)
        num_error=num_error+0.5;
    end
    sum_error=sum_error+0.5*(3-num_error);          
end

% acc = 1-(num_error/(3*size(Tri_final,1)));
err =  1/size(Tri_final,1)*sum_error;