function [ ] = authenticate( im_orig, im_forge, im_test )
%Authenticates an image
%   Given an original and a forged image it extracts feature vectors out of these and trains an SVM. Then it extracts feature vectors out of the test image and calculates a score - percentage of correct labels

display('Extracting Features');

features_orig = extract_feature(im_orig);
[num_points_orig, ~] = size(features_orig);
labels_orig = ones(num_points_orig, 1);

features_forge = extract_feature(im_forge);
[num_points_forge, ~] = size(features_forge);
labels_forge = zeros(num_points_forge, 1);

features_test = extract_feature(im_test);
[num_points_test, ~] = size(features_test);
labels_test = ones(num_points_test, 1);

classifier = train_classifier(features_orig, features_forge, labels_orig, labels_forge);

classes = test_classifier(classifier, features_test);
score = get_score(classes, labels_test);

display(['The score is for the test image is ' num2str(score) '%']);

end

