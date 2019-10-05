% Genetic Algoritm V 1.0



% UNCOMMENT CLC and CLEAR 

% AXial ratio may be independent of frequency (scale up or down )  , but
% our system maps from 0.1 lambda to 0.5 lambda , so scaling has to be done
% manually . frequency cannot be changed retaining results 


%clear
%clc

%% controling paramters of the GA algortihm

M = 20; % number of chromosomes (cadinate solutions)% Better if even
N = 105;  % number of genes (variables)
MaxGen = 10;
Pc = 0.85;
Pm = 0.01;
Er = 0.05;
Frequency=9000; %in Mhz


%%  Initialization% Add Support for validation bit 


[ population ] = initialization(M, N);

for i = 1 : M
    population.Chromosomes(i).fitness = Fitness_Func( population.Chromosomes(i),Frequency);
     population.Chromosomes(i).Validation_Bit = 0;
end

g = 1;
disp(['Generation #' , num2str(g)]);

%% Main loop
for g = 2 : MaxGen
    disp(['Generation #' , num2str(g)]);
    
    for k = 1: 2: M
        % Selection
        [ parent1, parent2] = selection(population);
        
        % Crossover
        
        [child1 , child2] = crossover(parent1 , parent2, Pc, 'single');
        
        % Mutation
        
        [child1] = mutation(child1, Pm);
        [child2] = mutation(child2, Pm);
        
        newPopulation.Chromosomes(k).Gene = child1.Gene;
        newPopulation.Chromosomes(k+1).Gene = child2.Gene;
    end
    
    for i = 1 : M
        newPopulation.Chromosomes(i).fitness = Fitness_Func( newPopulation.Chromosomes(i),Frequency );
    end
    % Elitism
    [ newPopulation ] = elitism(population, newPopulation, Er);
    
    population = newPopulation;
    
end

for i = 1 : M
    population.Chromosomes(i).fitness = Fitness_Func( population.Chromosomes(i),Frequency );
end


disp('The best solution found is: ');

[max_val , indx] = sort([ population.Chromosomes(:).fitness ] , 'descend');

population.Chromosomes(indx(1)).Gene
population.Chromosomes(indx(1)).fitness

