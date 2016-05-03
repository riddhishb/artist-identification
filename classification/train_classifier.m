function [ classifier ] = train_classifier( im_orig, im_forge )
% Trains a classifier

display('Extracting features and training classifier');

features_orig = extract_feature(im_orig);
[num_points_orig, ~] = size(features_orig);
labels_orig = ones(num_points_orig, 1);

features_forge = extract_feature(im_forge);
[num_points_forge, ~] = size(features_forge);
labels_forge = zeros(num_points_forge, 1);

feature_vectors = [features_orig; features_forge];
labels = [labels_orig; labels_forge];

classifier = fitcsvm(feature_vectors, labels);

display('Classifier trained');

end

