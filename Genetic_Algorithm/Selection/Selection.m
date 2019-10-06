function [parent1, parent2] = Selection(Population)

M = length(Population.Chromosomes(:));

normalized_Fitness = [Population.Chromosomes(:).Fitness] ./ sum([Population.Chromosomes(:).Fitness]);

[sorted_fintness_values , sorted_idx] = sort(normalized_Fitness , 'descend');

for i = 1 : length(Population.Chromosomes)
    temp_population.Chromosomes(i).Gene = Population.Chromosomes(sorted_idx(i)).Gene;
    temp_population.Chromosomes(i).Fitness = Population.Chromosomes(sorted_idx(i)).Fitness;
    temp_population.Chromosomes(i).normalized_Fitness = normalized_Fitness(sorted_idx(i));
end


cumsum = zeros(1 , M);

for i = 1 : M
    for j = i : M
        cumsum(i) = cumsum(i) + temp_population.Chromosomes(j).normalized_Fitness;
    end
end


R = rand(); % in [0,1]
parent1_idx = M;
for i = 1: length(cumsum)
    if R > cumsum(i)
        parent1_idx = i - 1;
        break;
    end
end

parent2_idx = parent1_idx;

while parent2_idx == parent1_idx
    R = rand(); % in [0,1]

    for i = 1: length(cumsum)
        if R > cumsum(i)
            parent2_idx = i - 1;
            break;
        end
    end
end

parent1 = temp_population.Chromosomes(parent1_idx);
parent2 = temp_population.Chromosomes(parent2_idx);

end