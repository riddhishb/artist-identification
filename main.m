close all; clear all; clc;

addpath('edison');
addpath('artist_data');
addpath('edge_maps');
addpath('edge_link');

tic;
%% detecting edges using EDISON edge detect
edges = detect_edges('artist_data/A16983.ppm');
% imshow(edges);
edges = im2double(edges);
% edges = im2double(edges(1:50,1:50));

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
props_conn_comps(:,5) = area./(majorlen.*minorlen);
props_conn_comps(:,6) = transpose(linspace(1,cc_image.NumObjects,cc_image.NumObjects));
props_conn_comps(:,7) = zeros(cc_image.NumObjects,1);  % labels which represent brushtroke 
% or not, 1= brushstroke correctly classified 

%% Classifying the components into brushstrokes
for i=1:cc_image.NumObjects
    if(props_conn_comps(i,4) >0.05 && props_conn_comps(i,5) > 0.1 && props_conn_comps(i,5)<2 )
        props_conn_comps(i,7) = 1;
    end    
end    

modify_img1 = zeros(size(modify_img));
for i = 1:cc_image.NumObjects
    if(props_conn_comps(i,7)==1)
        modify_img1(cc_image.PixelIdxList{i}) = 1;
    end
end
figure;
imshowpair(modify_img,modify_img1,'montage');
toc;