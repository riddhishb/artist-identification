addpath('edison');
addpath('artist_data');
addpath('edge_maps');

edges = detect_edges('artist_data/A16983.ppm');
imshow(edges);