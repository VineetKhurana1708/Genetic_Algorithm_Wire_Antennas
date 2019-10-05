function Fit_Val = Fitness_Func(Chromosome,freq) 


MAT=Converttoint(Chromosome);

NEC_DATA= NEC(MAT,freq);



Fit_Val=max(NEC_DATA{1,6});% Sum of AR
end 