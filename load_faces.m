% function [ result, num_faces ] = load_faces( subject )
% 
%     listing = dir(['data/yale' subject '/'  '*.pgm']);
%     filenames = {listing.name};
%     num_faces = size(filenames,2);
%     result = zeros(48*42, num_faces);
% 
%     for i=1:num_faces
%         im = imread(['data/yale' subject '/' filenames{i}]);
%         im = imresize(im, [48 42]);
%         result(:,i) = reshape(im,48*42,1);
%     end
% 
% end

function [ result, num_faces ] = load_faces( subject )

    listing = dir(['/home/ljj/1code/autoSC/data/CroppedYale/yale' subject '/yale*.pgm']);
%     listing = dir(['data/CroppedYale/yale' subject '/yale' subject '_P00A*.pgm']);
    filenames = {listing.name};
    num_faces = size(filenames,2);
    result = zeros(48*42, num_faces);

    for i=1:num_faces
        im = imread(['/home/ljj/1code/autoSC/data/CroppedYale/yale' subject '/' filenames{i}]);
        im = imresize(im, [48 42]);
        result(:,i) = reshape(im,48*42,1);
    end

end