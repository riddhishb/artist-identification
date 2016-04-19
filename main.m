addpath('edison');
addpath('artist_data');
addpath('edge_maps');
addpath('edge_link');

tic;
%% detecting edges using EDISON edge detect
edges = detect_edges('artist_data/A16983.ppm');
% imshow(edges);
edges = im2double(edges(1:50,1:50));
%% Edge Refinement
% 1. Edge Linking 
[edgelist, labelededgeim] = edgelink(edges, 10);
modify_img = zeros(size(edges));
for i = 1:length(edgelist)
    modify_img(edgelist{i}(1),edgelist{i}(2)) = 1;
end
figure ;
imshowpair(edges, modify_img,'montage');
toc;