function [FinalFitness  ] = gafunc(MaxGen,M,Pc,Pm,Er,Frequency)
% Genetic Algoritm V 1.0



% UNCOMMENT CLC and CLEAR 

% AXial ratio may be independent of frequency (scale up or down )  , but
% our system maps from 0.1 lambda to 0.5 lambda , so scaling has to be done
% manually . frequency cannot be changed retaining results 


%clear
%clc

%% controling paramters of the GA algortihm

N = 105;  % number of genes (variables)



%%  Initialization% Add Support for validation bit 


[ Population ] = Initialization(M, N);

for i = 1 : M
    Population.Chromosomes(i).Fitness = Fitness_Func( Population.Chromosomes(i),Frequency);
     Population.Chromosomes(i).Validation_Bit = 0;
end

g = 1;
disp(['Generation #' , num2str(g)]);

%% Main loop
for g = 2 : MaxGen
    disp(['Generation #' , num2str(g)]);
    
    for k = 1: 2: M
        % Selection
        [ parent1, parent2] = Selection(Population);
        
        % Crossover
        
        [child1 , child2] = Crossover(parent1 , parent2, Pc, 'single');
        
        % Mutation
        
        [child1] = Mutation(child1, Pm);
        [child2] = Mutation(child2, Pm);
        
        New_Population.Chromosomes(k).Gene = child1.Gene;
        New_Population.Chromosomes(k+1).Gene = child2.Gene;
    end
    
    for i = 1 : M
        New_Population.Chromosomes(i).Fitness = Fitness_Func( New_Population.Chromosomes(i),Frequency );
    end
    % Elitism
    [ New_Population ] = Elitism(Population, New_Population, Er);
    
    Population = New_Population;
    
end

for i = 1 : M
    Population.Chromosomes(i).Fitness = Fitness_Func( Population.Chromosomes(i),Frequency );
end


disp('The best solution found is: ');

[max_val , indx] = sort([ Population.Chromosomes(:).Fitness ] , 'descend');

Population.Chromosomes(indx(1)).Gene
FinalFitness=Population.Chromosomes(indx(1)).Fitness