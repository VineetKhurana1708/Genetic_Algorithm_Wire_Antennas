function [Population]= Geometry_Validation(Population)
N=105;
M = length(Population.Chromosomes);
for i = 1 : M
    for j = 1 : N 
        Population.Chromosomes(i).Gene(j) = [ round( rand() ) ];
    end
end
global Inter;
Inter=0;
for a=1:M
    Cord=Converttoint(Population.Chromosomes(a));        
for j =1:5
    t=6-j;
for k=1:t
D3intersect(Cord(k,:),Cord(k+1,:),Cord(k+1+6-(7-j),:),Cord(k+1+6-(7-j)+1,:),j);
if(Inter==1)
     fprintf("Intersection");
     Population.Chromosomes(a).Valid=0;
    break;
end
end
if(Inter==1)
    break;
end
end
Population.Chromosomes(a).Valid=1;
end;
