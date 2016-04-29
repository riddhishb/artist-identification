function [ class ] = test_classifier( classifier, feature_vector )
% Tests a given classifier

class = predict(classifier, feature_vector);

end

