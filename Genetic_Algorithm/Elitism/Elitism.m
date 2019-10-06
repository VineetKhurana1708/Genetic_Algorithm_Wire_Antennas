function [ New_Population ] = Elitism(Population, New_Population, Er)

M = length(Population.Chromosomes); % number of individuals 
Elite_no = round(M * Er);

[Max_Val , Indx] = sort([ Population.Chromosomes(:).Fitness ] , 'descend');
    
for k = 1 : Elite_no

    New_Population.Chromosomes(k).Gene  = Population.Chromosomes(Indx(k)).Gene;
    New_Population.Chromosomes(k).Fitness  = Population.Chromosomes(Indx(k)).Fitness;
    
end

for k = Elite_no + 1 :  length(Population.Chromosomes)
    New_Population.Chromosomes(k).Gene  = New_Population.Chromosomes(k).Gene;
    New_Population.Chromosomes(k).Fitness  = New_Population.Chromosomes(k).Fitness;
end

end