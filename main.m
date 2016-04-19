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


%% Finding the Connected Components
cc_image = bwconncomp(modify_img);
majorlen = regionprops(cc_image,'MajorAxisLength');
minorlen = regionprops(cc_image,'MinorAxisLength');
area     = regionprops(cc_image,'Area');
majorlen = cat(1,majorlen.MajorAxisLength);
minorlen = cat(1,minorlen.MinorAxisLength);
area     = cat(1,area.Area);

props_conn_comps = zeros(cc_image.NumObjects,6);

props_conn_comps(:,1) = majorlen;
props_conn_comps(:,2) = minorlen;
props_conn_comps(:,3) = area;
props_conn_comps(:,4) = minorlen./majorlen;
props_conn_comps(:,5) = area./(2.*majorlen.*minorlen);
props_conn_comps(:,6) = transpose(linspace(1,cc_image.NumObjects,cc_image.NumObjects));

%% Classifying the components into brushstrokes
toc;