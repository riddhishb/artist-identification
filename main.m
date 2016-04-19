close all; clear all; clc;

addpath('edison');
addpath('artist_data');
addpath('edge_maps');
addpath('edge_link');

tic;
%% detecting edges using EDISON edge detect
edges = detect_edges('artist_data/A16983.ppm');
% imshow(edges);
% edges = im2double(edges);
edges = im2double(edges(1:50,1:50));

%% Edge Refinement
% 1. Edge Linking 
[edgelist, labelededgeim] = edgelink(edges, 10);
modify_img = zeros(size(edges));
for i = 1:length(edgelist)
    for j = 1:size(edgelist{i},1)
        modify_img(edgelist{i}(j,1),edgelist{i}(j,2)) = 1;
    end    
end
figure ;
imshowpair(edges, modify_img,'montage','scaling','none');
figure ;
imshow(abs(edges - modify_img));
toc;