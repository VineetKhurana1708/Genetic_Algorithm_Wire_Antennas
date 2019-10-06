function[axialmatrix]=axialratio(Imported_Data)
axialmatrix=zeros(74,20)
theta=Imported_Data{1,1}
phi=Imported_Data{1,2}
num1=zeros(1,20);
num2=zeros(74,1);
for s= 1:19
    num1(1,s+1)=theta(s,1);
end;
for p=1:73
    k=(p-1)*19;
    num2(p+1,1)=phi(1+k,1);
end;
    
axial=Imported_Data{1,6}
num=zeros(1,20)
for i = 2:74
    k=(i-2)*19;
    for j=1:19
        t=j+k;
        num(1,j+1)=axial(t,1);
    axialmatrix(i,:)=num;
    end;
end;
axialmatrix(1,:)=num1;
axialmatrix(:,1)=num2;



