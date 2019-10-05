%Data will be stored in cell array Imported Data  after running this  
function Imported_Data= NEC(MAT,freq)%in Mhz

clc 
% Assumption: When all 5 bits are 1 , it corresponds to 0.5lambda , Source : Linden
% This assumption is used in Normalisation and AutoSegment



%Important: Code not working at higher frequencies due to loss of precision . Change to cm . 




N_Seg= 20 ;% Number of segments per wavelength , recommended 20 in NEC 
lambda = 300/freq;%in metres


%31 has 10 segments , is 0.5 lambda ......62 is lambda

ln=length(MAT);

input_vec(ln,7)=0;
input_vec(2:ln,2:4)=MAT(1:(ln-1),1:3);
input_vec(:,5:7)=MAT(:,1:3);

 input_vec=Autosegment(input_vec);

input_vec(:,2:7)= input_vec(:,2:7)*(lambda/62);%Normalisation



filename = 'buffer';
%input_vec= [0 0 0 -0.1 0 20 ;-0.1 0 20 1 0 20;1 0 20 16 0 50]; % Format is [x1,y1,z1,x2,y2,z2]in one row . Resembles inp file format

fid= fopen(strcat(filename,'.inp'),'w'); 


formatSpec = "CM Ex card is correct, errors can be bugs \r\nCE \r\nGW 1 %d %d %d %d %d %d %d  1.02e-3\r\n" + "GW 2 %d %d %d %d %d %d %d  1.02e-3\r\n"+"GW 3 %d %d %d %d %d %d %d  1.02e-3\r\n"+"GW 4 %d %d %d %d %d %d %d  1.02e-3\r\n"+"GW 5 %d %d %d %d %d %d %d  1.02e-3\r\n"+"GW 6 %d %d %d %d %d %d %d  1.02e-3\r\n"+"GW 7 %d %d %d %d %d %d %d  1.02e-3\r\n"+"GE 1\r\nGN 1 0\r\nEX 0 1 1 0 1 0\r\nFR 0 1 0 0 %d 0\r\nRP 0 19 73 1003 -90 0 5 5 ";


input_vec_trans=input_vec';

str = sprintf(formatSpec,input_vec_trans(:),freq);


fprintf(fid,str);
fclose(fid);



system(strcat('nec2++ -i ',strcat(filename,'.inp'))); % USes arg filename to call NEC .For example , system('nec2++ -i buff.inp')


fid=-1;% Sometimes MATLAB was unable to open this file when called after NEC , maybe because NEC hadnt finished processing the output yet . Hence this loop
while(fid==-1)
fid=fopen(strcat(filename,'.out'));
%pause(2);
end


skip=0;
pattern = "RADIATION PATTERNS";


 while(1)
 line_ex = fgetl(fid);
 
 if(contains(line_ex,pattern))
  break;   
 end
 skip=skip+1;
 end
 
 
 Imported_Data = textscan(fid,'%f %f %f %f %f %f %f %s %f %f %f %f','headerlines',3);%data starts after 3 field after Radiation pattern string appears
 
 
for i= 1:1:length(Imported_Data{1})%This post processsing is taking most of the time in the program , optimise this 
buff=isnan(str2double(Imported_Data{8}(i)));
if(buff==0)
Imported_Data{12}(i)=Imported_Data{11}(i);
Imported_Data{11}(i)=Imported_Data{10}(i);
Imported_Data{10}(i)=Imported_Data{9}(i);
Imported_Data{9}(i)=str2double(Imported_Data{8}(i));
Imported_Data{8}(i)=cellstr(" ");
end
end


fclose(fid);
end
