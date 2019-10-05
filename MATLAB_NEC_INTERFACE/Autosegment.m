function SEG_MAT = Autosegment(UNSEG_MAT)


SEG_MAT=UNSEG_MAT;
SEG_MAT(:,1)=(     (  UNSEG_MAT(:,5) - UNSEG_MAT(:,2) ).^2  +    (  UNSEG_MAT(:,6) - UNSEG_MAT(:,3) ).^2   +     (  UNSEG_MAT(:,7) - UNSEG_MAT(:,4) ).^2       ).^0.5;  


SEG_MAT(:,1)=1+round(SEG_MAT(:,1)*(10/31)); % lambda/2 * 1/2^n-1


end