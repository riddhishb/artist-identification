
%% Function to extract the brushstrokes from the images

input_img = imread('artist_data/A16983.jpg');

% reading the edison edge map for the image
edge_map = imread('edgemap.pgm');

working_patch = input_img(100:200,100:200,:);
edge_patch = edge_map(100:200,100:200,:);
% % imshow(working_patch);

% Detecting the edges
% edge_patch = edge(rgb2gray(working_patch),'canny');
imshowpair(working_patch,edge_patch,'montage')

% Finding the connected componenets
cc_image = bwconncomp(edge_patch);

modify_img = zeros(size(edge_patch));
for i = 1:cc_image.NumObjects
    modify_img(cc_image.PixelIdxList{i}) = 1;
end
figure;
imshowpair(edge_patch,modify_img,'montage');

