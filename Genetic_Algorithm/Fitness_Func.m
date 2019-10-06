function Fit_Val = Fitness_Func(Chromosome,freq)


MAT=Converttoint(Chromosome);

[error,NEC_DATA]= NEC(MAT,freq);

if(error==0)
    Fit_Val=max(NEC_DATA{1,6});% Max of AR
end

if(error==1)
    Fit_Val=0;
end

end