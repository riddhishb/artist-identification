function [ classes ] = test_classifier( classifier, feature_vectors )
% Tests a given classifier
%	Predicts the classes for a matrix of feature vectors

display('Getting classes');

% feature_vectors = extract_feature(in_im);

[num_fv, num_points] = size(feature_vectors);

classes = zeros(num_points, 1);

for i = 1:num_fv;
    class = predict(classifier, feature_vectors(i, :));
    classes(i) = class;
end;

end

