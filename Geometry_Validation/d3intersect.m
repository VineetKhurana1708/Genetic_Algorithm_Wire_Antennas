
function d3intersect(A,B,C,D,j)
%A=[1, 4, -2];%[x1,y1,z1] of point A of Line1
%B=[3 8 6];%[x2,y2,z2] of point B of Line1
BA= B-A;    %distance between each x, y & z of A and B
%C=[1, 4, -2];D=[3,8,6];
DC=D-C;
syms t s;
equ1=A+t*BA;
equ2=C+s*DC;
eqns = [equ1(1,1) == equ2(1,1), equ1(1,2) == equ2(1,2)];
S = solve(eqns);
sol = [S.t; S.s]; %S.t and S.s are the values of parameter 't' and
equ1=A+S.t*BA
equ2=C+S.s*DC
if(j==1)
if(equ1==equ2)&(equ1~=B)
    global inter;
    inter=1;
end;
else
    if(equ1==equ2)
    global inter;
    inter=1;
    end;
end;

    
