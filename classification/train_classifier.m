function [ classifier ] = train_classifier( features_orig, features_forge, labels_orig, labels_forge )
% Trains a classifier
%	Based on labels and feature vectors, trains an SVM

display('Training classifier');

feature_vectors = [features_orig; features_forge];
labels = [labels_orig; labels_forge];

classifier = fitcsvm(feature_vectors, labels);

end

