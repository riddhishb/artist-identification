close all; 
clc;

addpath('edison');
addpath('artist_data');
addpath('edge_maps');
addpath('edge_link');
addpath('classification');
addpath('cache');

tic;

im_orig = 'artist_data/original.ppm';
im_forge = 'artist_data/forgery.ppm';
im_test = 'artist_data/test_gogh.ppm';
im_test_forge = 'artist_data/test_forge.ppm';

% self_authenticate(im_orig, im_forge);
% authenticate(im_orig, im_forge, im_test);
% authenticate(im_orig, im_forge, im_test_forge);

toc;