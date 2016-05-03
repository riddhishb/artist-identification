function [ classifier ] = train_classifier( features_orig, features_forge, labels_orig, labels_forge )
% Trains a classifier

display('Training classifier');

feature_vectors = [features_orig; features_forge];
labels = [labels_orig; labels_forge];

classifier = fitcsvm(feature_vectors, labels);

end

