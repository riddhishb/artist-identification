close all; 
clc;

addpath('edison');
addpath('artist_data');
addpath('edge_maps');
addpath('edge_link');
addpath('classification');

tic;

im_orig = 'artist_data/original.ppm';
im_forge = 'artist_data/forgery.ppm';

authenticate(im_orig, im_forge);

toc;