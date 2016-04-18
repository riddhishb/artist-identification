
%% Function to extract the brushstrokes from the images

input_img = imread('download_2016-04-03 - 06-42-09/A16983.jpg');

working_patch = input_img(100:200,100:200,:);
% imshow(working_patch);

% Detecting the edges
edge_patch = edge(rgb2gray(working_patch),'canny');
imshowpair(working_patch,edge_patch,'montage')

% eroding the structure
se = strel('square',2);
edge_patch = imdilate(edge_patch,se);

% Finding the connected componenets
cc_image = bwconncomp(edge_patch);

modify_img = zeros(size(edge_patch));
for i = 1:cc_image.NumObjects
    modify_img(cc_image.PixelIdxList{i}) = 1;
end
figure;
imshowpair(edge_patch,modify_img,'montage');

