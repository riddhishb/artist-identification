function [ ] = authenticate( im_orig, im_forge )
%AUTHENTICATE Summary of this function goes here
%   Detailed explanation goes here

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('Extracting positive features');
features_orig = extract_feature(im_orig);
[num_points_orig, ~] = size(features_orig);

rand50_orig = randperm(num_points_orig,floor(num_points_orig/2));
first50_feats_orig = features_orig(rand50_orig,:);
[num_first50_points_orig, ~] = size(first50_feats_orig);

rand50_other_orig = zeros(num_points_orig - length(rand50_orig),1);
count = 1;
for i = 1:num_points_orig
    if(find(rand50_orig==i))
    else
        rand50_other_orig(count) = i;
        count= count + 1;
    end 
end
next50_feats_orig = features_orig(rand50_other_orig, :);

labels_orig = ones(num_first50_points_orig, 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('Extracting negative features');
features_forge = extract_feature(im_forge);
[num_points_forge, ~] = size(features_forge);

rand50_forge = randperm(num_points_forge,floor(num_points_forge/2));
first50_feats_forge = features_forge(rand50_forge,:);
[num_first50_points_forge, ~] = size(first50_feats_forge);

rand50_other_forge = zeros(num_points_forge - length(rand50_forge),1);
count=1;
for i = 1:num_points_forge
    if(find(rand50_forge==i))
    else
        rand50_other_forge(count) = i;
        count= count + 1;
    end 
end 
next50_feats_forge = features_forge(rand50_other_forge, :);

labels_forge = zeros(num_first50_points_forge, 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classifier = train_classifier(first50_feats_orig, first50_feats_forge, labels_orig, labels_forge);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_classes_orig = test_classifier(classifier, next50_feats_orig);

[num_classes_orig, ~] = size(test_classes_orig);
set_classes_orig = ones(num_classes_orig, 1);

score = get_score(test_classes_orig, set_classes_orig);
display(strcat('The score for the original image is ', num2str(score), '%'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_classes_forge = test_classifier(classifier, next50_feats_forge);

[num_classes_forge, ~] = size(test_classes_forge);
set_classes_forge = ones(num_classes_forge, 1);

score = get_score(test_classes_forge, set_classes_forge);
display(strcat('The score is for the forged image is ', num2str(score), '%'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

