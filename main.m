addpath('edison');
addpath('artist_data');
addpath('edge_maps');
addpath('edge_link');

edges = detect_edges('artist_data/A16983.ppm');
% imshow(edges);

[edgelist, labelededgeim] = edgelink(edges, 10);