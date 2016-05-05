function [ score ] = get_score( orig, test )
%Calculates a likeliness score
%   Percentage of correctly matched labels

[num_elements, ~] = size(orig);

matches = 0;

for i = 1:num_elements;
    if orig(i) == test(i);
        matches = matches + 1;
    end;
end;

score = (matches/num_elements)*100;

end

