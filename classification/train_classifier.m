function [ classifier ] = train_classifier( features )
% Trains a classifier

feature_vectors = features(:, 1:end-1);
labels = features(:, end);

classifier = fitcsvm(feature_vectors, labels);

end

