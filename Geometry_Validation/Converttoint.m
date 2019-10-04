function[Cord]=Converttoint(Chromosome)
x=0;
Cord1=zeros(1,5);
Cord=zeros(7,3);
      for u=0:5:100
          if (rem(u,3)==0)
              x=x+1;
          end;
          for t=1+u:5+u
            Cord1(1,t-u)=Chromosome.Gene(t);
          end;
          Intval=(power(2,4)*Cord1(1,1))+(power(2,3)*Cord1(1,2))+(power(2,2)*Cord1(1,3))+(power(2,1)*Cord1(1,4))+(power(2,0)*Cord1(1,5));
          z=rem(t/5,3);
          if z==0
              z=3;
          end;
          Cord(x,z)=Intval;
      end;