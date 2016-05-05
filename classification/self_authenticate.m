function [ ] = self_authenticate( im_orig, im_forge )
%A test for the algorithm
%   Takes 50% of the feature vectors randomly and trains an SVM. Then takes the other 50% and calculates the score.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('Extracting positive features');
features_orig = extract_feature(im_orig);
[num_points_orig, ~] = size(features_orig);

rand50_orig_cache = 'cache/rand50_orig.mat';
if exist(rand50_orig_cache, 'file')
    load(rand50_orig_cache, 'rand50_orig');
else
    rand50_orig = randperm(num_points_orig,floor(num_points_orig/2));    
    save(rand50_orig_cache, 'rand50_orig');
end
first50_feats_orig = features_orig(rand50_orig,:); 
[num_first50_points_orig, ~] = size(first50_feats_orig);

rand50_other_orig_cache = 'cache/rand50_other_orig.mat';
if exist(rand50_other_orig_cache, 'file')
    load(rand50_other_orig_cache, 'rand50_other_orig');
else
    rand50_other_orig = zeros(num_points_orig - length(rand50_orig),1);
    count = 1;
    for i = 1:num_points_orig
        if(find(rand50_orig==i))
        else
            rand50_other_orig(count) = i;
            count= count + 1;
        end 
    end    
    save(rand50_other_orig_cache, 'rand50_other_orig');
end
next50_feats_orig = features_orig(rand50_other_orig, :); %save this

labels_orig = ones(num_first50_points_orig, 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display('Extracting negative features');
features_forge = extract_feature(im_forge);
[num_points_forge, ~] = size(features_forge);

rand50_forge_cache = 'cache/rand50_forge.mat';
if exist(rand50_forge_cache, 'file')
    load(rand50_forge_cache, 'rand50_forge');
else
    rand50_forge = randperm(num_points_forge,floor(num_points_forge/2));    
    save(rand50_forge_cache, 'rand50_forge');
end
first50_feats_forge = features_forge(rand50_forge,:); %save this
[num_first50_points_forge, ~] = size(first50_feats_forge);

rand50_other_forge_cache = 'cache/rand50_other_forge.mat';
if exist(rand50_other_forge_cache, 'file')
    load(rand50_other_forge_cache, 'rand50_other_forge');
else
    rand50_other_forge = zeros(num_points_forge - length(rand50_forge),1);
    count=1;
    for i = 1:num_points_forge
        if(find(rand50_forge==i))
        else
            rand50_other_forge(count) = i;
            count= count + 1;
        end 
    end     
    save(rand50_other_forge_cache, 'rand50_other_forge');
end
next50_feats_forge = features_forge(rand50_other_forge, :); %save this

labels_forge = zeros(num_first50_points_forge, 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

classifier = train_classifier(first50_feats_orig, first50_feats_forge, labels_orig, labels_forge);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_classes_orig = test_classifier(classifier, next50_feats_orig);

[num_classes_orig, ~] = size(test_classes_orig);
set_classes_orig = ones(num_classes_orig, 1);

score = get_score(test_classes_orig, set_classes_orig);
display(['The score for the original image is ' num2str(score) '%']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test_classes_forge = test_classifier(classifier, next50_feats_forge);

[num_classes_forge, ~] = size(test_classes_forge);
set_classes_forge = ones(num_classes_forge, 1);

score = get_score(test_classes_forge, set_classes_forge);
display(['The score is for the forged image is ' num2str(score) '%']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

