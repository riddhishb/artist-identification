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

features_orig = extract_feature(im_orig);
[num_points_orig, ~] = size(features_orig);
rand50_orig = randperm(num_points_orig,floor(num_points_orig/2));
features_rand50_orig = features_orig(rand50_orig,:);
rand50_other_orig = zeros(num_points_orig - length(rand50_orig),1);
count = 1;
for i = 1:num_points_orig
    if(find(rand50_orig==i))
    else
        rand50_other_orig(count) = i;
        count= count + 1;
    end 
end    
labels_orig = ones(num_points_orig, 1);

features_forge = extract_feature(im_forge);
[num_points_forge, ~] = size(features_forge);
rand50_forge = randperm(num_points_forge,floor(num_points_forge/2));
features_rand50_forge = features_forge(rand50_forge,:);
rand50_other_forge = zeros(num_points_forge - length(rand50_forge),1);
count=1;
for i = 1:num_points_forge
    if(find(rand50_forge==i))
    else
        rand50_other_forge(count) = i;
        count= count + 1;
    end 
end 
labels_forge = zeros(num_points_forge, 1);

classifier = train_classifier(im_orig, im_forge);

test_feature_vectors = [];

test_classes = test_classifier(classifier, test_feature_vectors);
[num_classes, ~] = size(test_classes);
orig_classes = ones(num_classes, 1);

score = get_score(orig_classes, test_classes);
display(strcat('The score is ', num2str(score), '%'));

toc;