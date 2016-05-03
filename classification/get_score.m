function [ score ] = get_score( orig, test )
%GET_SCORE Summary of this function goes here
%   Detailed explanation goes here

[num_elements, ~] = size(orig);

matches = 0;

for i = 1:num_elements;
    if orig(i) == test(i);
        matches = matches + 1;
    end;
end;

score = (matches/num_elements)*100;

end

