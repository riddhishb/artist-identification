close all; 
clc;

addpath('edison');
addpath('artist_data');
addpath('edge_maps');
addpath('edge_link');
addpath('classification');

tic;

im_orig = 'artist_data/original_up.ppm';
im_forge = 'artist_data/forged_up.ppm';

classifier = train_classifier(im_orig, im_forge);

probe_im = 'artist_data/original_down.ppm';

test_classes = test_classifier(classifier, probe_im);
[num_classes, ~] = size(test_classes);
orig_classes = ones(num_classes, 1);

score = get_score(orig_classes, test_classes);
display(strcat('The score is ', num2str(score), '%'));

toc;