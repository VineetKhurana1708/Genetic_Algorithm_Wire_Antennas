function [ Population ] = Initialization(M, N)

for i = 1 : M
    for j = 1 : N 
        Population.Chromosomes(i).Gene(j) = [ round( rand() ) ];
    end
end

